import 'dart:math';

import 'package:bettymeals/cubit/timetable_cubit.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/food_data.dart';
import '../../utils/colours.dart';
import '../../utils/enums.dart';
import '../widgets/time_table.dart';

class MealTableScreen extends StatefulWidget {
  const MealTableScreen({super.key});

  @override
  State<MealTableScreen> createState() => _MealTableScreenState();
}

class _MealTableScreenState extends State<MealTableScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
              BlocBuilder<TimetableCubit, TimetableState>(
                builder: (context, state) {
                  if (state is TimetableLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TimetableLoaded) {
                    return TimeTable(
                      key: const ValueKey("time_table"),
                      meals: state.timetable,
                    );
                  } else {
                    return const Center(
                      child: Text('Failed to load meals.'),
                    );
                  }
                },
              ),
              CustomLayout.xlPad.sizedBoxH,
              OutlinedButton(
                  onPressed: () {
                    BlocProvider.of<TimetableCubit>(context)
                        .rescheduleMealTable();
                  },
                  child: const Text('Shuffle MealTable'))
            ],
          ),
        ));
  }
}
