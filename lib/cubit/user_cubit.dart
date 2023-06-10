import 'dart:developer';

import 'package:bettymeals/data/api/repositories/authRepo.dart';
import 'package:bettymeals/data/api/repositories/userRepo.dart';
import 'package:bettymeals/data/shared_preference.dart';
import 'package:bettymeals/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit()
      : sharedPreference = SharedPreferenceApp(),
        userRepository = UserRepository(),
        authRepository = AuthRepository(),
        super(UserInitial());

  final SharedPreferenceApp sharedPreference;
  final UserRepository userRepository;
  final AuthRepository authRepository;

  setUserDetails(name, gender) {
    sharedPreference.setData(
        sharedType: SpDataType.String, fieldName: 'name', fieldValue: name);
    sharedPreference.setData(
        sharedType: SpDataType.String, fieldName: 'gender', fieldValue: gender);
  }

  setFirstTimer(v) {
    sharedPreference.setData(
        sharedType: SpDataType.bool, fieldName: 'firstTimer', fieldValue: v);
  }

  getUserDetails() async {
    try {
      final name = await sharedPreference.getSharedPrefs(
          sharedType: SpDataType.String, fieldName: 'name');

      emit(GetUser(name));
    } catch (e) {
      print(e);
    }
  }

  userRegistration(email) async {
    emit(UserLoading());
    try {
      final cal = await userRepository.registerUser(email);

      print(cal);
      inspect(cal);

      if (cal.code != '001') {
        emit(UserError(cal.message!));
      } else {
        emit(UserSuccess(cal.data!.sId!, cal.data!.email!));
      }
    } catch (e) {}
  }

  verifyEmail(otp, password, userId) async {
    emit(UserLoading());
    try {
      final cal = await userRepository.verifyEmail(otp, password, userId);

      print(cal);

      inspect(cal);

      if (cal.code != '001') {
        emit(UserError(cal.message!));
      } else {
        setFirstTimer(false);
        emit(VerifyEmailSuccess());
      }
    } catch (e) {
      emit(UserError("Error Occured"));
      print(e);
    }
  }

  isActiveSub() {
    return true;
  }

  sendOtp(email) async {
    emit(UserLoading());
    try {
      final cal = await authRepository.sendOtp(email);

      print(cal);

      inspect(cal);

      if (cal.code != '000') {
        emit(UserError(cal.message!));
      } else {
        emit(SendOtpSuccess());
      }
    } catch (e) {
      emit(UserError("Error Occured"));
      print(e);
    }
  }
}
