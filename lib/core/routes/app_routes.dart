import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gofix/features/Login/presentation/views/login_screen_view.dart';
import 'package:gofix/features/VerifyOTP/presentation/views/sign_up_Screen_view.dart';

class Routes {
  const Routes._();
  static const String login = '/login';
  static const String signup = '/signup';
}

/// GoRouter instance
final appRouter = GoRouter(
  initialLocation: Routes.login,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: Routes.login,
      pageBuilder: (context, state) =>
          MaterialPage(key: state.pageKey, child: const LoginView()),
    ),
    GoRoute(
      path: Routes.signup,
      pageBuilder: (context, state) =>
          MaterialPage(key: state.pageKey, child: const SignUpView()),
    ),
  ],
);
