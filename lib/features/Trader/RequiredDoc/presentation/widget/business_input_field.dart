import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';

class BuisenessReusableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final bool dark;

  const BuisenessReusableTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.validator,
    required this.dark,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        color: dark ? AppColors.light : AppColors.placeholderTextLight,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: dark
              ? AppColors.placeholderTextDark
              : AppColors.placeholderTextLight,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: dark
              ? AppColors.placeholderTextDark
              : AppColors.placeholderTextLight,
        ),
        filled: true,
        fillColor: dark ? AppColors.textFieldBackgroundDark : AppColors.light,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: dark
                ? AppColors.verifyNumberField
                : AppColors.buttonSecondary,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: dark
                ? AppColors.strokeEnabled
                : AppColors.placeholderTextDark,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        errorStyle: const TextStyle(color: Colors.red, fontSize: 13),
      ),
      validator: validator,
    );
  }
}
