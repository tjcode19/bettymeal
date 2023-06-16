part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  const PaymentSuccess(this.msg);

  final String msg;

  @override
  List<Object> get props => [msg];
}

class PaymentError extends PaymentState {
  const PaymentError(this.msg);

  final String msg;

  @override
  List<Object> get props => [msg];
}
