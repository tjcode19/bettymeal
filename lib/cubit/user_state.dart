part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class VerifyEmailSuccess extends UserState {}


class SendOtpSuccess extends UserState {}

class UserSuccess extends UserState {
  const UserSuccess(this.userId, this.email);

  final String userId;
  final String email;

  @override
  List<Object> get props => [userId, email];
}

class GetUser extends UserState {
  const GetUser(this.uData);

  final UserData uData;

  @override
  List<Object> get props => [uData];
}

class UserError extends UserState {
  const UserError(this.msg);

  final String msg;

  @override
  List<Object> get props => [msg];
}
