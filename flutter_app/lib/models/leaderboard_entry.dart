class LeaderboardEntry {
  final String userId;
  final String username;
  final int score;
  final int rank;
  final int rankChange; // +1 moved up, -1 moved down, 0 unchanged

  const LeaderboardEntry({
    required this.userId,
    required this.username,
    required this.score,
    required this.rank,
    this.rankChange = 0,
  });
}
