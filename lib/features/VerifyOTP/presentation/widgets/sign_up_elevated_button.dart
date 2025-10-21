import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_text_style.dart';

class SignUpElevatedAuthButton extends StatelessWidget {
  const SignUpElevatedAuthButton({
    super.key,
    required this.dark,
    required this.text,
    required this.onPressed,
  });

  final bool dark;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
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
