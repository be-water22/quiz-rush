import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class OptionButton extends StatelessWidget {
  final String letter;
  final String text;
  final bool isSelected;
  final bool? isCorrect; // null = not revealed, true = correct, false = wrong
  final String? feedback; // message below the option
  final VoidCallback? onTap;

  const OptionButton({
    super.key,
    required this.letter,
    required this.text,
    this.isSelected = false,
    this.isCorrect,
    this.feedback,
    this.onTap,
  });

  Color get _borderColor {
    if (isCorrect == true) return AppColors.success;
    if (isCorrect == false && isSelected) return Colors.red;
    if (isSelected) return AppColors.accent.withOpacity(0.6);
    return Colors.transparent;
  }

  Color get _backgroundColor {
    if (isCorrect == true) return AppColors.success.withOpacity(0.1);
    if (isCorrect == false && isSelected) return Colors.red.withOpacity(0.1);
    return AppColors.optionBackground;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
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
                    color: isCorrect == true
                        ? AppColors.success.withOpacity(0.2)
                        : isCorrect == false && isSelected
                            ? Colors.red.withOpacity(0.2)
                            : isSelected
                                ? AppColors.accent.withOpacity(0.2)
                                : Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      letter,
                      style: TextStyle(
                        color: isCorrect == true
                            ? AppColors.success
                            : isCorrect == false && isSelected
                                ? Colors.red
                                : isSelected
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
                  const Icon(Icons.cancel, color: Colors.red, size: 22),
              ],
            ),
          ),
          if (feedback != null)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 4),
              child: Text(
                feedback!,
                style: TextStyle(
                  color: isCorrect == true ? AppColors.success : Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
