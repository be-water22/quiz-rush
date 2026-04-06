import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../models/leaderboard_entry.dart';
import '../../../widgets/player_avatar.dart';

class MiniLeaderboard extends StatelessWidget {
  final List<LeaderboardEntry> entries;

  const MiniLeaderboard({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    final top3 = entries.take(3).toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: top3.asMap().entries.expand((entry) {
          final widgets = <Widget>[
            _MiniPlayerEntry(
              initial: entry.value.username.isNotEmpty
                  ? entry.value.username[0]
                  : '?',
              score: entry.value.score,
              colorIndex: entry.key,
            ),
          ];
          if (entry.key < top3.length - 1) {
            widgets.add(
              Container(
                width: 1,
                height: 28,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                color: Colors.white.withOpacity(0.1),
              ),
            );
          }
          return widgets;
        }).toList(),
      ),
    );
  }
}

class _MiniPlayerEntry extends StatelessWidget {
  final String initial;
  final int score;
  final int colorIndex;

  const _MiniPlayerEntry({
    required this.initial,
    required this.score,
    required this.colorIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PlayerAvatar(initial: initial, colorIndex: colorIndex, size: 28),
        const SizedBox(width: 8),
        Text(
          '$score',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
