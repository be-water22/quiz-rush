import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../providers/game_provider.dart';
import '../../providers/matchmaking_provider.dart';
import '../../models/leaderboard_entry.dart';
import '../../widgets/player_avatar.dart';
import '../../widgets/rank_badge.dart';

class LeaderboardScreen extends ConsumerStatefulWidget {
  final String matchId;

  const LeaderboardScreen({super.key, required this.matchId});

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _countdownController;

  @override
  void initState() {
    super.initState();
    _countdownController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final game = ref.watch(gameProvider);
    final currentUser = ref.watch(currentUserProvider);

    // Listen for next question or match end
    ref.listen(gameProvider, (previous, next) {
      if (next == null) return;
      if (next.matchResult != null && previous?.matchResult == null) {
        context.go('/results/${widget.matchId}');
      }
      // If a new question comes in, go back to gameplay
      if (next.currentQuestion != previous?.currentQuestion &&
          next.currentQuestion != null &&
          next.currentRound > (previous?.currentRound ?? 0)) {
        context.go('/game/${widget.matchId}');
      }
    });

    if (game == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final entries = game.leaderboard;
    final top3 = entries.where((e) => e.rank <= 3).toList();
    final rest = entries.where((e) => e.rank > 3).toList();

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          children: [
            // Header
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                child: Column(
                  children: [
                    Text(
                      'Round ${game.currentRound} Results',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Leaderboard updated',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Podium top 3
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: top3.map((entry) => _PodiumCard(entry: entry)).toList(),
              ),
            ),

            // Divider
            Container(
              height: 1,
              margin: const EdgeInsets.fromLTRB(24, 16, 24, 12),
              color: Colors.white.withOpacity(0.06),
            ),

            // Remaining players
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: rest.length,
                itemBuilder: (context, index) {
                  final entry = rest[index];
                  final isCurrentUser = entry.userId == currentUser.userId;
                  return _PlayerRow(
                    entry: entry,
                    isCurrentUser: isCurrentUser,
                  );
                },
              ),
            ),

            // Next round countdown
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _countdownController,
                    builder: (context, child) {
                      final remaining = (5 * (1 - _countdownController.value)).ceil();
                      return RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            const TextSpan(text: 'Next round in '),
                            TextSpan(
                              text: '${remaining}s',
                              style: const TextStyle(
                                color: AppColors.gold,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: AnimatedBuilder(
                      animation: _countdownController,
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          value: 1 - _countdownController.value,
                          backgroundColor: Colors.white.withOpacity(0.1),
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.gold),
                          minHeight: 4,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PodiumCard extends StatelessWidget {
  final LeaderboardEntry entry;

  const _PodiumCard({required this.entry});

  Color get _medalColor {
    switch (entry.rank) {
      case 1: return AppColors.gold;
      case 2: return AppColors.silver;
      case 3: return AppColors.bronze;
      default: return Colors.white.withOpacity(0.2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _medalColor.withOpacity(0.15),
            _medalColor.withOpacity(0.05),
          ],
        ),
        border: Border.all(color: _medalColor.withOpacity(0.3), width: 1.5),
      ),
      child: Row(
        children: [
          RankBadge(rank: entry.rank),
          const SizedBox(width: 14),
          PlayerAvatar(
            initial: entry.username.isNotEmpty ? entry.username[0] : '?',
            colorIndex: entry.rank - 1,
            size: 40,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (entry.rankChange != 0)
                  Row(
                    children: [
                      Icon(
                        entry.rankChange > 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: entry.rankChange > 0 ? AppColors.success : AppColors.accent,
                        size: 16,
                      ),
                      Text(
                        '${entry.rankChange.abs()} position',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.45),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${entry.score} ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: 'pts',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerRow extends StatelessWidget {
  final LeaderboardEntry entry;
  final bool isCurrentUser;

  const _PlayerRow({required this.entry, this.isCurrentUser = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isCurrentUser ? AppColors.accent.withOpacity(0.08) : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: isCurrentUser
            ? Border.all(color: AppColors.accent.withOpacity(0.4), width: 1.5)
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '${entry.rank}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 14),
          PlayerAvatar(
            initial: entry.username.isNotEmpty ? entry.username[0] : '?',
            colorIndex: entry.rank - 1,
            size: 36,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      entry.username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (isCurrentUser)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'YOU',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${entry.score} ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: 'pts',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.35),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
