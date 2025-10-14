import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_text_style.dart';

class DoneReqButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool dark;
  final double height;

  const DoneReqButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.dark = false,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: dark
              ? AppTextTheme.darkTextTheme.displaySmall
              : AppTextTheme.lightTextTheme.displaySmall!.copyWith(
                  color: AppColors.light,
                ),
        ),
      ),
    );
  }
}
