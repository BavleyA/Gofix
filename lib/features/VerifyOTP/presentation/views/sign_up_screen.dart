import 'package:flutter/material.dart';
import 'package:gofix/features/VerifyOTP/presentation/widgets/already_have_an_account.dart';
import 'package:gofix/features/VerifyOTP/presentation/widgets/sign_up_elevated_button.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/utils/validators.dart';
import '../../../Login/presentation/widgets/custom_text_form_field.dart';
import '../../../Login/presentation/widgets/elevated_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

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
                      'Sign Up',
                      style: dark ? AppTextTheme.darkTextTheme.headlineLarge : AppTextTheme.lightTextTheme.headlineLarge,

                    )
                  ],
                ),

                const SizedBox(height: 30,),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      CustomTextFormField(
                        dark: dark,
                        labelText: AppStrings.fullNameHint,
                        keyboardType: TextInputType.text,
                        // hintText: AppStrings.phoneNumberHint,
                        controller: nameController,
                        onChanged: (value){},
                        validator: (value) => Validator.validateName(value),
                        icon: Icons.person,
                      ),

                      const SizedBox(height: 16),

                      CustomTextFormField(
                        dark: dark,
                        labelText: AppStrings.phoneNumberHint,
                        keyboardType: TextInputType.phone,
                        // hintText: AppStrings.phoneNumberHint,
                        controller: phoneController,
                        onChanged: (value){},
                        validator: (value) => Validator.validatePhone(value),
                        icon: Icons.phone,
                      ),

                      const SizedBox(height: 16),


                      CustomTextFormField(
                        dark: dark,
                        labelText: AppStrings.passwordHint,
                        // hintText: AppStrings.passwordHint,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        onChanged: (value){},
                        validator: (value) => Validator.validatePassword(value),
                        icon: Icons.lock,
                        obscureText: isPassword,
                        suffixIcon: isPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),

                      const SizedBox(height: 4,),


                      const SizedBox(height: 10,),


                      const SizedBox(height: 20,),

                      SignUpElevatedAuthButton(
                        onPressed: (){},
                        dark: dark,
                        text: AppStrings.nextStepText,
                        name: nameController.text,
                        phone: phoneController.text,
                        password: passwordController.text,
                      ),

                      SizedBox(height: 10,),

                      AlreadyHaveanAccount(dark: dark),

                    ],
                  ),
                )

              ],
            ),
          )
      ),
    );
  }
}
