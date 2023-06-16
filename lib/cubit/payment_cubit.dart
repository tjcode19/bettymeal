import 'package:bettymeals/data/api/repositories/paymentRepo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/shared_preference.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit()
      : sharedPreference = SharedPreferenceApp(),
        paymentRepository = PaymentRepository(),
        super(PaymentInitial());

  final SharedPreferenceApp sharedPreference;
  final PaymentRepository paymentRepository;

  makePayment(email) async {
    emit(PaymentLoading());
    try {
      final cal = await paymentRepository.makePayment(email);
      if (cal.code != '000') {
        emit(PaymentError(cal.message!));
      } else {
        emit(PaymentSuccess(''));
      }
    } catch (e) {}
  }
}
