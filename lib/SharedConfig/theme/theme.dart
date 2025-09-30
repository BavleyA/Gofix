import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_colors.dart';
import 'package:gofix/core/constants/app_text_form_field_theme.dart';
import 'package:gofix/core/constants/app_text_style.dart';
import 'package:gofix/core/constants/appbar_theme.dart';

class AppTheme {

  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    // primarySwatch: Colors.blue,

    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.lightTextTheme,
    appBarTheme: ZAppBarTheme.lightAppBarTheme,
    inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.mainButton,
    // primarySwatch: AppColors.mainButton,

    scaffoldBackgroundColor: AppColors.backgroundDark,
    textTheme: AppTextTheme.darkTextTheme,
    appBarTheme: ZAppBarTheme.darkAppBarTheme,
    inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
  );
}