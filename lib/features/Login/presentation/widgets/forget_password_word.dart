import 'package:flutter/material.dart';
import 'package:gofix/features/Login/presentation/views/forgot_password_screen.dart';
import 'package:gofix/features/Login/presentation/views/forgot_password_screen_view.dart';
import '../../../../core/constants/app_text_style.dart';

class ForgetPassWord extends StatelessWidget {
  const ForgetPassWord({super.key, required this.dark});

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
              child: Text(
                'Forget Password ?',
                style:
                    (dark
                            ? AppTextTheme.darkTextTheme.bodyLarge
                            : AppTextTheme.lightTextTheme.bodyLarge)
                        ?.copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 1,
                          decorationStyle: TextDecorationStyle.solid,
                          shadows: const [Shadow(color: Colors.transparent)],
                          height: 1.4,
                        ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ForgotPasswordScreenView()),
              );
            },
          ),
        ),
      ],
    );
  }
}
