part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Map<String, dynamic> data;
  AuthSuccess(this.data);
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class AuthResendSuccess extends AuthState {}