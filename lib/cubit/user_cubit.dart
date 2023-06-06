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
        super(UserInitial());

  final SharedPreferenceApp sharedPreference;
  final UserRepository userRepository;

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
    try {
      final cal = await userRepository.registerUser(email);

      if (cal.code != '001') {
        emit(UserError(cal.message!));
      } else {
        emit(UserSuccess());
      }
    } catch (e) {}
  }
}
