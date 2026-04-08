import 'dart:async';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import '../../generated/quiz/v1/quiz.pbgrpc.dart' as qpb;
import '../../models/question.dart';
import '../../models/leaderboard_entry.dart';
import '../../models/game_state.dart';
import 'quiz_client.dart';

/// Real gRPC quiz client that talks to the backend server.
class RealQuizGrpcClient extends QuizGrpcClient {
  late final qpb.QuizServiceClient _stub;

  RealQuizGrpcClient(ClientChannel channel) : super(channel) {
    _stub = qpb.QuizServiceClient(channel);
  }

  @override
  Future<bool> submitAnswer({
    required String roomId,
    required String userId,
    required int selectedIndex,
    required int responseTimeMs,
    required int round,
    required String questionId,
  }) async {
    final ack = await _stub.submitAnswer(qpb.AnswerRequest()
      ..roomId = roomId
      ..userId = userId
      ..questionId = questionId
      ..selectedIndex = selectedIndex
      ..responseTimeMs = Int64(responseTimeMs)
      ..round = round);
    return ack.accepted;
  }

  @override
  Stream<GameEventData> streamGameEvents(String roomId, String userId) async* {
    final stream = _stub.streamGameEvents(qpb.StreamRequest()
      ..roomId = roomId
      ..userId = userId
      ..lastSeenRound = 0);

    await for (final event in stream) {
      if (event.hasQuestion()) {
        final q = event.question;
        yield GameEventData.questionBroadcast(Question(
          questionId: q.questionId,
          text: q.text,
          options: q.options.toList(),
          difficulty: q.difficulty,
          timeLimitSecs: q.timeLimitSecs,
          round: q.round,
        ));
      } else if (event.hasTimerSync()) {
        yield GameEventData.timerSync(
          round: event.timerSync.round,
          remainingSecs: event.timerSync.remainingSecs,
        );
      } else if (event.hasRoundResult()) {
        final rr = event.roundResult;
        yield GameEventData.roundResult(
          round: rr.round,
          correctIndex: rr.correctOptionIndex,
        );
      } else if (event.hasLeaderboard()) {
        final lb = event.leaderboard;
        yield GameEventData.leaderboardUpdate(
          entries: lb.entries.map((e) => LeaderboardEntry(
            userId: e.userId,
            username: e.username,
            score: e.score,
            rank: e.rank,
          )).toList(),
          afterRound: lb.afterRound,
        );
      } else if (event.hasMatchEnd()) {
        final me = event.matchEnd;
        yield GameEventData.matchEnd(
          roomId: me.roomId,
          winnerUserId: me.winnerUserId,
          winnerUsername: me.winnerUsername,
          standings: me.standings.map((s) => FinalStanding(
            userId: s.userId,
            username: s.username,
            finalScore: s.finalScore,
            rank: s.rank,
            correctAnswers: s.correctAnswers,
            avgResponseTimeMs: s.avgResponseTimeMs.toInt(),
          )).toList(),
        );
      }
    }
  }

  // Not used in real mode - correctness comes from server
  @override
  int? getCorrectIndex(int round) => null;

  @override
  void setOpponents(List<String> opponentIds, List<String> opponentNames, {String userName = 'You'}) {
    // No-op in real mode - server handles opponents
  }
}
