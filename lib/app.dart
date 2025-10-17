import 'package:flutter/material.dart';
import 'package:gofix/core/constants/app_elevated_button.dart';
import 'package:gofix/core/constants/app_text_form_field_theme.dart';
import 'package:gofix/core/routes/app_routes.dart';
import 'SharedConfig/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme.copyWith(
        inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
        elevatedButtonTheme:
            AppElevatedButtonTheme.lightElevatedButtonThemeData,
      ),
      darkTheme: AppTheme.darkTheme.copyWith(
        inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
        elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonThemeData,
      ),
      routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
    );
  }
}
