import 'package:flutter/material.dart';

import '../../data/local/models/food.dart';
import '../../data/local/models/timetable.dart';

class TimetableItemWidget extends StatelessWidget {
  final TimetableModel timetable;

  TimetableItemWidget({required this.timetable});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Meal for ${timetable.date}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (FoodModel food in timetable.foods) ...[
            Text(food.name),
            SizedBox(height: 4),
          ],
        ],
      ),
    );
  }
}
