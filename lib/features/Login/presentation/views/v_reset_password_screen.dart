import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import 'package:gofix/features/CommonPages/view/custom_dialog.dart';
import 'package:gofix/features/Login/presentation/cubit/auth_cubit.dart';

class VResetPasswordScreen extends StatefulWidget {
  const VResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<VResetPasswordScreen> createState() => _VResetPasswordScreenState();
}

class _VResetPasswordScreenState extends State<VResetPasswordScreen> {
  final int otpLength = 4;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(otpLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) controller.dispose();
    for (final node in _focusNodes) node.dispose();
    super.dispose();
  }

  bool _isOtpFilled() => _controllers.every((c) => c.text.isNotEmpty);

  void _onVerify() {
    final otp = _controllers.map((c) => c.text).join();
    if (otp.length != otpLength || otp.contains(RegExp(r'[^0-9]'))) {
      setState(() => _hasError = true);
      return;
    }
    context.read<AuthCubit>().verifyOtpForNewPassword(widget.email, otp);
  }

  String getFriendlyOtpError(String rawMessage) {
    if (rawMessage.contains('User.InvalidOtp')) {
      return 'The verification code is incorrect.';
    } else if (rawMessage.contains('User.NotFound')) {
      return 'No account found with this email.';
    } else {
      return 'An error occurred during verification.\nPlease try again later.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);
    final baseColor = dark ? const Color(0xFF22344D) : Colors.white;
    final borderColor = dark ? const Color(0xFF2F3E52) : Colors.grey[300]!;
    final focusColor = dark ? const Color(0xFF4A6FA1) : AppColors.primary;

    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else {
            if (Navigator.canPop(context)) Navigator.pop(context);
          }

          if (state is AuthSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showCustomDialog(
                context,
                title: 'Verified',
                message: 'OTP verified successfully!',
                color: Colors.green,
                isSuccess: true,
              );
            });

            await Future.delayed(const Duration(seconds: 2));
            if (context.mounted) Navigator.pop(context);
          } else if (state is AuthFailure) {
            final friendlyMessage = getFriendlyOtpError(state.message);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showCustomDialog(
                context,
                title: 'Error',
                message: friendlyMessage,
                color: Colors.red,
                isSuccess: false,
              );
            });
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
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
                  "We've sent you an OTP. Please check your email and enter it below.",

                  style: dark
                      ? AppTextTheme.darkTextTheme.titleMedium
                      : AppTextTheme.lightTextTheme.titleMedium,
                ),
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(otpLength, (index) {
                    return SizedBox(
                      width: 60,
                      height: 60,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: TextStyle(
                          color: dark ? Colors.white : Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: baseColor,
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: borderColor,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: focusColor, width: 2),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < otpLength - 1) {
                            _focusNodes[index + 1].requestFocus();
                          } else if (value.isEmpty && index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }
                          setState(() => _hasError = false);
                        },
                      ),
                    );
                  }),
                ),

                if (_hasError) ...[
                  const SizedBox(height: 8),
                  const Text(
                    "Please enter a valid 4-digit code",
                    style: TextStyle(color: Colors.red),
                  ),
                ],

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _onVerify,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dark
                          ? AppColors.mainButton
                          : AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      state is AuthLoading ? "Verifying..." : "Verify",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
