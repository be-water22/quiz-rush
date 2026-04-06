import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'routing/app_router.dart';

class QuizBattleApp extends StatelessWidget {
  const QuizBattleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Quiz Battle',
      theme: AppTheme.dark,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
