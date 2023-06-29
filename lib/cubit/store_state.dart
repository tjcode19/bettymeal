part of 'store_cubit.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreError extends StoreState {
  const StoreError(this.msg);

  final String msg;

  @override
  List<Object> get props => [msg];
}

class StoreSuccess extends StoreState {
  const StoreSuccess(this.data);

  final List<StoreData> data;

  @override
  List<Object> get props => [data];
}
