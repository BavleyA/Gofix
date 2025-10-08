import 'package:flutter/material.dart';
import 'package:gofix/features/Login/presentation/views/login_screen.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../VerifyOTP/presentation/views/sign_up_screen.dart';

class AlreadyHaveanAccount extends StatelessWidget {
  const AlreadyHaveanAccount({
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
        TextButton(onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginScreen(),
              ));
        },
            child: Text(
                'Login',
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