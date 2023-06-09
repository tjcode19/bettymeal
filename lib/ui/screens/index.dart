import 'package:bettymeals/ui/screens/daily_menu/index.dart';
import 'package:bettymeals/ui/screens/records/index.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';

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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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

  @override
  void initState() {
    super.initState();
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
            FoodScreen(),
            RecordsScreen(),
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
                          label: 'Food',
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
                          label: 'Records',
                          icon: Icons.list_alt_outlined,
                          index: 3,
                        ),
                        button(
                          onPressed: () => onTabTapped(4),
                          label: 'Settings',
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
