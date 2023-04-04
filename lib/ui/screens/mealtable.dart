import 'dart:math';

import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../data/models/food_data.dart';
import '../../utils/colours.dart';
import '../widgets/time_table.dart';

class MealTableScreen extends StatefulWidget {
  const MealTableScreen({super.key});

  @override
  State<MealTableScreen> createState() => _MealTableScreenState();
}

class _MealTableScreenState extends State<MealTableScreen> {
  Random random = Random();
  List<Food> breakfasts =
      food.where(((element) => element.type.contains(1))).toList();

  List<Food> lunch =
      food.where(((element) => element.type.contains(2))).toList();

  List<Food> dinner =
      food.where(((element) => element.type.contains(3))).toList();

  late List<TimeTableMeal> meals;
  late TimeTableMeal todayMeal;

  int getRad(lim) {
    return random.nextInt(lim);
  }

  void buildMeal() {
    meals = [
      TimeTableMeal(day: 'Mon', bFast: {
        "meal": breakfasts[getRad(breakfasts.length)],
        "time": "7am - 10am"
      }, lunch: {
        "meal": lunch[getRad(lunch.length)],
        "time": "1pm - 3pm"
      }, dinner: {
        "meal": dinner[getRad(dinner.length)],
        "time": "6pm - 18pm"
      }),
      TimeTableMeal(day: 'Tue', bFast: {
        "meal": breakfasts[getRad(breakfasts.length)],
        "time": "7am - 10am"
      }, lunch: {
        "meal": lunch[getRad(lunch.length)],
        "time": "1pm - 3pm"
      }, dinner: {
        "meal": dinner[getRad(dinner.length)],
        "time": "6pm - 18pm"
      }),
      TimeTableMeal(day: 'Wed', bFast: {
        "meal": breakfasts[getRad(breakfasts.length)],
        "time": "7am - 10am"
      }, lunch: {
        "meal": lunch[getRad(lunch.length)],
        "time": "1pm - 3pm"
      }, dinner: {
        "meal": dinner[getRad(dinner.length)],
        "time": "6pm - 18pm"
      }),
      TimeTableMeal(day: 'Thur', bFast: {
        "meal": breakfasts[getRad(breakfasts.length)],
        "time": "7am - 10am"
      }, lunch: {
        "meal": lunch[getRad(lunch.length)],
        "time": "1pm - 3pm"
      }, dinner: {
        "meal": dinner[getRad(dinner.length)],
        "time": "6pm - 18pm"
      }),
      TimeTableMeal(day: 'Fri', bFast: {
        "meal": breakfasts[getRad(breakfasts.length)],
        "time": "7am - 10am"
      }, lunch: {
        "meal": lunch[getRad(lunch.length)],
        "time": "1pm - 3pm"
      }, dinner: {
        "meal": dinner[getRad(dinner.length)],
        "time": "6pm - 18pm"
      }),
      TimeTableMeal(day: 'Sat', bFast: {
        "meal": breakfasts[getRad(breakfasts.length)],
        "time": "7am - 10am"
      }, lunch: {
        "meal": lunch[getRad(lunch.length)],
        "time": "1pm - 3pm"
      }, dinner: {
        "meal": dinner[getRad(dinner.length)],
        "time": "6pm - 18pm"
      }),
      TimeTableMeal(day: 'Sun', bFast: {
        "meal": breakfasts[getRad(breakfasts.length)],
        "time": "7am - 10am"
      }, lunch: {
        "meal": lunch[getRad(lunch.length)],
        "time": "1pm - 3pm"
      }, dinner: {
        "meal": dinner[getRad(dinner.length)],
        "time": "6pm - 18pm"
      }),
    ];

    todayMeal = meals.where(((element) => element.day.contains("Tue"))).first;
  }

  @override
  void initState() {
    super.initState();

    buildMeal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Food Bank',
            style: TextStyle(color: AppColour(context).onPrimaryColour),
          ),
          backgroundColor: AppColour(context).primaryColour,
        ),
        body: Container(
          padding: EdgeInsets.all(CommonUtils.padding),
          child: Column(
            children: [
              TimeTable(
                key: const ValueKey("time_table"),
                meals: meals,
              ),
              TextButton(onPressed: () {}, child: Text('Generate Timetabel'))
            ],
          ),
        ));
  }
}
