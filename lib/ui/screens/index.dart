import 'package:bettymeals/cubit/user_cubit.dart';
import 'package:bettymeals/ui/screens/daily_menu/index.dart';
import 'package:bettymeals/ui/screens/plans.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../cubit/notification_cubit.dart';
import '../../data/shared_preference.dart';
import '../../services/observer.dart';
import '../../utils/enums.dart';
import 'foods/food.dart';
import 'mealtable/mealtable.dart';
import 'settings/setting.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final SharedPreferenceApp sharedPreference = SharedPreferenceApp();

  void onTabTapped(int index) {
    if (_currentIndex == 4) {
      context.read<UserCubit>().updateTribes();
    }
    setState(() {
      _currentIndex = index;
    });

    if (_currentIndex == 4) {
      context.read<UserCubit>().spGetUserData();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  logout() {
    if (_currentIndex == 0) {
      SystemNavigator.pop();
      return Future.value(true);
    } else
      onTabTapped(0);
  }

  checkNoti() async {
    final noti = await sharedPreference.getSharedPrefs(
        sharedType: SpDataType.object, fieldName: 'noti');

    if (noti != null) {
      context.read<NotificationCubit>().gotoNoti(context);
    }
  }

  @override
  void initState() {
    super.initState();

    checkNoti();
    final AppLifecycleObserver lifecycleObserver =
        AppLifecycleObserver(context);
    WidgetsBinding.instance.addObserver(lifecycleObserver);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => logout(),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            DailyMenuScreen(),
            MealTableScreen(),
            PlansScreen(),
            FoodScreen(),
            SettingScreen()
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'homeScreen',
          onPressed: () {
            onTabTapped(0);
          },
          shape: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset('assets/icons/food-icon-w.svg',
                semanticsLabel: 'A red up arrow'),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Theme(
          data: ThemeData(useMaterial3: false),
          child: BottomAppBar(
            notchMargin: 5.0,
            // height: CommonUtils.sh(context, s: 0.1),
            shape: const CircularNotchedRectangle(),
            color: AppColour(context).primaryColour,
            child: IconTheme(
              data: IconThemeData(color: AppColour(context).onPrimaryColour),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        button(
                          onPressed: () => onTabTapped(1),
                          label: 'Meal',
                          icon: Icons.food_bank_outlined,
                          index: 1,
                        ),
                        button(
                          onPressed: () => onTabTapped(2),
                          label: 'Plans',
                          icon: Icons.dinner_dining_outlined,
                          index: 2,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        button(
                          onPressed: () => onTabTapped(3),
                          label: 'Foods',
                          icon: Icons.list_alt_outlined,
                          index: 3,
                        ),
                        button(
                          onPressed: () => onTabTapped(4),
                          label: 'Account',
                          icon: Icons.settings_outlined,
                          index: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget button(
      {required Function() onPressed,
      required String label,
      required IconData icon,
      required int index}) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 80,
        width: CommonUtils.sw(context, s: 0.16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: _currentIndex == index
                  ? AppColour(context).onPrimaryColour
                  : AppColour(context).onPrimaryColour.withOpacity(0.7),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: _currentIndex == index
                      ? AppColour(context).onPrimaryColour
                      : AppColour(context).onPrimaryColour.withOpacity(0.7)),
            ),
          ],
        ),
      ),
    );

    // Padding(
    //   padding: const EdgeInsets.all(10.0),
    //   child: IconButton(
    //     onPressed: onPressed,
    //     padding: EdgeInsets.zero,
    //     // iconSize: 30,
    //     // constraints: BoxConstraints(),
    //     icon: Column(
    //       // crossAxisAlignment: CrossAxisAlignment.center,
    //       // alignment:WrapAlignment.center,
    //       // direction: Axis.horizontal,
    //       children: [
    //         Expanded(child: icon),
    //         Expanded(
    //             child: Text(
    //           label,
    //           softWrap: false,
    //         ))
    //       ],
    //     ),
    //   ),
    // );
  }
}
