import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/core/utils/validators.dart';
import 'package:gofix/features/CommonPages/view/custom_dialog.dart';
import 'package:gofix/features/Login/Data/Models/Services/auth_services.dart';
import 'package:gofix/features/Login/presentation/cubit/auth_cubit.dart';
import 'package:gofix/features/Login/presentation/views/v_reset_password_screen.dart';
import 'package:gofix/features/Login/presentation/views/v_reset_password_screen_view.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/elevated_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return BlocProvider(
      create: (context) => AuthCubit(AuthService()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            log('⏳ Sending OTP...');
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else {
            if (Navigator.canPop(context)) Navigator.pop(context);
          }

          if (state is AuthSuccess) {
            log('OTP sent successfully to ${emailController.text.trim()}');
            showCustomDialog(
              context,
              title: 'OTP Sent',
              message:
                  'OTP has been sent successfully to ${emailController.text.trim()}',
              color: Colors.green,
              isSuccess: true,
            );
            Future.delayed(const Duration(milliseconds: 3000), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => VResetPasswordScreenView(
                    email: emailController.text.trim(),
                  ),
                ),
              );
            });
          } else if (state is AuthFailure) {
            log('Error: ${state.message}');
            showCustomDialog(
              context,
              title: 'Error',
              message:
                  'Something went wrong\nPlease try again later or check your internet connection.',
              color: Colors.red,
              isSuccess: false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.forgotPasswordText,
                      style: dark
                          ? AppTextTheme.darkTextTheme.headlineLarge!.copyWith(
                              color: AppColors.imageCard,
                            )
                          : AppTextTheme.lightTextTheme.headlineLarge!.copyWith(
                              color: AppColors.secondaryBlack,
                            ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Let’s verify it!\nEnter your email and we’ll send you an OTP.",
                      style: dark
                          ? AppTextTheme.darkTextTheme.titleMedium
                          : AppTextTheme.lightTextTheme.titleMedium,
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            dark: dark,
                            labelText: "Email",
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            onChanged: (value) {},
                            validator: (value) =>
                                Validator.validateEmail(value),
                            icon: Icons.email,
                          ),
                          const SizedBox(height: 40),
                          ElevatedAuthButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().forgetPassword(
                                  emailController.text.trim(),
                                );
                              }
                            },
                            dark: dark,
                            text: state is AuthLoading
                                ? "Sending..."
                                : "Send OTP",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
