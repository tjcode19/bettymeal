part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {}

class GetUser extends UserState {
  const GetUser(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class UserError extends UserState {
  const UserError(this.msg);

  final String msg;

  @override
  List<Object> get props => [msg];
}
