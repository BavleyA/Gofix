import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/core/utils/validators.dart';
import 'package:gofix/features/CommonPages/view/custom_dialog.dart';
import 'package:gofix/features/Login/presentation/widgets/custom_text_form_field.dart';
import 'package:gofix/features/VerifyOTP/presentation/views/verify_otp_screen.dart';
import 'package:gofix/features/VerifyOTP/presentation/widgets/already_have_an_account.dart';
import 'package:gofix/features/VerifyOTP/presentation/widgets/sign_up_elevated_button.dart';
import '../../../Login/presentation/cubit/auth_cubit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPassword = true;

  String getFriendlyErrorMessage(String rawMessage) {
    if (rawMessage.contains(
      'Another user with the same email is already exists',
    )) {
      return 'An account with this email already exists.\nPlease log in or verify your OTP.';
    } else {
      return 'Something went wrong\nPlease try again';
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            showCustomDialog(
              context,
              title: 'Success',
              message: 'Registered Successfully!',
              color: Colors.green,
              isSuccess: true,
            );

            Future.delayed(const Duration(seconds: 2), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EmailVerificationScreen(),
                ),
              );
            });
          } else if (state is AuthFailure) {
            String friendlyMessage = getFriendlyErrorMessage(state.message);

            showCustomDialog(
              context,
              title: 'Error',
              message: friendlyMessage,
              color: Colors.red,
              isSuccess: false,
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign Up',
                  style: dark
                      ? AppTextTheme.darkTextTheme.headlineLarge!.copyWith(
                          color: AppColors.imageCard,
                        )
                      : AppTextTheme.lightTextTheme.headlineLarge!.copyWith(
                          color: AppColors.secondaryBlack,
                        ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email
                      CustomTextFormField(
                        dark: dark,
                        labelText: AppStrings.emailHint,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (value) => Validator.validateEmail(value),
                        icon: Icons.email,
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 16),

                      // Full Name
                      CustomTextFormField(
                        dark: dark,
                        labelText: AppStrings.fullNameHint,
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        validator: (value) => Validator.validateName(value),
                        icon: Icons.person,
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 16),

                      // Password
                      CustomTextFormField(
                        dark: dark,
                        labelText: AppStrings.passwordHint,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        validator: (value) => Validator.validatePassword(value),
                        icon: Icons.lock,
                        obscureText: isPassword,
                        suffixIcon: isPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 20),

                      // Sign Up Button
                      SignUpElevatedAuthButton(
                        dark: dark,
                        text: AppStrings.nextStepText,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().register(
                              email: emailController.text.trim(),
                              fullName: nameController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      AlreadyHaveanAccount(dark: dark),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
