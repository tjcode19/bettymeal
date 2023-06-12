import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/api/models/GetSubscription.dart';
import '../data/api/repositories/subRepo.dart';
import '../data/shared_preference.dart';

part 'sub_state.dart';

class SubCubit extends Cubit<SubState> {
  SubCubit()
      : sharedPreference = SharedPreferenceApp(),
        subRepository = SubRepository(),
        super(SubInitial());

  final SharedPreferenceApp sharedPreference;
  final SubRepository subRepository;

  getSubscription() async {
    emit(SubLoading());
    try {
      final cal = await subRepository.getSubscription();
      if (cal.code != '000') {
        emit(SubError(cal.message!));
      } else {
        emit(SubSuccess(cal.data!));
      }
    } catch (e) {
      emit(SubError("Error Occured"));
    }
  }
}
