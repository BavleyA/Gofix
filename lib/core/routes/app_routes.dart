import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gofix/features/CommonPages/view/under_review_screen.dart';
import 'package:gofix/features/Login/presentation/views/forgot_password_screen_view.dart';
import 'package:gofix/features/Login/presentation/views/login_screen_view.dart';
import 'package:gofix/features/VerifyOTP/presentation/views/sign_up_screen_view.dart';
import 'package:gofix/features/VerifyOTP/presentation/views/verify_otp_screen_view.dart';

class Routes {
  const Routes._();
  static const String login = '/login';
  static const String signup = '/signup';
  static const String verify = '/verify';
  static const String underReview = '/under-review';
  static const String forgotPassword = '/forgot-password';


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
    GoRoute(
      path: Routes.underReview,
      pageBuilder: (context, state) =>
          MaterialPage(key: state.pageKey, child: const UnderReviewScreen()),
    ),
    GoRoute(
      path: Routes.forgotPassword,
      pageBuilder: (context, state) =>
          MaterialPage(key: state.pageKey, child: const ForgotPasswordScreenView()),
    ),

    GoRoute(
      path: Routes.verify,
      pageBuilder: (context, state) {
        final email = state.extra as String;
        return MaterialPage(
          key: state.pageKey,
          child: EmailVerificationView(email: email),
        );
      },
    ),
    
    
  ],
);
