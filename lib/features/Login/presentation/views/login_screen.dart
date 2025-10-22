import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/routes/app_routes.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/core/utils/validators.dart';
import 'package:gofix/features/CommonPages/view/custom_dialog.dart';
import 'package:gofix/features/Login/presentation/cubit/auth_cubit.dart';
import 'package:gofix/features/Login/presentation/widgets/do_not_have_an_account.dart';
import 'package:gofix/features/Login/presentation/widgets/elevated_button.dart';
import 'package:gofix/features/Login/presentation/widgets/forget_password_word.dart';
import 'package:gofix/features/RoleVehicle/persentation/view/role_screen.dart';
import 'package:gofix/features/VerifyOTP/presentation/views/verify_otp_screen.dart';
import 'package:gofix/features/VerifyOTP/presentation/views/verify_otp_screen_view.dart';
import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            showCustomDialog(
              context,
              title: 'Success',
              message: 'You have logged in successfully!',
              color: Colors.green,
              isSuccess: true,
            );

            // Future.delayed(const Duration(seconds: 2), () {
            //   Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(builder: (_) => const RoleScreen()),
            //   );
            // }

            // );
          } else if (state is AuthFailure) {
            final message = state.message;

            if (message.contains('Email is not confirmed') ||
                message.contains('User.EmailNotConfirmed')) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Email Not Confirmed'),
                    content: const Text(
                      'Your email is not confirmed. Would you like to verify it now?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         const EmailVerificationView(),
                          //   ),
                          // );
                          GoRouter.of(context).push(
                            Routes.verify,
                            extra: emailController.text.trim(),
                          );
                        },
                        child: const Text('Verify Now'),
                      ),
                    ],
                  );
                },
              );
            } else {
              String userMessage;

              if (message.contains('Invalid email/password') ||
                  message.contains('User.InvalidCredentials')) {
                userMessage = 'Invalid Email or Password.\nPlease Try Again.';
              } else {
                userMessage = 'Something went wrong.\nPlease try again later.';
              }

              showCustomDialog(
                context,
                title: 'Error',
                message: userMessage,
                color: Colors.red,
                isSuccess: false,
              );
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.loginTitle,
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
                        CustomTextFormField(
                          dark: dark,
                          labelText: AppStrings.emailHint,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          onChanged: (value) {},
                          validator: (value) => Validator.validateEmail(value),
                          icon: Icons.email,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          dark: dark,
                          labelText: AppStrings.passwordHint,
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                          validator: (value) =>
                              Validator.validatePassword(value),
                          icon: Icons.lock,
                          obscureText: isPassword,
                          suffixIcon: isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        const SizedBox(height: 4),
                        ForgetPassWord(dark: dark),
                        const SizedBox(height: 20),
                        if (state is AuthLoading)
                          const CircularProgressIndicator()
                        else
                          ElevatedAuthButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().login(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                            dark: dark,
                            text: AppStrings.loginTitle,
                            // email: emailController.text.trim(),
                            // password: passwordController.text.trim(),
                          ),
                        const SizedBox(height: 10),
                        DontHaveanAccount(dark: dark),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
