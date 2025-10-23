import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofix/features/Login/Data/Models/Services/auth_services.dart';
import 'package:gofix/features/Login/presentation/cubit/auth_cubit.dart';
import 'package:gofix/features/Login/presentation/views/v_reset_password_screen.dart';

class VResetPasswordScreenView extends StatelessWidget {
  const VResetPasswordScreenView({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthService()),
      child: VResetPasswordScreen(email: email), 
    );
  }
}
