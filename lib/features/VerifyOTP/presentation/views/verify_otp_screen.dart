import 'package:flutter/material.dart';
import 'dart:async';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/utils/helper.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  bool _hasError = false;
  int _countdown = 20;
  Timer? _timer;

  final List<TextEditingController> _controllers = List.generate(5,
        (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(5,
        (index) => FocusNode(),
  );

  @override
  void initState() {
    super.initState();
    _startCountdown();

    for (int i = 0; i < 5; i++) {
      _controllers[i].addListener(() {
        setState(() {
          if (_controllers[i].text.length == 1 && i < 4) {
            _focusNodes[i + 1].requestFocus();
          }
          _hasError = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _countdown = 20);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() => _countdown--);
      } else {
        timer.cancel();
      }
    });
  }

  void _onVerify() {
    String enteredCode = _controllers.map((c) => c.text).join();

    if (enteredCode == '25017') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification successful!')),
      );
    } else {
      setState(() {
        _hasError = true;
      });
    }
  }

  void _resendCode() {
    setState(() {
      _hasError = false;
    });
    for (var controller in _controllers) {
      controller.clear();
    }
    _startCountdown();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _focusNodes[0].requestFocus();
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Code sent!')),
    );
  }

  bool get _isCodeComplete {
    return _controllers.every((controller) => controller.text.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: dark ? AppColors.backArrow : AppColors.buttonSecondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: dark ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 20.0 : 24.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isCodeComplete ? 'Verify your phone number' : 'Enter code',
                      style: dark
                          ? AppTextTheme.darkTextTheme.headlineLarge
                          : AppTextTheme.lightTextTheme.headlineLarge,
                    ),
                    SizedBox(height: isSmallScreen ? 12 : 16),

                    Text(
                      "We've sent an SMS with an activation code to your phone +33 2 84 27 84 11",
                      style: dark
                          ? AppTextTheme.darkTextTheme.headlineMedium
                          : AppTextTheme.lightTextTheme.headlineMedium,
                    ),

                    if (!_isCodeComplete) ...[
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Change your mobile number?',
                          style: dark
                              ? AppTextTheme.darkTextTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                            decoration: TextDecoration.underline,
                          )
                              : AppTextTheme.lightTextTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: isSmallScreen ? 24 : 32),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(5, (index) {
                        final boxSize = isSmallScreen ? 50.0 : 56.0;
                        final spacing = isSmallScreen ? 8.0 : 12.0;

                        return Container(
                          margin: EdgeInsets.only(
                            right: index < 4 ? spacing : 0,
                          ),
                          width: boxSize,
                          height: boxSize,
                          decoration: BoxDecoration(
                            color: dark
                                ? const Color(0xFF1A2938)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _hasError
                                  ? Colors.red.withOpacity(0.5)
                                  : _focusNodes[index].hasFocus
                                  ? (dark ? AppColors.mainButton : AppColors.primary)
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: TextStyle(
                              color: dark ? Colors.white : Colors.black,
                              fontSize: isSmallScreen ? 20 : 24,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (value) {
                              if (value.isEmpty && index > 0) {
                                _focusNodes[index - 1].requestFocus();
                              }
                            },
                            onTap: () {
                              if (_controllers[index].text.isEmpty && index > 0) {
                                _focusNodes[index - 1].requestFocus();
                              }
                            },
                          ),
                        );
                      }),
                    ),

                    if (_hasError) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Wrong code, please try again',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ],

                    SizedBox(height: isSmallScreen ? 20 : 24),
                    Row(
                      children: [
                        TextButton(
                          onPressed: _countdown == 0 ? _resendCode : null,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Send code again',
                            style: TextStyle(
                              color: _countdown == 0
                                  ? (dark ? AppColors.mainButton : AppColors.primary)
                                  : (dark ? Colors.white.withOpacity(0.5) : Colors.grey),
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '00:${_countdown.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            color: dark ? Colors.white.withOpacity(0.5) : Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: isSmallScreen ? 20 : 24),

                    if (!_isCodeComplete) ...[
                      SizedBox(
                        width: double.infinity,
                        height: isSmallScreen ? 50 : 56,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: dark ? AppColors.mainButton : AppColors.buttonPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Call me instead',
                            style: dark
                                ? AppTextTheme.darkTextTheme.titleLarge?.copyWith(
                              color: AppColors.primaryTextDark,
                            )
                                : AppTextTheme.lightTextTheme.titleLarge?.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      TextButton(
                        onPressed: _resendCode,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "I didn't receive a code",
                              style: dark
                                  ? AppTextTheme.darkTextTheme.titleLarge?.copyWith(
                                color: AppColors.primaryTextDark,
                              )
                                  : AppTextTheme.lightTextTheme.titleLarge?.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              " Resend",
                              style: dark
                                  ? AppTextTheme.darkTextTheme.titleLarge?.copyWith(
                                color: AppColors.mainButton,
                                decoration: TextDecoration.underline,
                              )
                                  : AppTextTheme.lightTextTheme.titleLarge?.copyWith(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 20 : 24),

                      SizedBox(
                        width: double.infinity,
                        height: isSmallScreen ? 50 : 56,
                        child: ElevatedButton(
                          onPressed: _onVerify,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: dark ? AppColors.mainButton : AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Verify',
                            style: dark
                                ? AppTextTheme.darkTextTheme.titleLarge?.copyWith(
                              color: Colors.black,
                            )
                                : AppTextTheme.lightTextTheme.titleLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// and here is my last line of the code i wrote before leaving , written with love <3
//i had the honor to participate in this
// will be back soon <3
// with all sorrow and sadness , i must bye bye just for now :(
