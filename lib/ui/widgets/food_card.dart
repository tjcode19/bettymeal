import 'package:bettymeals/data/models/timetable.dart';
import 'package:bettymeals/ui/widgets/food_item.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../utils/colours.dart';
import 'food_item_sub.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({super.key, required this.timetable});

  final TimetableModel timetable;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            textTheme: Theme.of(context)
                .textTheme
                .apply(displayColor: Colors.white, bodyColor: Colors.white),
          ),
          child: FoodItem(
            timetable: timetable,
            foodType: 0,
            mealType: 'Breakfast',
            sizeW: 50,
          ),
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.all(CommonUtils.padding),
            child: Theme(
              data: Theme.of(context).copyWith(
                textTheme: Theme.of(context).textTheme.apply(
                    displayColor: AppColour(context).onSecondaryColour,
                    bodyColor: AppColour(context).onSecondaryColour),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FoodItemSub(
                    timetable: timetable,
                    foodType: 1,
                    mealType: 'Lunch',
                  ),
                  FoodItemSub(
                    timetable: timetable,
                    foodType: 2,
                    mealType: 'Dinner',
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
