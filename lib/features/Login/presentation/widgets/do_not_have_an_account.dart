import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/routes/app_routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_style.dart';

class DontHaveanAccount extends StatelessWidget {
  const DontHaveanAccount({super.key, required this.dark});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            AppStrings.dontHaveAccountText,
            style: dark
                ? AppTextTheme.darkTextTheme.bodyLarge
                : AppTextTheme.lightTextTheme.bodyLarge,
          ),
        ),
        TextButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => SignUpView()),
            // );
            GoRouter.of(context).go(Routes.signup);
          },
          child: Text(
            'SignUp',
            style: dark
                ? AppTextTheme.darkTextTheme.bodyLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  )
                : AppTextTheme.lightTextTheme.bodyLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
          ),
        ),
      ],
    );
  }
}

