import 'player.dart';
import 'question.dart';
import 'leaderboard_entry.dart';

enum MatchStatus {
  idle,
  searching,
  found,
  inProgress,
  roundResult,
  finished,
}

class MatchmakingState {
  final MatchStatus status;
  final List<Player> foundPlayers;
  final int etaSeconds;
  final String? roomId;
  final int totalRounds;

  const MatchmakingState({
    this.status = MatchStatus.idle,
    this.foundPlayers = const [],
    this.etaSeconds = 15,
    this.roomId,
    this.totalRounds = 5,
  });

  MatchmakingState copyWith({
    MatchStatus? status,
    List<Player>? foundPlayers,
    int? etaSeconds,
    String? roomId,
    int? totalRounds,
  }) {
    return MatchmakingState(
      status: status ?? this.status,
      foundPlayers: foundPlayers ?? this.foundPlayers,
      etaSeconds: etaSeconds ?? this.etaSeconds,
      roomId: roomId ?? this.roomId,
      totalRounds: totalRounds ?? this.totalRounds,
    );
  }
}

class GameState {
  final String roomId;
  final int currentRound;
  final int totalRounds;
  final Question? currentQuestion;
  final int? selectedAnswerIndex;
  final bool? answerCorrect;
  final int score;
  final int position;
  final int remainingSeconds;
  final List<LeaderboardEntry> leaderboard;
  final MatchResult? matchResult;

  const GameState({
    required this.roomId,
    this.currentRound = 0,
    this.totalRounds = 5,
    this.currentQuestion,
    this.selectedAnswerIndex,
    this.answerCorrect,
    this.score = 0,
    this.position = 0,
    this.remainingSeconds = 15,
    this.leaderboard = const [],
    this.matchResult,
  });

  GameState copyWith({
    String? roomId,
    int? currentRound,
    int? totalRounds,
    Question? currentQuestion,
    int? selectedAnswerIndex,
    bool? answerCorrect,
    int? score,
    int? position,
    int? remainingSeconds,
    List<LeaderboardEntry>? leaderboard,
    MatchResult? matchResult,
    bool clearAnswer = false,
  }) {
    return GameState(
      roomId: roomId ?? this.roomId,
      currentRound: currentRound ?? this.currentRound,
      totalRounds: totalRounds ?? this.totalRounds,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      selectedAnswerIndex: clearAnswer ? null : (selectedAnswerIndex ?? this.selectedAnswerIndex),
      answerCorrect: clearAnswer ? null : (answerCorrect ?? this.answerCorrect),
      score: score ?? this.score,
      position: position ?? this.position,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      leaderboard: leaderboard ?? this.leaderboard,
      matchResult: matchResult ?? this.matchResult,
    );
  }
}

class MatchResult {
  final String winnerUserId;
  final String winnerUsername;
  final List<FinalStanding> standings;

  const MatchResult({
    required this.winnerUserId,
    required this.winnerUsername,
    required this.standings,
  });
}

class FinalStanding {
  final String userId;
  final String username;
  final int finalScore;
  final int rank;
  final int correctAnswers;
  final int avgResponseTimeMs;

  const FinalStanding({
    required this.userId,
    required this.username,
    required this.finalScore,
    required this.rank,
    this.correctAnswers = 0,
    this.avgResponseTimeMs = 0,
  });
}

class GameStats {
  final double accuracy;
  final double avgSpeedSeconds;
  final int bestStreak;
  final int score;
  final int rank;
  final int xpEarned;
  final int currentLevel;

  const GameStats({
    this.accuracy = 0.0,
    this.avgSpeedSeconds = 0.0,
    this.bestStreak = 0,
    this.score = 0,
    this.rank = 0,
    this.xpEarned = 0,
    this.currentLevel = 1,
  });
}
