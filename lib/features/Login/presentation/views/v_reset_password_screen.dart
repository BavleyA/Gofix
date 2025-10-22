import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/utils/helper.dart';
import '../widgets/elevated_button.dart';

class VResetPasswordScreen extends StatefulWidget {
  const VResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<VResetPasswordScreen> createState() => _VResetPasswordScreenState();
}

class _VResetPasswordScreenState extends State<VResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final int otpLength = 4;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(otpLength, (index) => TextEditingController());
    _focusNodes = List.generate(otpLength, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  bool _isOtpFilled() {
    return _controllers.every((controller) => controller.text.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    /// 🎨 الألوان الجديدة حسب المود
    final baseColor = dark ? const Color(0xFF22344D) : Colors.white;
    final borderColor = dark ? const Color(0xFF2F3E52) : Colors.grey[300]!;
    final focusColor = dark ? const Color(0xFF4A6FA1) : AppColors.primary;

    const boxSize = 60.0;
    const spacing = 12.0;

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
                "We've sent you an OTP. Please check your email and enter it below.",
                style: dark
                    ? AppTextTheme.darkTextTheme.titleMedium
                    : AppTextTheme.lightTextTheme.titleMedium,
              ),
              const SizedBox(height: 40),

              // 🔹 مربعات الـ OTP
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(otpLength, (index) {
                  return SizedBox(
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
                        if (value.isNotEmpty && index < otpLength - 1) {
                          _focusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                        setState(() {});
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 40),

              // 🔹 زر التحقق
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    ElevatedAuthButton(
                      onPressed: () async {
                        if (_isOtpFilled()) {
                          final otp = _controllers
                              .map((controller) => controller.text)
                              .join();
                          print("✅ Entered OTP: $otp");

                          final messenger = ScaffoldMessenger.of(context);
                          messenger.showSnackBar(
                            const SnackBar(
                              content: Text('Verified successfully!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          await Future.delayed(const Duration(seconds: 2));
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter all OTP digits!'),
                            ),
                          );
                        }
                      },
                      dark: dark,
                      text: "Verify",
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
