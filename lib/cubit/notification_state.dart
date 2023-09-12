part of 'notification_cubit.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoad extends NotificationState {
   const NotificationLoad(this.data);

  final Data data;

  @override
  List<Object> get props => [data];
}

class NotificationError extends NotificationState {
  const NotificationError(this.msg);

  final String msg;

  @override
  List<Object> get props => [msg];
}
