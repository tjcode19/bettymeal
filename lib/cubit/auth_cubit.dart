import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/api/models/LoginResponse.dart';
import '../data/api/repositories/authRepo.dart';
import '../data/shared_preference.dart';
import '../utils/enums.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : sharedPreference = SharedPreferenceApp(),
        authRepository = AuthRepository(),
        super(AuthInitial());

  final SharedPreferenceApp sharedPreference;
  final AuthRepository authRepository;

  login(email, password) async {
    emit(AuthLoading());
    try {
      final cal = await authRepository.login(email, password);
      if (cal.code != '000') {
        emit(AuthError(cal.message!));
      } else {
        final now = DateTime.now();
        bool onSub = false;
        if (cal.data!.subInfo != null) {
          var h = DateTime.parse(cal.data!.subInfo!.expiryDate!);
          onSub = now.isBefore(h);
        }

        sharedPreference.setData(
            sharedType: SpDataType.bool,
            fieldName: 'firstTimer',
            fieldValue: false);
        sharedPreference.setData(
            sharedType: SpDataType.String,
            fieldName: 'token',
            fieldValue: cal.data!.token);
        sharedPreference.setData(
            sharedType: SpDataType.object,
            fieldName: 'userData',
            fieldValue: cal.data!);
        emit(LoginSuccess(cal.data!, onSub));
      }
    } catch (e) {
      emit(AuthError(
          "Something went wrong and we are working to correct it. Thank you. $e"));
    }
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
