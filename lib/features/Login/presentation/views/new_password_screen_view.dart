import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofix/features/Login/Data/Models/Services/auth_services.dart';
import 'package:gofix/features/Login/presentation/cubit/auth_cubit.dart';
import 'package:gofix/features/Login/presentation/views/forgot_password_screen.dart';
import 'package:gofix/features/Login/presentation/views/new_password_screen.dart';

class NewPasswordScreenView extends StatelessWidget {
  const NewPasswordScreenView({super.key,required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthService()),
      child:  NewPasswordScreen(email:email),
    );
  }
}
