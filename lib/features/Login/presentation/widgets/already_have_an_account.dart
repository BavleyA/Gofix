import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_style.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            AppStrings.alreadyHaveAccountText,
            style: dark ? AppTextTheme.darkTextTheme.bodyLarge : AppTextTheme.lightTextTheme.bodyLarge,
          ),
        ),
        TextButton(onPressed: (){},
            child: Text(
              'SignUp',
              style: dark
                  ? AppTextTheme.darkTextTheme.bodyLarge?.copyWith(
                color: Colors.indigo
              )
                  : AppTextTheme.lightTextTheme.bodyLarge?.copyWith(
                color: Colors.indigo
              )
            )
        ),
      ],
    );
  }
}