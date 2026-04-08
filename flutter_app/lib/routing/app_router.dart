import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/login/login_screen.dart';
import '../screens/matchmaking/matchmaking_screen.dart';
import '../screens/gameplay/gameplay_screen.dart';
import '../screens/leaderboard/leaderboard_screen.dart';
import '../screens/results/results_screen.dart';
import '../screens/profile/profile_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/profile',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const ProfileScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/matchmaking',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const MatchmakingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/game/:matchId',
        pageBuilder: (context, state) {
          final matchId = state.pathParameters['matchId'] ?? '';
          return CustomTransitionPage(
            child: GameplayScreen(matchId: matchId),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                )),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/leaderboard/:matchId',
        pageBuilder: (context, state) {
          final matchId = state.pathParameters['matchId'] ?? '';
          return CustomTransitionPage(
            child: LeaderboardScreen(matchId: matchId),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          );
        },
      ),
      GoRoute(
        path: '/results/:matchId',
        pageBuilder: (context, state) {
          final matchId = state.pathParameters['matchId'] ?? '';
          return CustomTransitionPage(
            child: ResultsScreen(matchId: matchId),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                )),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
          );
        },
      ),
    ],
  );
}
