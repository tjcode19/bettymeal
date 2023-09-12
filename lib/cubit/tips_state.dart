part of 'tips_cubit.dart';


abstract class TipsState extends Equatable {
  const TipsState();

  @override
  List<Object> get props => [];
}

class TipsInitial extends TipsState {}

class TipsLoad extends TipsState {
  const TipsLoad(this.data);

  final Data data;

  @override
  List<Object> get props => [data];
}



class TipsError extends TipsState {
  const TipsError(this.msg);

  final String msg;

  @override
  List<Object> get props => [msg];
}
