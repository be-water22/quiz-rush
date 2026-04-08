import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../models/player.dart';
import '../../providers/matchmaking_provider.dart';
import '../../providers/user_stats_provider.dart';
import '../../widgets/player_avatar.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final stats = ref.watch(userStatsProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.background,
              Color(0xFF1A1A2E),
              Color(0xFF0F3460),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  // Top bar
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => context.go('/matchmaking'),
                          icon: const Icon(Icons.arrow_back,
                              color: Colors.white),
                        ),
                        const Expanded(
                          child: Text(
                            'Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),

                  // Avatar & Name
                  PlayerAvatar(
                    initial: user.initial,
                    colorIndex: 0,
                    size: 80,
                    borderColor: AppColors.accent,
                    borderWidth: 3,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Quick stats row
                  Row(
                    children: [
                      _QuickStat(
                        label: 'Matches',
                        value: '${stats.matchesPlayed}',
                        icon: Icons.sports_esports,
                      ),
                      const SizedBox(width: 12),
                      _QuickStat(
                        label: 'Wins',
                        value: '${stats.wins}',
                        icon: Icons.emoji_events,
                        valueColor: AppColors.gold,
                      ),
                      const SizedBox(width: 12),
                      _QuickStat(
                        label: 'Avg Rank',
                        value: stats.matchesPlayed > 0
                            ? '#${stats.avgRank.toStringAsFixed(1)}'
                            : '-',
                        icon: Icons.trending_up,
                        valueColor: AppColors.success,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Detailed stats
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PERFORMANCE',
                          style: TextStyle(
                            color: AppColors.textTertiary,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 18),
                        _StatRow(
                          label: 'Accuracy',
                          value: '${stats.accuracy.toStringAsFixed(1)}%',
                          icon: Icons.gps_fixed,
                          showBar: true,
                          barValue: stats.accuracy / 100,
                          barColor: AppColors.success,
                        ),
                        const SizedBox(height: 18),
                        _StatRow(
                          label: 'Best Rank',
                          value: stats.bestRank > 0
                              ? '#${stats.bestRank}'
                              : '-',
                          icon: Icons.leaderboard,
                        ),
                        const SizedBox(height: 18),
                        _StatRow(
                          label: 'Best Streak',
                          value: '${stats.bestStreak}',
                          icon: Icons.local_fire_department,
                          valueColor: AppColors.gold,
                        ),
                        const SizedBox(height: 18),
                        _StatRow(
                          label: 'Total Score',
                          value: '${stats.totalScore}',
                          icon: Icons.stars,
                        ),
                        const SizedBox(height: 18),
                        _StatRow(
                          label: 'Avg Response',
                          value: stats.matchesPlayed > 0
                              ? '${stats.avgResponseTimeSecs.toStringAsFixed(1)}s'
                              : '-',
                          icon: Icons.speed,
                        ),
                        const SizedBox(height: 18),
                        _StatRow(
                          label: 'Questions Answered',
                          value:
                              '${stats.totalCorrect}/${stats.totalQuestions}',
                          icon: Icons.help_outline,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Action buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.go('/matchmaking'),
                      child: const Text('Play Now'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        ref.read(userStatsProvider.notifier).reset();
                        ref.read(currentUserProvider.notifier).state =
                            const Player(
                          userId: 'current-user',
                          username: 'You',
                        );
                        context.go('/');
                      },
                      child: const Text('Logout'),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;

  const _QuickStat({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.textTertiary, size: 20),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: valueColor ?? Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;
  final bool showBar;
  final double barValue;
  final Color barColor;

  const _StatRow({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
    this.showBar = false,
    this.barValue = 0.0,
    this.barColor = AppColors.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.textTertiary, size: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: valueColor ?? Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        if (showBar) ...[
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: barValue.clamp(0.0, 1.0),
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
              minHeight: 4,
            ),
          ),
        ],
      ],
    );
  }
}
