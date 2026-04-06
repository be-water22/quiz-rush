import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../providers/game_provider.dart';
import '../../providers/matchmaking_provider.dart';
import '../../models/game_state.dart';
import '../../widgets/player_avatar.dart';

class ResultsScreen extends ConsumerWidget {
  final String matchId;

  const ResultsScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    final currentUser = ref.watch(currentUserProvider);

    if (game == null || game.matchResult == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final result = game.matchResult!;
    final userStanding = result.standings.firstWhere(
      (s) => s.userId == currentUser.userId,
      orElse: () => const FinalStanding(userId: '', username: 'You', finalScore: 0, rank: 0),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Trophy section
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 8),
                child: Column(
                  children: [
                    const _TrophyWidget(),
                    const SizedBox(height: 16),
                    const Text(
                      'Match Complete!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Winner section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      PlayerAvatar(
                        initial: result.winnerUsername.isNotEmpty
                            ? result.winnerUsername[0]
                            : '?',
                        colorIndex: 0,
                        size: 56,
                        borderColor: AppColors.gold,
                        borderWidth: 3,
                      ),
                      const Positioned(
                        top: -16,
                        child: Text(
                          '\u265B', // Crown unicode
                          style: TextStyle(fontSize: 20, color: AppColors.gold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    result.winnerUsername,
                    style: const TextStyle(
                      color: AppColors.gold,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${result.standings.first.finalScore} pts',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Final standings
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 4, bottom: 8),
                    child: Text(
                      'FINAL STANDINGS',
                      style: TextStyle(
                        color: AppColors.textTertiary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  ...result.standings.map((standing) {
                    final isUser = standing.userId == currentUser.userId;
                    return _StandingRow(standing: standing, isHighlighted: isUser);
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Stats card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'YOUR STATS',
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _StatItem(
                          label: 'Accuracy',
                          value: '${(userStanding.correctAnswers / game.totalRounds * 100).round()}%',
                          isAccent: true,
                          showBar: true,
                          barValue: userStanding.correctAnswers / game.totalRounds,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _StatItem(
                          label: 'Avg Speed',
                          value: '${(userStanding.avgResponseTimeMs / 1000).toStringAsFixed(1)}s',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _StatItem(
                          label: 'Best Streak',
                          value: '${userStanding.correctAnswers}',
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _StatItem(
                          label: 'Score / Rank',
                          value: '${userStanding.finalScore}',
                          suffix: ' #${userStanding.rank}',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // XP section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.gold, Color(0xFFE6A020)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '+120 XP',
                      style: TextStyle(
                        color: AppColors.background,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(text: 'Level '),
                              TextSpan(
                                text: '7',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                              TextSpan(text: ' \u2192 '),
                              TextSpan(
                                text: '8',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                              TextSpan(text: ' \u00B7 60%'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: const LinearProgressIndicator(
                            value: 0.6,
                            backgroundColor: Color(0x1AFFFFFF),
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Action buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                      ),
                      onPressed: () {
                        ref.read(gameProvider.notifier).reset();
                        ref.read(matchmakingProvider.notifier).reset();
                        context.go('/matchmaking');
                      },
                      child: const Text('Rematch'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ref.read(gameProvider.notifier).reset();
                        ref.read(matchmakingProvider.notifier).reset();
                        context.go('/matchmaking');
                      },
                      child: const Text('Home'),
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

class _TrophyWidget extends StatefulWidget {
  const _TrophyWidget();

  @override
  State<_TrophyWidget> createState() => _TrophyWidgetState();
}

class _TrophyWidgetState extends State<_TrophyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: SizedBox(
        width: 72,
        height: 72,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Glow
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.gold.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Trophy icon
            const Icon(
              Icons.emoji_events,
              color: AppColors.gold,
              size: 56,
            ),
          ],
        ),
      ),
    );
  }
}

class _StandingRow extends StatelessWidget {
  final FinalStanding standing;
  final bool isHighlighted;

  const _StandingRow({required this.standing, this.isHighlighted = false});

  Color get _rankColor {
    switch (standing.rank) {
      case 1: return AppColors.gold;
      case 2: return AppColors.silver;
      case 3: return AppColors.bronze;
      default: return AppColors.textTertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isHighlighted ? AppColors.accent.withOpacity(0.06) : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: isHighlighted
            ? Border.all(color: AppColors.accent.withOpacity(0.35), width: 1.5)
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 22,
            child: Text(
              '${standing.rank}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _rankColor,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          PlayerAvatar(
            initial: standing.username.isNotEmpty ? standing.username[0] : '?',
            colorIndex: standing.rank - 1,
            size: 30,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              standing.username,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            '${standing.finalScore}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isAccent;
  final bool showBar;
  final double barValue;
  final String? suffix;

  const _StatItem({
    required this.label,
    required this.value,
    this.isAccent = false,
    this.showBar = false,
    this.barValue = 0.0,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                color: isAccent ? AppColors.success : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (suffix != null)
              Text(
                suffix!,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        if (showBar) ...[
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: barValue,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
              minHeight: 4,
            ),
          ),
        ],
      ],
    );
  }
}
