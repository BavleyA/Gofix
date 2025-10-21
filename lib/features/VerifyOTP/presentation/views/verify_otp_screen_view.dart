import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofix/features/Login/presentation/cubit/auth_cubit.dart';
import 'package:gofix/features/Login/Data/Models/Services/auth_services.dart';
import 'package:gofix/features/VerifyOTP/presentation/views/sign_up_screen.dart';
import 'package:gofix/features/VerifyOTP/presentation/views/verify_otp_screen.dart';

class EmailVerificationView extends StatelessWidget {
  final String email;

  const EmailVerificationView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthService()),
      child: EmailVerificationScreen(email: email),
    );
  }
}

