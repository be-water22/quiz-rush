import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Core
  static const background = Color(0xFF0D0D1A);
  static const cardBackground = Color(0xFF1A1A2E);
  static const optionBackground = Color(0xFF16213E);

  // Brand
  static const accent = Color(0xFFE94560);
  static const secondary = Color(0xFF0F3460);

  // Status
  static const success = Color(0xFF53D769);
  static const gold = Color(0xFFFFB830);
  static const silver = Color(0xFFC0C0C0);
  static const bronze = Color(0xFFCD7F32);

  // Text
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0x99FFFFFF); // 60%
  static const textTertiary = Color(0x66FFFFFF);  // 40%
  static const textHint = Color(0x4DFFFFFF);      // 30%

  // Player avatar colors
  static const avatarColors = [
    Color(0xFF0F3460),
    Color(0xFF533483),
    Color(0xFF2D6A4F),
    Color(0xFFE94560),
    Color(0xFF0F3460),
    Color(0xFFFF6B35),
    Color(0xFF1B9AAA),
    Color(0xFF7B2D8E),
  ];

  static Color avatarColor(int index) {
    return avatarColors[index % avatarColors.length];
  }
}
