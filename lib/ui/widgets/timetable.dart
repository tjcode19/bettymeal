import 'package:flutter/material.dart';

import '../../data/models/food.dart';
import '../../data/models/timetable.dart';

class TimetableItemWidget extends StatelessWidget {
  final Timetable timetable;

  TimetableItemWidget({required this.timetable});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Meal for ${timetable.date}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (Food food in timetable.foods) ...[
            Text(food.name),
            SizedBox(height: 4),
          ],
        ],
      ),
    );
  }
}
