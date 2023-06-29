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
    emit(DashboardLoading());
    try {
      final cal = await userRepository.getUserDetails();
      if (cal.code != '000') {
        print('Get user details failed');
      } else {
        bool onSub = false;
        int? shuffle;
        int l = cal.data?.activeSub!.length ?? 0;
        if (l > 0) {
          onSub = true;
          final gh = cal.data?.activeSub!.first.timetable!.length ?? 0;
          shuffle = gh <= 7
              ? cal.data!.activeSub![0].sub!.period!.week!.shuffle
              : cal.data!.activeSub![0].sub!.period?.month?.shuffle;
        }

        sharedPreference.setData(
            sharedType: SpDataType.object,
            fieldName: 'userData',
            fieldValue: cal.data);

        emit(LoadDashboard(cal.data!, onSub, shuffle ?? 0));
      }
    } catch (e) {
      print(e);
    }
  }
}
