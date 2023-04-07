import 'package:bettymeals/routes.dart';
import 'package:bettymeals/ui/screens/daily_menu/index.dart';
import 'package:bettymeals/ui/screens/dishes/dishes.dart';
import 'package:bettymeals/ui/screens/mealtable.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../cubit/timetable_cubit.dart';
import '../widgets/timetable.dart';
import 'foods/food.dart';
import 'setting.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TimetableCubit _timetableCubit;

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

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          DailyMenuScreen(),
          DishesScreen(),
          FoodScreen(),
          MealTableScreen(),
          SettingScreen()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'homeScreen',
        onPressed: () {
          // Navigator.pushNamed(context, Routes.addFood);
          onTabTapped(0);
        },
        shape: const CircleBorder(),
        child: const Image(
          width: 24,
          height: 24,
          image: Svg(
            'assets/icons/home.svg',
            color: Colors.white,
          ),
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
                        label: 'Dishes',
                        icon: Icons.list_alt_outlined,
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
                        label: 'Meal',
                        icon: Icons.food_bank_outlined,
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
                  : AppColour(context).onPrimaryColour.withOpacity(0.5),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: _currentIndex == index
                      ? AppColour(context).onPrimaryColour
                      : AppColour(context).onPrimaryColour.withOpacity(0.5)),
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
