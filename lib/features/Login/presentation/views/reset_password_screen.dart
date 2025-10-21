import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/core/utils/validators.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/elevated_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.resetPasswordText,
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
                "Enter your email and new password",
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
                      validator: (value) => Validator.validateEmail(value),
                      icon: Icons.email,
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      dark: dark,
                      labelText: "New Password",
                      controller: newPasswordController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) => Validator.validatePassword(value),
                      icon: Icons.lock,
                      obscureText: isPassword,
                      suffixIcon: isPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    const SizedBox(height: 30),
                    ElevatedAuthButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final messenger = ScaffoldMessenger.of(context);
                          messenger.showSnackBar(
                            const SnackBar(
                              content: Text('Password reset successfully!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          await Future.delayed(const Duration(seconds: 2));
                          Navigator.pop(context);
                        }
                      },
                      dark: dark,
                      text: "Reset Password",
                    
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
