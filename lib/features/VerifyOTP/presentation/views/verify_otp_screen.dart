import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_strings.dart';
import 'dart:async';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/utils/helper.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  bool _hasError = false;
  int _countdown = 20;
  Timer? _timer;

  final List<TextEditingController> _controllers = List.generate(
    5,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());

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
    final dark = Helper.isDarkMode(context);

    if (enteredCode == '25017') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.verificationSuccessText),
          backgroundColor: dark
              ? AppColors.secondaryBlack.withOpacity(0.8)
              : AppColors.imageCard.withOpacity(0.9),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Code sent!')));
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
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
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
                      _isCodeComplete
                          ? AppStrings.verifyText
                          : AppStrings.enterCodeText,
                      style: dark
                          ? AppTextTheme.darkTextTheme.headlineLarge!.copyWith(
                              color: AppColors.imageCard,
                              fontSize: 36,
                            )
                          : AppTextTheme.lightTextTheme.headlineLarge!.copyWith(
                              color: AppColors.secondaryBlack,
                              fontSize: 36,
                            ),
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 14),

                    Text(
                      AppStrings.codeSentText,
                      style: dark
                          ? AppTextTheme.darkTextTheme.headlineLarge!.copyWith(
                              color: AppColors.imageCard,
                              fontSize: 18,
                            )
                          : AppTextTheme.lightTextTheme.headlineLarge!.copyWith(
                              color: AppColors.textSecondaryBlack,
                              fontSize: 18,
                            ),
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
                          AppStrings.changeNumText,
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

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: List.generate(5, (index) {
                    //     final boxSize = isSmallScreen ? 50.0 : 56.0;
                    //     final spacing = isSmallScreen ? 8.0 : 12.0;

                    //     return Container(
                    //       margin: EdgeInsets.only(
                    //         right: index < 4 ? spacing : 0,
                    //       ),
                    //       width: boxSize,
                    //       height: boxSize,
                    //       decoration: BoxDecoration(
                    //         color: dark
                    //             ? const Color(0xFF1A2938)
                    //             : Colors.grey[200],
                    //         borderRadius: BorderRadius.circular(12),
                    //         border: Border.all(
                    //           color: _hasError
                    //               ? Colors.red.withOpacity(0.5)
                    //               : _focusNodes[index].hasFocus
                    //               ? (dark
                    //                     ? AppColors.mainButton
                    //                     : AppColors.primary)
                    //               : Colors.transparent,
                    //           width: 2,
                    //         ),
                    //       ),
                    //       child: TextField(
                    //         controller: _controllers[index],
                    //         focusNode: _focusNodes[index],
                    //         textAlign: TextAlign.center,
                    //         keyboardType: TextInputType.number,
                    //         maxLength: 1,
                    //         style: TextStyle(
                    //           color: dark ? Colors.white : Colors.black,
                    //           fontSize: isSmallScreen ? 20 : 24,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //         decoration: const InputDecoration(
                    //           counterText: '',
                    //           border: InputBorder.none,
                    //           contentPadding: EdgeInsets.zero,
                    //         ),
                    //         onChanged: (value) {
                    //           if (value.isEmpty && index > 0) {
                    //             _focusNodes[index - 1].requestFocus();
                    //           }
                    //         },
                    //         onTap: () {
                    //           if (_controllers[index].text.isEmpty &&
                    //               index > 0) {
                    //             _focusNodes[index - 1].requestFocus();
                    //           }
                    //         },
                    //       ),
                    //     );
                    //   }),
                    // ),

                    // if (_hasError) ...[
                    //   const SizedBox(height: 16),
                    //   const Text(
                    //     AppStrings.wrongCodeText,
                    //     style: TextStyle(color: Colors.red, fontSize: 14),
                    //   ),
                    // ],
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final boxSize = isSmallScreen ? 50.0 : 56.0;
                          final spacing = isSmallScreen ? 8.0 : 12.0;

                          final baseColor = dark
                              ? const Color(0xFF22344D)
                              : const Color(0xFFFFFFFF);
                          final borderColor = dark
                              ? const Color(0xFF2F3E52)
                              : const Color(0xFFB9C8D6);
                          final focusedColor = dark
                              ? const Color(0xFF4A6FA1)
                              : const Color(0xFF375D84);

                          return Row(
                            children: [
                              SizedBox(
                                width: boxSize,
                                height: boxSize,
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
                                  decoration: InputDecoration(
                                    counterText: '',
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
                                      borderSide: BorderSide(
                                        color: focusedColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty && index < 4) {
                                      _focusNodes[index + 1].requestFocus();
                                    } else if (value.isEmpty && index > 0) {
                                      _focusNodes[index - 1].requestFocus();
                                    }
                                  },
                                ),
                              ),
                              if (index < 4) SizedBox(width: spacing),
                            ],
                          );
                        }),
                      ),
                    ),

                    if (_hasError) ...[
                      const SizedBox(height: 16),
                      const Text(
                        AppStrings.wrongCodeText,
                        style: TextStyle(color: Colors.red, fontSize: 14),
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
                            AppStrings.sendCodeAgainText,
                            style: TextStyle(
                              color: _countdown == 0
                                  ? (dark
                                        ? AppColors.mainButton
                                        : AppColors.primary)
                                  : (dark
                                        ? Colors.white.withOpacity(0.5)
                                        : Colors.grey),
                              fontSize: 15,
                              // decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '00:${_countdown.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            color: dark
                                ? Colors.white.withOpacity(0.5)
                                : Colors.grey,
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
                            backgroundColor: dark
                                ? AppColors.mainButton
                                : AppColors.buttonPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            AppStrings.callInsteadText,
                            style: dark
                                ? AppTextTheme.darkTextTheme.titleLarge
                                      ?.copyWith(color: AppColors.light)
                                : AppTextTheme.lightTextTheme.titleLarge
                                      ?.copyWith(color: AppColors.light),
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
                              AppStrings.didntRecieveText,
                              style: dark
                                  ? AppTextTheme.darkTextTheme.headlineLarge!
                                        .copyWith(
                                          color: AppColors.imageCard,
                                          fontSize: 14,
                                        )
                                  : AppTextTheme.lightTextTheme.headlineLarge!
                                        .copyWith(
                                          color: AppColors.textSecondaryBlack,
                                          fontSize: 14,
                                        ),
                            ),
                            Text(
                              AppStrings.resendText,
                              style: dark
                                  ? AppTextTheme.darkTextTheme.titleLarge
                                        ?.copyWith(
                                          color: AppColors.mainButton,
                                          decoration: TextDecoration.underline,
                                          fontSize: 14,
                                        )
                                  : AppTextTheme.lightTextTheme.titleLarge
                                        ?.copyWith(
                                          color: AppColors.primary,
                                          decoration: TextDecoration.underline,
                                          fontSize: 14,
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
                            backgroundColor: dark
                                ? AppColors.mainButton
                                : AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            AppStrings.verifyseText,
                            style: dark
                                ? AppTextTheme.darkTextTheme.titleLarge
                                      ?.copyWith(color: Colors.black)
                                : AppTextTheme.lightTextTheme.titleLarge
                                      ?.copyWith(color: Colors.white),
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
