import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/core/utils/validators.dart';
import 'package:gofix/features/Login/presentation/widgets/do_not_have_an_account.dart';
import 'package:gofix/features/Login/presentation/widgets/elevated_button.dart';
import 'package:gofix/features/Login/presentation/widgets/forget_password.dart';
import 'package:gofix/features/RoleVehicle/persentation/view/role_screen.dart';
import 'package:gofix/features/VerifyOTP/presentation/views/sign_up_screen.dart';

import '../../../../core/constants/app_text_form_field_theme.dart';
import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.loginTitle,
                    style: dark
                        ? AppTextTheme.darkTextTheme.headlineLarge
                        : AppTextTheme.lightTextTheme.headlineLarge,
                  ),
                ],
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
                      // hintText: AppStrings.phoneNumberHint,
                      controller: emailController,
                      onChanged: (value) {},
                      validator: (value) => Validator.validateEmail(value),
                      icon: Icons.email,
                    ),

                    const SizedBox(height: 16),

                    CustomTextFormField(
                      dark: dark,
                      labelText: AppStrings.passwordHint,
                      // hintText: AppStrings.passwordHint,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      validator: (value) => Validator.validatePassword(value),
                      icon: Icons.lock,
                      obscureText: isPassword,
                      suffixIcon: isPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),

                    const SizedBox(height: 4),

                    ForgetPass(dark: dark),

                    const SizedBox(height: 20),

                    ElevatedAuthButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoleScreen(),
                          ),
                        ); // deleteeeeeeeeeeeeeeeee
                      },
                      dark: dark,
                      text: AppStrings.loginTitle,
                      phone: phoneController.text,
                      password: passwordController.text,
                    ),

                    const SizedBox(height: 10),

                    DontHaveanAccount(dark: dark),
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
