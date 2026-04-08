import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../providers/game_provider.dart';
import '../../providers/matchmaking_provider.dart';
import '../../providers/user_stats_provider.dart';
import '../../models/game_state.dart';
import 'widgets/countdown_timer_ring.dart';
import 'widgets/question_card.dart';
import 'widgets/option_button.dart';
import 'widgets/mini_leaderboard.dart';

class GameplayScreen extends ConsumerWidget {
  final String matchId;

  const GameplayScreen({super.key, required this.matchId});

  void _showExitDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Exit Game?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'Are you sure you want to exit? Your stats will be recorded based on the rounds you have played so far.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('No', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();

              // Record partial stats before exiting
              final game = ref.read(gameProvider);
              if (game != null && game.roundResults.isNotEmpty) {
                final roundsPlayed = game.roundResults.length;
                final correctAnswers = game.roundResults.values.where((v) => v).length;
                // Estimate avg response from rounds played (mid-range guess for partial)
                ref.read(userStatsProvider.notifier).recordMatch(
                  rank: game.position > 0 ? game.position : 5,
                  correctAnswers: correctAnswers,
                  totalQuestions: roundsPlayed,
                  score: game.score,
                  avgResponseTimeSecs: 7.5,
                  streak: correctAnswers,
                );
              }

              ref.read(gameProvider.notifier).reset();
              ref.read(matchmakingProvider.notifier).reset();
              context.go('/profile');
            },
            child: const Text('Yes, Exit', style: TextStyle(color: AppColors.accent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);

    // Navigate on match events
    ref.listen<GameState?>(gameProvider, (previous, next) {
      if (next == null) return;

      // When leaderboard updates after a round result, show leaderboard
      if (previous?.leaderboard != next.leaderboard &&
          next.leaderboard.isNotEmpty &&
          next.currentRound > 0 &&
          previous?.currentRound == next.currentRound) {
        context.go('/leaderboard/$matchId');
      }

      // When match ends, go to results
      if (next.matchResult != null && previous?.matchResult == null) {
        context.go('/results/$matchId');
      }
    });

    if (game == null || game.currentQuestion == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.accent),
        ),
      );
    }

    final question = game.currentQuestion!;
    final letters = ['A', 'B', 'C', 'D'];

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          children: [
            // Top bar
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 24, 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _showExitDialog(context, ref),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Exit',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Round ${game.currentRound} of ${game.totalRounds}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Progress dots
                    Row(
                      children: List.generate(game.totalRounds, (i) {
                        final roundNum = i + 1;
                        final isActive = roundNum == game.currentRound;
                        final result = game.roundResults[roundNum]; // true/false/null

                        Color dotColor;
                        if (result == true) {
                          dotColor = AppColors.success; // green = correct
                        } else if (result == false) {
                          dotColor = Colors.red; // red = wrong
                        } else if (isActive) {
                          dotColor = AppColors.gold; // orange = current round
                        } else {
                          dotColor = Colors.white.withOpacity(0.2); // gray = upcoming
                        }

                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(left: 6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: dotColor,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),

            // Mini leaderboard
            if (game.leaderboard.isNotEmpty)
              MiniLeaderboard(entries: game.leaderboard),

            // Timer
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: CountdownTimerRing(
                remainingSeconds: game.remainingSeconds,
                totalSeconds: question.timeLimitSecs,
              ),
            ),

            // Question & Options
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    QuestionCard(
                      questionNumber: game.currentRound,
                      text: question.text,
                    ),
                    const SizedBox(height: 20),
                    ...List.generate(
                      question.options.length,
                      (i) {
                        final isRevealed = game.correctAnswerIndex != null;
                        final isThisCorrect = isRevealed && i == game.correctAnswerIndex;
                        final isThisSelected = game.selectedAnswerIndex == i;
                        final isThisWrong = isRevealed && isThisSelected && !isThisCorrect;

                        // Determine isCorrect for styling
                        bool? optionCorrectState;
                        if (isRevealed) {
                          if (isThisCorrect) {
                            optionCorrectState = true; // always show correct answer green
                          } else if (isThisWrong) {
                            optionCorrectState = false; // user's wrong pick = red
                          }
                        }

                        // Feedback message
                        String? feedback;
                        if (isRevealed && isThisCorrect && isThisSelected) {
                          feedback = 'Correct answer!';
                        } else if (isRevealed && isThisCorrect && !isThisSelected) {
                          feedback = 'This was the correct answer';
                        } else if (isThisWrong) {
                          feedback = 'Wrong answer';
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: OptionButton(
                            letter: letters[i],
                            text: question.options[i],
                            isSelected: isThisSelected,
                            isCorrect: optionCorrectState,
                            feedback: feedback,
                            onTap: game.selectedAnswerIndex == null && !isRevealed
                                ? () => ref.read(gameProvider.notifier).selectAnswer(i)
                                : null,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Bottom bar
            Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                border: Border(
                  top: BorderSide(color: Colors.white.withOpacity(0.05)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${game.score} pts',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Your Score',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (game.position > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '#${game.position}',
                        style: const TextStyle(
                          color: AppColors.accent,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
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
