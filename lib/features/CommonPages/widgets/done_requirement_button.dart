import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';

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
    final dark = Helper.isDarkMode(context);

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: dark
              ? AppColors.mainButton
              : AppColors.buttonPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: dark
              ? AppTextTheme.darkTextTheme.displaySmall!.copyWith(
                  color: AppColors.primaryTextDark,
                )
              : AppTextTheme.lightTextTheme.displaySmall!.copyWith(
                  color: AppColors.light,
                ),
        ),
      ),
    );
  }
}
