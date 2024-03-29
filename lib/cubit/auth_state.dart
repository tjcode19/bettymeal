part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  const AuthError(this.msg);

  final String msg;

  @override
  List<Object> get props => [msg];
}

class LoginSuccess extends AuthState {}
class LoginSuccessToken extends AuthState {
  const LoginSuccessToken(this.userId, this.email);
  final String userId;
  final String email;

  @override
  List<Object> get props => [userId, email];
}

class SetPasswordSuccess extends AuthState {}

class SentOTPSuccess extends AuthState {
  const SentOTPSuccess(this.userId);
  final String userId;

  @override
  List<Object> get props => [userId];

}

class ChangePasswordSuccess extends AuthState {}
