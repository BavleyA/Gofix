import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';

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
    return CircleAvatar(
      radius: 14,
      backgroundColor: isCompleted ? AppColors.primary : AppColors.docCard,
      child: Text(
        number,
        style: TextStyle(
          color: isCompleted ? Colors.white : AppColors.secondaryBlack,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}
