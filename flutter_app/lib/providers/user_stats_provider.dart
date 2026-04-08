import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserStats {
  final int matchesPlayed;
  final int wins;
  final int totalCorrect;
  final int totalQuestions;
  final int bestRank;
  final int bestStreak;
  final int totalScore;
  final double avgResponseTimeSecs;
  final double avgRank; // cumulative average rank

  const UserStats({
    this.matchesPlayed = 0,
    this.wins = 0,
    this.totalCorrect = 0,
    this.totalQuestions = 0,
    this.bestRank = 0,
    this.bestStreak = 0,
    this.totalScore = 0,
    this.avgResponseTimeSecs = 0.0,
    this.avgRank = 0.0,
  });

  double get accuracy =>
      totalQuestions > 0 ? (totalCorrect / totalQuestions) * 100 : 0.0;
}

final userStatsProvider =
    StateNotifierProvider<UserStatsNotifier, UserStats>((ref) {
  return UserStatsNotifier();
});

class UserStatsNotifier extends StateNotifier<UserStats> {
  UserStatsNotifier() : super(const UserStats());

  void recordMatch({
    required int rank,
    required int correctAnswers,
    required int totalQuestions,
    required int score,
    required double avgResponseTimeSecs,
    required int streak,
  }) {
    final newMatchesPlayed = state.matchesPlayed + 1;
    final newWins = state.wins + (rank == 1 ? 1 : 0);
    final newTotalCorrect = state.totalCorrect + correctAnswers;
    final newTotalQuestions = state.totalQuestions + totalQuestions;
    final newBestRank = state.bestRank == 0
        ? rank
        : (rank < state.bestRank ? rank : state.bestRank);
    final newBestStreak =
        streak > state.bestStreak ? streak : state.bestStreak;
    final newTotalScore = state.totalScore + score;
    final newAvgResponse = state.matchesPlayed == 0
        ? avgResponseTimeSecs
        : (state.avgResponseTimeSecs * state.matchesPlayed +
                avgResponseTimeSecs) /
            newMatchesPlayed;
    final newAvgRank = state.matchesPlayed == 0
        ? rank.toDouble()
        : (state.avgRank * state.matchesPlayed + rank) / newMatchesPlayed;

    state = UserStats(
      matchesPlayed: newMatchesPlayed,
      wins: newWins,
      totalCorrect: newTotalCorrect,
      totalQuestions: newTotalQuestions,
      bestRank: newBestRank,
      bestStreak: newBestStreak,
      totalScore: newTotalScore,
      avgResponseTimeSecs: newAvgResponse,
      avgRank: newAvgRank,
    );
  }

  void reset() {
    state = const UserStats();
  }
}
