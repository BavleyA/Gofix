import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/core/utils/validators.dart';
import 'package:gofix/features/CommonPages/view/custom_dialog.dart';
import 'package:gofix/features/Login/presentation/cubit/auth_cubit.dart';
import 'package:gofix/features/Login/presentation/views/login_screen_view.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/elevated_button.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key, required this.email});
  final String email;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  bool isPassword = true;
  bool hasUppercase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;

  bool get isPasswordValid =>
      hasUppercase &&
      hasNumber &&
      hasSpecialChar &&
      newPasswordController.text.length >= 8;

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email;
  }

  void validatePasswordRules(String value) {
    setState(() {
      hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
      hasNumber = RegExp(r'[0-9]').hasMatch(value);
      hasSpecialChar = RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value);
    });
  }

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
              message: 'Password reset successfully!',
              color: Colors.green,
              isSuccess: true,
            );
            Future.delayed(const Duration(milliseconds: 1500), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginView()),
              );
            });
          } else if (state is AuthFailure) {
            showCustomDialog(
              context,
              title: 'Error',
              message: 'Something wrong\nPlease try again later',
              color: Colors.red,
              isSuccess: false,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SingleChildScrollView(
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
                    // "Enter your email and new password",
                    "Write your new password",
                    style: dark
                        ? AppTextTheme.darkTextTheme.titleMedium
                        : AppTextTheme.lightTextTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // CustomTextFormField(
                        //   dark: dark,
                        //   labelText: "Email",
                        //   keyboardType: TextInputType.emailAddress,
                        //   controller: emailController,
                        //   validator: (value) => Validator.validateEmail(value),
                        //   icon: Icons.email,
                        //   onChanged: (String value) {},
                        // ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          dark: dark,
                          labelText: "New Password",
                          controller: newPasswordController,
                          keyboardType: TextInputType.text,
                          onChanged: validatePasswordRules,
                          validator: (value) =>
                              Validator.validatePassword(value),
                          icon: Icons.lock,
                          obscureText: isPassword,
                          suffixIcon: isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        const SizedBox(height: 16),

                        _buildPasswordCondition(
                          'Contains at least one uppercase letter',
                          hasUppercase,
                        ),
                        _buildPasswordCondition(
                          'Contains at least one number',
                          hasNumber,
                        ),
                        _buildPasswordCondition(
                          'Contains at least one special character (@, #, !, ...)',
                          hasSpecialChar,
                        ),

                        const SizedBox(height: 30),

                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedAuthButton(
                                onPressed: () {
                                  if (isPasswordValid &&
                                      _formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().resetPassword(
                                      email: widget.email,
                                      newPassword: newPasswordController.text
                                          .trim(),
                                    );
                                  } else {
                                    showCustomDialog(
                                      context,
                                      title: 'Error',
                                      message:
                                          'Please make sure your password follows the rules.',
                                      color: Colors.red,
                                      isSuccess: false,
                                    );
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
          );
        },
      ),
    );
  }
}

Widget _buildPasswordCondition(String text, bool conditionMet) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: Icon(
            conditionMet ? Icons.check_circle : Icons.circle,
            key: ValueKey(conditionMet),
            color: conditionMet ? Colors.green : Colors.grey,
            size: 18,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            decoration: conditionMet
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: conditionMet ? Colors.green : Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}
