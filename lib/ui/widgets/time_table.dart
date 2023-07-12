import 'package:bettymeals/data/api/models/GetTimetable.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class TimeTable extends StatelessWidget {
  const TimeTable({required this.meals, super.key});

  final List<Timetable> meals;
  // final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      // controller: scrollController,
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
          for (Timetable d in meals)
            _tableRow(context,
                day: d.meals![0].date,
                b: d.meals![0].meal,
                l: d.meals![1].meal,
                d: d.meals![2].meal,
                f: d.meals!.length > 3 ? d.meals![3].meal : null)
        ],
      ),
    );
  }

  _tableRow(context, {day, b, l, d, f}) {
    final breakFast = DateTime(2000, 1, 1, 7, 0, 0);
    final lunch = DateTime(2000, 1, 1, 13, 0, 0);
    final dinner = DateTime(2000, 1, 1, 17, 0, 0);

    var period = DateTime.now();
    int current = 0;
    if (period.hour > breakFast.hour && period.hour < lunch.hour) {
      current = 0;
    } else if (period.hour > lunch.hour && period.hour < dinner.hour) {
      current = 1;
    } else if (period.hour > dinner.hour) {
      current = 2;
    }

    final style = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: AppColour(context).onSecondaryColour);

    final currentStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: AppColour(context).primaryColour, fontWeight: FontWeight.bold);

    return TableRow(
      children: <Widget>[
        Container(
            // height: double.maxFinite,
            // color: Theme.of(context).primaryColor.withOpacity(0.2),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: HelperMethod.formatDate(day, pattern: 'EEE'),
                children: [
                  TextSpan(text: '\n'),
                  TextSpan(
                    text: HelperMethod.formatDate(day, pattern: 'dd-MM'),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColour(context)
                            .onSecondaryColour
                            .withOpacity(0.6),
                        fontSize: 12),
                  )
                ],
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColour(context).onSecondaryColour,
                    fontWeight: FontWeight.bold),
              ),
            )
            // Text(HelperMethod.formatDate(day)),
            ),
        if (b != null)
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, Routes.mealDetails, arguments: b),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                b.name,
                textAlign: TextAlign.center,
                style: current == 0 ? currentStyle : style,
              )),
            ),
          )
        else
          Text('NA'),
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, Routes.mealDetails, arguments: l),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              l.name,
              textAlign: TextAlign.center,
              style: current == 1 ? currentStyle : style,
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
              style: current == 2 ? currentStyle : style,
            )),
          ),
        ),
        if (f != null)
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, Routes.mealDetails, arguments: f),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                '${f.name}',
                textAlign: TextAlign.center,
                style: style,
              )),
            ),
          )
        else
          Text('NA')
      ],
    );
  }
}
