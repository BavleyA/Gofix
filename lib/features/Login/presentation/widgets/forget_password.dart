import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_style.dart';

class ForgetPass extends StatelessWidget {
  const ForgetPass({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            child: Center(
              child: Text('Forget Password?',
                style: dark ?
                AppTextTheme.darkTextTheme.bodyLarge?.copyWith(

                  decorationThickness: 2,
                  decoration: TextDecoration.underline,
                  height: 2,

                ) : AppTextTheme.lightTextTheme.bodyLarge?.copyWith(

                  decorationThickness: 2,
                  decoration: TextDecoration.underline,
                  height: 2,

                ),



              ),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}