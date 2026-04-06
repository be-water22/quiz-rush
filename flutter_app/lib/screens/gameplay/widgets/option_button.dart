import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class OptionButton extends StatelessWidget {
  final String letter;
  final String text;
  final bool isSelected;
  final bool? isCorrect; // null = not revealed, true = correct, false = wrong
  final VoidCallback? onTap;

  const OptionButton({
    super.key,
    required this.letter,
    required this.text,
    this.isSelected = false,
    this.isCorrect,
    this.onTap,
  });

  Color get _borderColor {
    if (isCorrect == true) return AppColors.success;
    if (isCorrect == false && isSelected) return AppColors.accent;
    if (isSelected) return AppColors.accent.withOpacity(0.6);
    return Colors.transparent;
  }

  Color get _backgroundColor {
    if (isCorrect == true) return AppColors.success.withOpacity(0.1);
    if (isCorrect == false && isSelected) return AppColors.accent.withOpacity(0.1);
    return AppColors.optionBackground;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: _backgroundColor,
          border: Border.all(color: _borderColor, width: 2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.accent.withOpacity(0.2)
                    : Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  letter,
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.accent
                        : Colors.white.withOpacity(0.6),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isCorrect == true)
              const Icon(Icons.check_circle, color: AppColors.success, size: 22),
            if (isCorrect == false && isSelected)
              const Icon(Icons.cancel, color: AppColors.accent, size: 22),
          ],
        ),
      ),
    );
  }
}
