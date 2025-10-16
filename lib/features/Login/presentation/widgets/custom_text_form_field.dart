import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final IconData? icon;
  final IconData? suffixIcon;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool dark;

  const CustomTextFormField({
    super.key,
    this.keyboardType = TextInputType.text,
    required this.dark,
    required this.labelText,
    required this.controller,
    this.icon,
    this.suffixIcon,
    required this.onChanged,
    required this.validator,
    this.obscureText = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction, // 👈 الحل هنا
      style: TextStyle(
        color: widget.dark ? AppColors.light : AppColors.placeholderTextLight,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: widget.dark
              ? AppColors.placeholderTextDark
              : AppColors.placeholderTextLight,
        ),
        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon,
                color: widget.dark
                    ? AppColors.placeholderTextDark
                    : AppColors.placeholderTextLight,
              )
            : null,
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: widget.dark
                      ? AppColors.placeholderTextDark
                      : AppColors.placeholderTextLight,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: widget.dark
            ? AppColors.textFieldBackgroundDark
            : AppColors.light,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: widget.dark
                ? AppColors.verifyNumberField
                : AppColors.buttonSecondary,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: widget.dark
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
      onChanged: (value) {
        widget.onChanged(value);
      },
      validator: widget.validator,
    );
  }
}
