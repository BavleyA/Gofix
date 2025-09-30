import 'package:flutter/material.dart';

import 'app_colors.dart' show AppColors;

class AppTextFormFieldTheme {


  AppTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle().copyWith(color: Colors.black, fontSize: 14),
    hintStyle: const TextStyle().copyWith(color: Colors.black, fontSize: 14),
    errorStyle:
        const TextStyle().copyWith(color: Colors.red, fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: Colors.black.withOpacity(0.8), fontSize: 14),
    border: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.grey, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.black, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.grey, width: 1.5),
    ),
    errorBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.red, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.textFieldBackgroundDark,
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle().copyWith(color: Colors.white, fontSize: 14),
    hintStyle: const TextStyle().copyWith(color: Colors.white, fontSize: 14),
    errorStyle:
        const TextStyle().copyWith(color: Colors.red, fontStyle: FontStyle.normal),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.grey, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: AppColors.strokeEnabled, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: AppColors.strokeEnabled, width: 1.5),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.strokeDisabled , width: 1.5),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
    ),
  );
}