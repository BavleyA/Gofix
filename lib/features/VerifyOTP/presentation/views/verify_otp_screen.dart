import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/routes/app_routes.dart';
import 'package:gofix/features/CommonPages/view/custom_dialog.dart';
import 'package:gofix/features/Login/presentation/cubit/auth_cubit.dart';
import 'package:gofix/core/utils/helper.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  const EmailVerificationScreen({super.key, required this.email});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool _hasError = false;

  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) controller.dispose();
    for (var node in _focusNodes) node.dispose();
    super.dispose();
  }

  void _onVerify() {
    final otp = _controllers.map((c) => c.text).join();
    if (otp.length != 4 || otp.contains(RegExp(r'[^0-9]'))) {
      setState(() => _hasError = true);
      return;
    }
    context.read<AuthCubit>().confirmEmail(widget.email, otp);
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

          if (state is AuthResendSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showCustomDialog(
                context,
                title: 'Email Resent',
                message: 'Verification email has been resent successfully!',
                color: AppColors.buttonPrimary,
                isSuccess: true,
              );
            });
          } else if (state is AuthSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showCustomDialog(
                context,
                title: 'Verified',
                message: 'Your email has been successfully verified!',
                color: Colors.green,
                isSuccess: true,
              );
            });

            Future.delayed(const Duration(seconds: 2), () {
              if (context.mounted) {
                GoRouter.of(context).go(Routes.underReview);
              }
            });
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
          return _buildVerificationBody(context);
        },
      ),
    );
  }

  Widget _buildVerificationBody(BuildContext context) {
    final dark = Helper.isDarkMode(context);
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 360;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Verify your email",
                style: dark
                    ? AppTextTheme.darkTextTheme.headlineLarge!.copyWith(
                        fontSize: 30,
                        color: AppColors.imageCard,
                      )
                    : AppTextTheme.lightTextTheme.headlineLarge!.copyWith(
                        fontSize: 30,
                        color: AppColors.secondaryBlack,
                      ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Enter the 4-digit code we sent to\n${widget.email}",
                style: TextStyle(
                  fontSize: 16,
                  color: dark ? Colors.white70 : Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildOtpFields(isSmall, dark),
              if (_hasError) ...[
                const Text(
                  "Please enter a valid 4-digit code",
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ],
              const SizedBox(height: 40),
              ResendLine(dark: dark, widget: widget),
              const SizedBox(height: 10),
              _buildVerifyButton(dark),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpFields(bool isSmall, bool dark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final boxSize = isSmall ? 50.0 : 56.0;
        final spacing = isSmall ? 8.0 : 12.0;
        final baseColor = dark ? const Color(0xFF22344D) : Colors.white;
        final borderColor = dark ? const Color(0xFF2F3E52) : Colors.grey[300]!;
        final focusColor = dark ? const Color(0xFF4A6FA1) : AppColors.primary;

        return Row(
          children: [
            SizedBox(
              width: boxSize,
              height: boxSize,
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
                    borderSide: BorderSide(color: borderColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: focusColor, width: 2),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty && index < 3) {
                    _focusNodes[index + 1].requestFocus();
                  } else if (value.isEmpty && index > 0) {
                    _focusNodes[index - 1].requestFocus();
                  }
                },
              ),
            ),
            if (index < 3) SizedBox(width: spacing),
          ],
        );
      }),
    );
  }

  Widget _buildVerifyButton(bool dark) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _onVerify,
        style: ElevatedButton.styleFrom(
          backgroundColor: dark ? AppColors.mainButton : AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          "Verify",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ResendLine extends StatefulWidget {
  const ResendLine({super.key, required this.dark, required this.widget});

  final bool dark;
  final EmailVerificationScreen widget;

  @override
  State<ResendLine> createState() => _ResendLineState();
}

class _ResendLineState extends State<ResendLine> {
  bool _canResend = true;
  int _secondsRemaining = 0;
  Timer? _timer;

  void _startTimer() {
    setState(() {
      _canResend = false;
      _secondsRemaining = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          _canResend = true;
        });
        _timer?.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get timerText {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't receive the code?",
          style: widget.dark
              ? AppTextTheme.darkTextTheme.bodyLarge
              : AppTextTheme.lightTextTheme.bodyLarge,
        ),
        const SizedBox(width: 5),
        TextButton(
          onPressed: _canResend
              ? () {
                  context.read<AuthCubit>().resendConfirmEmail(
                    widget.widget.email,
                  );
                  _startTimer();
                }
              : null,
          child: _canResend
              ? Text(
                  'Resend',
                  style: widget.dark
                      ? AppTextTheme.darkTextTheme.bodyLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        )
                      : AppTextTheme.lightTextTheme.bodyLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                )
              : Text(
                  'Resend in $timerText',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ],
    );
  }
}

// // and here is my last line of the code i wrote before leaving , written with love <3
// //i had the honor to participate in this
// // will be back soon <3
// // with all sorrow and sadness , i must bye bye just for now :(
