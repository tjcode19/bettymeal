import 'dart:math';

import 'package:bettymeals/data/api/models/GetTimetable.dart';
import 'package:bettymeals/data/local/models/timetable.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/local/models/food_data.dart';

class TimeTable extends StatelessWidget {
  const TimeTable({required this.meals, super.key});

  final GetTimetableData meals;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        color: Theme.of(context).primaryColor.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
          children: <Widget>[
            Container(
              height: 32,
              child: Center(child: const Text('Day')),
            ),
            Container(
              child: Center(child: const Text('Breakfast')),
            ),
            Container(
              child: Center(
                child: const Text('Lunch'),
              ),
            ),
            Container(
              height: 32,
              child: Center(child: const Text('Dinner')),
            ),
          ],
        ),
        for (Timetable d in meals.timetable!)
          _tableRow(context,
              day: d.day,
              b: d.meals![0].meal?.name,
              l: d.meals![1].meal?.name,
              d: d.meals![2].meal?.name)
      ],
    );
  }

  _tableRow(context, {day, b, l, d}) => TableRow(
        children: <Widget>[
          Container(
            height: 54,
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: Text(day),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              b,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColour(context).secondaryColour),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              l,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColour(context).secondaryColour),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              d,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColour(context).secondaryColour),
            )),
          ),
        ],
      );
}
