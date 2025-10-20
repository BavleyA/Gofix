import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_style.dart';

class ElevatedAuthButton extends StatelessWidget {
  const ElevatedAuthButton({
    super.key,

    required this.dark,
    required this.text,
    // required this.email,
    // required this.password,
    required this.onPressed,
  });

  final bool dark;
  final String text;
  // final String email;
  // final String password;
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
              ? AppTextTheme.darkTextTheme.displaySmall!.copyWith(
                  color: AppColors.imageCard,
                )
              : AppTextTheme.lightTextTheme.displaySmall!.copyWith(
                  color: AppColors.light,
                ),
        ),
      ),
    );
  }
}
