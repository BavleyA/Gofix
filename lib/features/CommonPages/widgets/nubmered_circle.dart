import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/utils/helper.dart';

class NumberedCircle extends StatelessWidget {
  final String number;
  final bool isCompleted;

  const NumberedCircle({
    super.key,
    required this.number,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return CircleAvatar(
      radius: 14,
      backgroundColor: dark
          ? (isCompleted ? const Color(0xFF243B55) : const Color(0xFFD9D9D9))
          : (isCompleted ? AppColors.primary : AppColors.docCard),
      child: Text(
        number,
        style: TextStyle(
          color: dark
              ? (isCompleted ? AppColors.light : AppColors.dark)
              : (isCompleted ? Colors.white : AppColors.secondaryBlack),
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}
