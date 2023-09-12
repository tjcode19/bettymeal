part of 'notification_cubit.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class MessageLoaded extends NotificationState {
  const MessageLoaded(this.msgs);

  final List<Data> msgs;

  @override
  List<Object> get props => [msgs];
}

class NotificationError extends NotificationState {
  const NotificationError(this.msg);

  final String msg;

  @override
  List<Object> get props => [msg];
}
