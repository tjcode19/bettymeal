import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/api/models/LoginResponse.dart';
import '../data/api/repositories/authRepo.dart';
import '../data/api/repositories/userRepo.dart';
import '../data/shared_preference.dart';
import '../utils/enums.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : sharedPreference = SharedPreferenceApp(),
        authRepository = AuthRepository(),
        userRepository = UserRepository(),
        super(AuthInitial());

  final SharedPreferenceApp sharedPreference;
  final AuthRepository authRepository;
  final UserRepository userRepository;

  login(email, password) async {
    emit(AuthLoading());
    try {
      final cal = await authRepository.login(email, password);
      if (cal.code != '000') {
        emit(AuthError(cal.message!));
      } else {
        await setPrefValues(cal.data);
        emit(LoginSuccess());
      }
    } catch (e) {
      emit(AuthError(
          "Something went wrong and we are working to correct it. Thank you. $e"));
    }
  }

  sendOtp(email) async {
    emit(AuthLoading());
    try {
      final cal = await authRepository.sendOtp(email);

      inspect(cal);

      if (cal.code != '000') {
        emit(AuthError(cal.message!));
      } else {
        emit(SentOTPSuccess(cal.data!.userId!));
      }
    } catch (e) {
      emit(AuthError("Error Occured at SendOTP"));
    }
  }

  setPassword(password, userId, otp) async {
    emit(AuthLoading());
    try {
      final cal = await authRepository.setPassword(password, userId, otp);
      if (cal.code != '000') {
        emit(AuthError(cal.message!));
      } else {
        emit(SetPasswordSuccess());
      }
    } catch (e) {
      emit(AuthError(
          "Something went wrong and we are working to correct it. Thank you. $e"));
    }
  }

  setPrefValues(LoginData? d) {
    sharedPreference.setData(
        sharedType: SpDataType.bool,
        fieldName: 'firstTimer',
        fieldValue: false);
    sharedPreference.setData(
        sharedType: SpDataType.String,
        fieldName: 'token',
        fieldValue: d!.token);
    sharedPreference.setData(
        sharedType: SpDataType.String,
        fieldName: 'tokenExp',
        fieldValue: d.tokenExp);
    sharedPreference.setData(
        sharedType: SpDataType.String, fieldName: 'email', fieldValue: d.email);
  }

  logout() {
    sharedPreference.setData(
        sharedType: SpDataType.String, fieldName: 'token', fieldValue: "");
    sharedPreference.setData(
        sharedType: SpDataType.String, fieldName: 'tokenExp', fieldValue: "");
    sharedPreference.setData(
        sharedType: SpDataType.String, fieldName: 'email', fieldValue: "");
  }

  changePassword(oldPass, newPass) async {
    emit(AuthLoading());
    try {
      final cal = await authRepository.changePassword(oldPass, newPass);
      if (cal.code != '000') {
        emit(AuthError(cal.message!));
      } else {
        emit(ChangePasswordSuccess());
      }
    } catch (e) {
      emit(AuthError(
          "Something went wrong and we are working to correct it. Thank you. $e"));
    }
  }
}
