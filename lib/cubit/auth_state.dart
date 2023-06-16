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

class LoginSuccess extends AuthState {
  const LoginSuccess(this.data, this.isActiveSub);

  final LoginData data;
  final bool isActiveSub;

  @override
  List<Object> get props => [data, isActiveSub];
}

class ChangePasswordSuccess extends AuthState {
}
