import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RankBadge extends StatelessWidget {
  final int rank;
  final double size;

  const RankBadge({super.key, required this.rank, this.size = 32});

  Color get _backgroundColor {
    switch (rank) {
      case 1:
        return AppColors.gold;
      case 2:
        return AppColors.silver;
      case 3:
        return AppColors.bronze;
      default:
        return Colors.white.withOpacity(0.15);
    }
  }

  Color get _textColor {
    if (rank <= 3) return Colors.white;
    return Colors.white.withOpacity(0.4);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: rank <= 3
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_backgroundColor, _backgroundColor.withOpacity(0.7)],
              )
            : null,
        color: rank > 3 ? _backgroundColor : null,
      ),
      child: Center(
        child: Text(
          '$rank',
          style: TextStyle(
            color: _textColor,
            fontSize: size * 0.44,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
