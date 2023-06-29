import 'dart:developer';
import 'dart:math';

import 'package:bettymeals/cubit/auth_cubit.dart';
import 'package:bettymeals/data/api/models/LoginResponse.dart';
import 'package:bettymeals/data/api/repositories/authRepo.dart';
import 'package:bettymeals/data/api/repositories/userRepo.dart';
import 'package:bettymeals/data/shared_preference.dart';
import 'package:bettymeals/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/api/models/GetUserDetails.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit()
      : sharedPreference = SharedPreferenceApp(),
        userRepository = UserRepository(),
        authRepository = AuthRepository(),
        authCubit = AuthCubit(),
        super(UserInitial());

  final SharedPreferenceApp sharedPreference;
  final UserRepository userRepository;
  final AuthRepository authRepository;
  final AuthCubit authCubit;

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
      final cal = await userRepository.getUserDetails();
      if (cal.code != '000') {
        emit(UserError(cal.message!));
      } else {
        sharedPreference.setData(
            sharedType: SpDataType.String,
            fieldName: 'email',
            fieldValue: cal.data!.user!.email);
        emit(GetUser(cal.data!));
      }
    } catch (e) {
      print(e);
    }
  }

  userRegistration(email) async {
    emit(UserLoading());
    try {
      final cal = await userRepository.registerUser(email);
      if (cal.code != '001') {
        emit(UserError(cal.message!));
      } else {
        emit(UserSuccess(cal.data!.sId!, cal.data!.email!));
      }
    } catch (e) {}
  }

  updateUser(fName, lName, dob, gender, phNumber) async {
    emit(UserLoading());
    try {
      final cal = await userRepository.updateUser(
          fName: fName,
          lName: lName,
          dob: dob,
          gender: gender,
          phNumber: phNumber);
      if (cal.code != '000') {
        emit(UserError(cal.message!));
      } else {
        emit(UpdateUserSuccess());
        // setPrefValues(cal.data);
      }
    } catch (e) {}
  }

  verifyEmail(otp, password, userId) async {
    emit(UserLoading());
    try {
      final cal = await userRepository.verifyEmail(otp, password, userId);
      if (cal.code != '001') {
        emit(UserError(cal.message!));
      } else {
        // await getUserDetails();
        authCubit.setPrefValues(cal.data);

        // authCubit.prepareDashboard();

        emit(VerifyEmailSuccess());
      }
    } catch (e) {
      emit(UserError("Error Occured"));
    }
  }

  isActiveSub({v = false}) {
    return v;
  }

  spGetUserData() async {
    final userData = await sharedPreference.getSharedPrefs(
        sharedType: SpDataType.object, fieldName: 'userData');

    final email = await sharedPreference.getSharedPrefs(
            sharedType: SpDataType.String, fieldName: 'email') ??
        '';

    UserData uData = UserData.fromJson(userData);
    emit(SpGetData(uData, email));
  }

  sendOtp(email) async {
    emit(UserLoading());
    try {
      final cal = await authRepository.sendOtp(email);

      if (cal.code != '000') {
        emit(UserError(cal.message!));
      } else {
        emit(SendOtpSuccess());
      }
    } catch (e) {
      emit(UserError("Error Occured at SendOTP"));
    }
  }

  setPrefValues(d) {
    sharedPreference.setData(
        sharedType: SpDataType.String,
        fieldName: 'token',
        fieldValue: d!.token);
    sharedPreference.setData(
        sharedType: SpDataType.String,
        fieldName: 'email',
        fieldValue: d!.email);
    sharedPreference.setData(
        sharedType: SpDataType.object, fieldName: 'userData', fieldValue: d!);
  }
}
