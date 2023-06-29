import 'package:bettymeals/data/api/models/GetTimetable.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class TimeTable extends StatelessWidget {
  const TimeTable(this.scrollController, {required this.meals, super.key});

  final GetTimetableData meals;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: scrollController,
      child: Table(
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
          1: IntrinsicColumnWidth(),
          2: IntrinsicColumnWidth(),
          3: IntrinsicColumnWidth(),
          4: IntrinsicColumnWidth(),
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
              Container(
                height: 32,
                child: Center(child: const Text('Fruits')),
              ),
            ],
          ),
          for (Timetable d in meals.timetable!)
            _tableRow(context,
                day: d.day,
                b: d.meals![0].meal,
                l: d.meals![1].meal,
                d: d.meals![2].meal,
                f: d.meals![2].meal)
        ],
      ),
    );
  }

  _tableRow(context, {day, b, l, d, f}) => TableRow(
        children: <Widget>[
          Container(
            height: 54,
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: Text(day),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, Routes.mealDetails, arguments: b),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                b.name,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColour(context).secondaryColour),
              )),
            ),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, Routes.mealDetails, arguments: l),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                l.name,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColour(context).secondaryColour),
              )),
            ),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, Routes.mealDetails, arguments: d),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                d.name,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColour(context).secondaryColour),
              )),
            ),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, Routes.mealDetails, arguments: f),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                '${f.name}',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColour(context).secondaryColour),
              )),
            ),
          ),
        ],
      );
}
