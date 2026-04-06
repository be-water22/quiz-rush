import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../providers/matchmaking_provider.dart';
import '../../providers/game_provider.dart';
import '../../models/game_state.dart';
import '../../widgets/player_avatar.dart';
import '../../widgets/animated_dots.dart';
import 'widgets/radar_animation.dart';

class MatchmakingScreen extends ConsumerStatefulWidget {
  const MatchmakingScreen({super.key});

  @override
  ConsumerState<MatchmakingScreen> createState() => _MatchmakingScreenState();
}

class _MatchmakingScreenState extends ConsumerState<MatchmakingScreen> {
  @override
  void initState() {
    super.initState();
    // Auto-start matchmaking
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(matchmakingProvider.notifier).joinMatchmaking();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(matchmakingProvider);

    // Navigate to game when match is found
    ref.listen<MatchmakingState>(matchmakingProvider, (previous, next) {
      if (next.status == MatchStatus.found && next.roomId != null) {
        // Start the game
        ref.read(gameProvider.notifier).startGame(next.roomId!, next.totalRounds);
        // Navigate after a brief delay to show "found" state
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            context.go('/game/${next.roomId}');
          }
        });
      }
    });

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
          child: Column(
            children: [
              // Top bar
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Quiz Battle',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              // Radar section
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const RadarAnimation(),
                    const SizedBox(height: 32),

                    // Search text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.status == MatchStatus.found
                              ? 'Match Found!'
                              : 'Finding opponents',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (state.status == MatchStatus.searching)
                          const AnimatedDots(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Player count
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                            text: '${state.foundPlayers.length}',
                            style: const TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const TextSpan(text: ' players found'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Found players
                    if (state.foundPlayers.isNotEmpty)
                      Wrap(
                        spacing: 24,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: state.foundPlayers.asMap().entries.map((entry) {
                          final player = entry.value;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PlayerAvatar(
                                initial: player.initial,
                                colorIndex: entry.key,
                                size: 48,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                player.username,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 24),

                    // ETA
                    if (state.status == MatchStatus.searching)
                      Text(
                        'Estimated wait: ~${state.etaSeconds}s remaining',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
              ),

              // Cancel button
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.status == MatchStatus.found
                        ? null
                        : () {
                            ref.read(matchmakingProvider.notifier).leaveMatchmaking();
                          },
                    child: Text(
                      state.status == MatchStatus.found ? 'Starting...' : 'Cancel',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
