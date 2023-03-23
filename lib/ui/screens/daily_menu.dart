import 'package:bettymeals/routes.dart';
import 'package:bettymeals/ui/widgets/food_card.dart';
import 'package:bettymeals/ui/widgets/time_table.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../cubit/timetable_cubit.dart';
import '../../data/models/food.dart';
import '../../data/models/timetable.dart';
import '../widgets/timetable.dart';

class DailyMenuScreen extends StatefulWidget {
  const DailyMenuScreen({super.key});

  @override
  State<DailyMenuScreen> createState() => _DailyMenuScreenState();
}

class _DailyMenuScreenState extends State<DailyMenuScreen> {
  late final TimetableCubit _timetableCubit;

  DateTime currentDate = DateTime.now();
  final List<String> period = ['Breakfast', 'Lunch', 'Dinner'];

  final List<TimetableModel> timetable = [
    TimetableModel(date: DateTime.now(), foods: [
      FoodModel(description: 'Light food', image: '', name: 'Koko'),
      FoodModel(description: 'Light food', image: '', name: 'Laagba'),
      FoodModel(description: 'Light food', image: '', name: 'Rice')
    ])
  ];

  late ScrollController _scrollController;
  int _scrollPosition = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition =
          (_scrollController.position.pixels / CommonUtils.sw(context)).round();
    });
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _timetableCubit = context.read<TimetableCubit>();
    _timetableCubit.loadMeals();

    int a = 0;
    while (a < 6) {
      currentDate = currentDate.add(const Duration(days: 1));
      timetable.add(
        TimetableModel(date: currentDate, foods: [
          FoodModel(description: 'Light food', image: '', name: 'Koko'),
          FoodModel(description: 'Light food', image: '', name: 'Laagba'),
          FoodModel(description: 'Light food', image: '', name: 'Rice')
        ]),
      );

      a++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Today\'s Menu'),
      // ),
      body: Container(
        // padding: EdgeInsets.all(CommonUtils.padding),
        child: BlocBuilder<TimetableCubit, TimetableState>(
          builder: (context, state) {
            if (state is TimetableLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TimetableLoaded) {
              return Column(
                children: [
                  Container(
                    color: Colors.orange,
                    padding: EdgeInsets.only(
                        top: CommonUtils.topPadding(context, s: 1.4),
                        bottom: CommonUtils.padding,
                        right: CommonUtils.padding,
                        left: CommonUtils.padding),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(HelperMethod.formatDate(
                            timetable[_scrollPosition].date.toIso8601String(),
                            pattern: 'EEE, dd MMM, yy')),
                        Text(HelperMethod.formatDate(
                            timetable[2].date.toIso8601String(),
                            pattern: 'Breakfast')),
                        Text(HelperMethod.formatDate(
                            timetable[2].date.toIso8601String(),
                            pattern: '13:36')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: CommonUtils.sh(context, s: 0.4),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: timetable.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            width:
                                CommonUtils.sw(context) - (CommonUtils.padding),
                            height: 100,
                            child: Card(
                              child: FoodCard(
                                timetable: timetable[index],
                              ),
                            ));
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Failed to load meals.'),
              );
            }
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // TODO: Add new meal item
      //     Navigator.pushNamed(context, Routes.addFood);
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
