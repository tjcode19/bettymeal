import 'package:bettymeals/data/api/repositories/userRepo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/api/models/GetUserDetails.dart';
import '../data/shared_preference.dart';
import '../utils/enums.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit()
      : this.userRepository = UserRepository(),
        sharedPreference = SharedPreferenceApp(),
        super(DashboardInitial());

  final UserRepository userRepository;
  final SharedPreferenceApp sharedPreference;

  prepareDashboard() async {
    emit(DashboardInitial());
    try {
      final cal = await userRepository.getUserDetails();
      if (cal.code != '000') {
        print('Get user details failed');
      } else {
        print('I am here ${cal.data!.user!.email!}');
        bool onSub = false;
        if (cal.data!.activeSub!.length > 0) {
          onSub = true;
        }

        sharedPreference.setData(
            sharedType: SpDataType.object,
            fieldName: 'userData',
            fieldValue: cal.data);

        emit(LoadDashboard(
          cal.data!,
          onSub,
        ));
      }
    } catch (e) {
      print(e);
    }
  }
}
