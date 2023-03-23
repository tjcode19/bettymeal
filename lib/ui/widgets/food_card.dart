import 'package:bettymeals/data/models/timetable.dart';
import 'package:bettymeals/ui/widgets/food_item.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({super.key, required this.timetable});

  final TimetableModel timetable;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FoodItem(
          timetable: timetable,
          foodType: 0,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(CommonUtils.padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FoodItem(
                  timetable: timetable,
                  foodType: 1,
                  sizeW: 0.15,
                ),
                FoodItem(
                  timetable: timetable,
                  foodType: 2,
                  sizeW: 0.15,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
