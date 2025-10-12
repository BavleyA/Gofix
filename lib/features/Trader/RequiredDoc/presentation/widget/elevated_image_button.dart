import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';

class ElevatedImageButton extends StatelessWidget {
  const ElevatedImageButton({
    super.key,
    required this.text,
    required this.imageFile,
    required this.onPressed,
    this.dark = false,
  });

  final bool dark;
  final String text;
  final File? imageFile;
  final void Function(File?) onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () => onPressed(imageFile),
        child: Text(
          AppStrings.uploadPhoto,
          style: dark
              ? AppTextTheme.darkTextTheme.displaySmall?.copyWith(
                  color: AppColors.light,
                )
              : AppTextTheme.lightTextTheme.displaySmall?.copyWith(
                  color: AppColors.light,
                ),
        ),
      ),
    );
  }
}
