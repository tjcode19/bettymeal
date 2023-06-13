import 'package:bettymeals/data/api/models/GetTimetable.dart';
import 'package:flutter/material.dart';

import '../../data/api/models/MealResponse.dart';
import '../../routes.dart';
import '../../utils/colours.dart';
import '../../utils/constants.dart';

class FoodCardFooter extends StatelessWidget {
  const FoodCardFooter({super.key, required this.meal, this.extra});

  final MealData meal;
  final List<String>? extra;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                meal.name!,
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColour(context).onBackground),
              ),
              ...?extra?.map((e) => itemRow(context, name: e)),
              // itemRow(context, name: 'Koko'),
              // itemRow(context, name: 'Kose/Bofloat/Kose bread'),
              // itemRow(context, name: 'Bread'),
            ],
          ),
        ),
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, Routes.mealDetails, arguments: meal),
          child: const CircleAvatar(
            child: Icon(Icons.arrow_forward),
          ),
        )
      ],
    );
  }

  Widget itemRow(context, {required String name, TextStyle? style}) {
    return Row(
      children: [
        const Icon(Icons.check_circle),
        CommonUtils.spaceW,
        Text(
          name,
          style: style ??
              Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColour(context).onBackground),
        )
      ],
    );
  }
}
