part of 'sub_cubit.dart';

abstract class SubState extends Equatable {
  const SubState();

  @override
  List<Object> get props => [];
}

class SubInitial extends SubState {}
class SubLoading extends SubState {}

class SubError extends SubState {
  const SubError(this.msg);

  final String msg;

  @override
  List<Object> get props => [msg];
}

class SubSuccess extends SubState {
  const SubSuccess(this.data);

  final List<SubData> data;

  @override
  List<Object> get props => [data];
}
