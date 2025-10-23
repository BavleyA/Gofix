import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofix/core/services/local_storage_services.dart';
import 'package:gofix/features/Login/Data/Models/Services/auth_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;

  AuthCubit(this.authService) : super(AuthInitial());

  

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final data = await authService.login(email: email, password: password);

      final token = data['token'] ?? data['accessToken'];
      if (token != null) {
        await LocalStorageService.saveToken(token);
      }

      emit(AuthSuccess(data));
    } catch (e) {
      print('👀 Exception caught in Cubit: $e');

      if (e is Map<String, dynamic>) {
        if (e['errors'] != null && e['errors'] is List) {
          final errorList = e['errors'] as List;
          emit(AuthFailure(errorList.join(', ')));
        } else if (e['message'] != null) {
          emit(AuthFailure(e['message']));
        } else if (e['title'] != null) {
          emit(AuthFailure(e['title']));
        } else {
          emit(AuthFailure('Unknown error occurred.'));
        }
      } else {
        emit(AuthFailure(e.toString()));
      }
    }
  }

  Future<void> register({
    required String email,
    required String fullName,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final data = await authService.register(
        email: email,
        fullName: fullName,
        password: password,
      );

      final token = data['token'] ?? data['accessToken'];
      if (token != null) {
        await LocalStorageService.saveToken(token);
      }

      emit(AuthSuccess(data));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

void confirmEmail(String email, String otp) async {
  emit(AuthLoading());
  try {
    final data = await authService.confirmEmail(email, otp);
    emit(AuthSuccess(data));
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}

Future<void> resendConfirmEmail(String email) async {
  emit(AuthLoading());
  try {
    await authService.resendConfirmEmail(email);

    emit(AuthResendSuccess());
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}


Future<void> forgetPassword(String email) async {
  emit(AuthLoading());
  try {
    await authService.forgetPassword(email);
    emit(AuthSuccess({'message': 'OTP sent successfully'}));
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}



Future<void> verifyOtpForNewPassword(String email, String otp) async {
  emit(AuthLoading());
  try {
    await authService.verifyOtpForNewPassword(email: email, otp: otp);
    emit(AuthSuccess({'message': 'OTP verified successfully'}));
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}



Future<void> resetPassword({
  required String email,
  required String newPassword,
}) async {
  emit(AuthLoading());
  try {
    await authService.resetPassword(
      email: email,
      newPassword: newPassword,
    );
    emit(AuthSuccess({'message': 'Password reset successfully!'}));
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}



}
