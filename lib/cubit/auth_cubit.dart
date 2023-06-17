import 'dart:developer';

import 'package:bettymeals/cubit/user_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/api/models/GetUserDetails.dart';
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

  prepareDashboard() async {
    try {
      final cal = await userRepository.getUserDetails();
      if (cal.code != '000') {
        // emit(UserError(cal.message!));

        print('Get user details failed');
      } else {
        final now = DateTime.now();
        bool onSub = false;
        if (cal.data!.subInfo != null) {
          var h = DateTime.parse(cal.data!.subInfo!.expiryDate!);
          onSub = now.isBefore(h);
        }

        emit(LoadDashboard(cal.data!, onSub));
      }
    } catch (e) {
      print(e);
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
