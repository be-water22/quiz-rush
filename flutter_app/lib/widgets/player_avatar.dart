import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PlayerAvatar extends StatelessWidget {
  final String initial;
  final int colorIndex;
  final double size;
  final Color? borderColor;
  final double borderWidth;

  const PlayerAvatar({
    super.key,
    required this.initial,
    this.colorIndex = 0,
    this.size = 48,
    this.borderColor,
    this.borderWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.avatarColor(colorIndex),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : Border.all(color: Colors.white.withOpacity(0.2), width: borderWidth),
      ),
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.38,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
