import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/api/models/GetSubscription.dart';
import '../data/api/models/GetUserDetails.dart';
import '../data/api/repositories/subRepo.dart';
import '../data/shared_preference.dart';
import '../utils/enums.dart';

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

      inspect(cal);
      if (cal.code != '000') {
        emit(SubError(cal.message!));
      } else {
        emit(SubSuccess(cal.data!));
      }
    } catch (e) {
      emit(SubError("Error Occured"));
    }
  }

  getActiveSub() async {
    final userData = await sharedPreference.getSharedPrefs(
        sharedType: SpDataType.object, fieldName: 'userData');
         UserData uData = UserData.fromJson(userData);

    int? regenerate;
    int l = uData.activeSub!.length;
    if (l > 0) {
      regenerate = uData.activeSub!.first.subData!.regenerate;
    }

   

    emit(ActiveSuccessLoaded(uData.activeSub!.first, regenerate!));
  }
}
