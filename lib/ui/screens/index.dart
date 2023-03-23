import 'package:bettymeals/routes.dart';
import 'package:bettymeals/ui/screens/daily_menu.dart';
import 'package:bettymeals/ui/screens/timetable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../cubit/timetable_cubit.dart';
import '../widgets/timetable.dart';
import 'food.dart';

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
        children: const [DailyMenuScreen(), TimetableScreen(), FoodScreen()],
      ),
      bottomNavigationBar: _bottom(),
    );
  }

  Widget _bottom() {
    return BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Image(
            width: 24,
            height: 24,
            image: Svg('assets/icons/meal.svg'),
          ),
          label: 'Meal',
        ),
        BottomNavigationBarItem(
          icon: Image(
            width: 24,
            height: 24,
            image: Svg('assets/icons/table.svg'),
          ),
          label: 'Timetable',
        ),
        BottomNavigationBarItem(
          icon: Image(
            width: 24,
            height: 24,
            image: Svg('assets/icons/table.svg'),
          ),
          label: 'Food',
        )
      ],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      // selectedLabelStyle: TextStyle(
      //   color: Colors.transparent, // Step 2 SEE HERE
      //   shadows: [
      //     Shadow(offset: Offset(0, -20), color: Colors.white)
      //   ], // Step 3 SEE HERE
      //   decoration: TextDecoration.underline,
      //   decorationStyle: TextDecorationStyle.dashed,
      //   decorationColor: Colors.redAccent,
      // ),
    );
  }
}
