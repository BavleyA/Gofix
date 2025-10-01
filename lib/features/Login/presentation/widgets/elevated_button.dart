import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_style.dart';

class ElevatedAuthButton extends StatelessWidget {
  const ElevatedAuthButton({
    super.key,

    required this.dark,
    required this.text,
    required this.phone,
    required this.password,
    required this.onPressed,
  });

  final bool dark;
  final String text;
  final String phone;
  final String password;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style:dark ? AppTextTheme.darkTextTheme.displaySmall : AppTextTheme.lightTextTheme.displaySmall,
          )),
    );
  }
}

