import 'package:bettymeals/routes.dart';
import 'package:bettymeals/ui/screens/daily_menu/index.dart';
import 'package:bettymeals/ui/screens/dishes/dishes.dart';
import 'package:bettymeals/ui/screens/timetable.dart';
import 'package:bettymeals/utils/colours.dart';
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
  bool visible = true;
  int timer = 500;

  void onTabTapped(int index) {
    //Check if currentIndex is not equals index
    if (_currentIndex != 1 && index == 1) {
      setState(() {
        visible = false;
      });
    }
    if (_currentIndex != 0 && index == 0) {
      setState(() {
        visible = true;
      });
    }

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
    _timetableCubit = context.read<TimetableCubit>();
    _timetableCubit.loadMeals();
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
          TimetableScreen(),
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
            'assets/icons/meal.svg',
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(useMaterial3: false),
        child: BottomAppBar(
          notchMargin: 5.0,
          // height: 100,
          shape: CircularNotchedRectangle(),
          color: AppColour(context).primaryColour,
          child: IconTheme(
            data: IconThemeData(color: AppColour(context).onPrimaryColour),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    button(
                      onPressed: () => onTabTapped(1),
                      label: 'Dishes',
                      icon: Image(
                        width: 20,
                        height: 20,
                        image: Svg(
                          'assets/icons/table.svg',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    button(
                        onPressed: () => onTabTapped(2),
                        label: 'Food',
                        icon: Icon(Icons.settings)),
                  ],
                ),
                Row(
                  children: [
                    button(
                        onPressed: () => onTabTapped(3),
                        label: 'Meal Table',
                        icon: Icon(Icons.settings)),
                    button(
                        onPressed: () => onTabTapped(4),
                        label: 'Settings',
                        icon: Icon(Icons.settings))
                  ],
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
      required Widget icon}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: IconButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        // iconSize: 30,
        // constraints: BoxConstraints(),
        icon: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // alignment:WrapAlignment.center,
          // direction: Axis.horizontal,
          children: [Expanded(child: icon), Flexible(child: Text(label, softWrap: false,))],
        ),
      ),
    );
  }
}
