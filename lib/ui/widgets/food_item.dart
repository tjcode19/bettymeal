import 'package:bettymeals/data/models/timetable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../utils/constants.dart';

class FoodItem extends StatelessWidget {
  const FoodItem(
      {super.key,
      required this.timetable,
      required this.foodType,
      this.sizeW = 1,
      required this.mealType});

  final TimetableModel timetable;
  final int foodType;
  final double sizeW;
  final String mealType;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: CommonUtils.sw(context, s: sizeW),
        child: Column(
          children: [
            Text(mealType),
            const Image(
              image: Svg('assets/icons/meal.svg'),
            ),
            Text(timetable.foods[foodType].name),
          ],
        ),
      ),
    );
  }
}
