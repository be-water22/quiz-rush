import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_state.dart';
import '../models/leaderboard_entry.dart';
import '../services/grpc/quiz_client.dart';
import 'grpc_providers.dart';
import 'matchmaking_provider.dart';

final gameProvider = StateNotifierProvider<GameNotifier, GameState?>((ref) {
  final client = ref.watch(quizClientProvider);
  final user = ref.watch(currentUserProvider);
  return GameNotifier(client, user.userId);
});

class GameNotifier extends StateNotifier<GameState?> {
  final QuizGrpcClient _client;
  final String _userId;
  StreamSubscription? _subscription;
  Timer? _countdownTimer;

  GameNotifier(this._client, this._userId) : super(null);

  void startGame(String roomId, int totalRounds, {List<String> opponentIds = const [], List<String> opponentNames = const []}) {
    state = GameState(roomId: roomId, totalRounds: totalRounds);

    // Set opponents for this match
    if (opponentIds.isNotEmpty) {
      _client.setOpponents(opponentIds, opponentNames);
    }

    _subscription = _client.streamGameEvents(roomId, _userId).listen(
      (event) {
        switch (event.type) {
          case GameEventType.questionBroadcast:
            _onQuestionBroadcast(event);
            break;
          case GameEventType.timerSync:
            _onTimerSync(event);
            break;
          case GameEventType.roundResult:
            _onRoundResult(event);
            break;
          case GameEventType.leaderboardUpdate:
            _onLeaderboardUpdate(event);
            break;
          case GameEventType.matchEnd:
            _onMatchEnd(event);
            break;
          case GameEventType.playerJoined:
            break;
        }
      },
      onError: (e) {
        // Handle stream error
      },
    );
  }

  void _onQuestionBroadcast(GameEventData event) {
    _countdownTimer?.cancel();
    state = state?.copyWith(
      currentRound: event.round ?? state!.currentRound,
      currentQuestion: event.question,
      remainingSeconds: event.question?.timeLimitSecs ?? 15,
      clearAnswer: true,
    );
    _startCountdown();
  }

  void _onTimerSync(GameEventData event) {
    if (event.remainingSecs != null) {
      state = state?.copyWith(remainingSeconds: event.remainingSecs);
    }
  }

  void _onRoundResult(GameEventData event) {
    _countdownTimer?.cancel();
    // Mark the correct answer
    if (state?.selectedAnswerIndex != null && event.correctIndex != null) {
      state = state?.copyWith(
        answerCorrect: state?.selectedAnswerIndex == event.correctIndex,
      );
    }
  }

  void _onLeaderboardUpdate(GameEventData event) {
    if (event.leaderboardEntries != null) {
      // Find current user's score and position
      int score = state?.score ?? 0;
      int position = state?.position ?? 0;
      for (final entry in event.leaderboardEntries!) {
        if (entry.userId == _userId) {
          score = entry.score;
          position = entry.rank;
          break;
        }
      }
      state = state?.copyWith(
        leaderboard: event.leaderboardEntries,
        score: score,
        position: position,
      );
    }
  }

  void _onMatchEnd(GameEventData event) {
    _countdownTimer?.cancel();
    _subscription?.cancel();
    state = state?.copyWith(
      matchResult: MatchResult(
        winnerUserId: event.winnerUserId ?? '',
        winnerUsername: event.winnerUsername ?? '',
        standings: event.standings ?? [],
      ),
    );
  }

  void selectAnswer(int index) {
    if (state?.selectedAnswerIndex != null) return; // Already answered
    state = state?.copyWith(selectedAnswerIndex: index);

    // Submit to server
    if (state?.currentQuestion != null) {
      final responseTime = ((state!.currentQuestion!.timeLimitSecs - state!.remainingSeconds) * 1000);
      _client.submitAnswer(
        roomId: state!.roomId,
        userId: _userId,
        questionId: state!.currentQuestion!.questionId,
        selectedIndex: index,
        responseTimeMs: responseTime,
        round: state!.currentRound,
      );
    }
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state == null || state!.remainingSeconds <= 0) {
        timer.cancel();
        return;
      }
      state = state?.copyWith(remainingSeconds: state!.remainingSeconds - 1);
    });
  }

  void reset() {
    _countdownTimer?.cancel();
    _subscription?.cancel();
    state = null;
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _subscription?.cancel();
    super.dispose();
  }
}
