import 'package:bettymeals/data/shared_preference.dart';
import 'package:bettymeals/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit()
      : sharedPreference = SharedPreferenceApp(),
        super(UserInitial());

  final SharedPreferenceApp sharedPreference;

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
}
