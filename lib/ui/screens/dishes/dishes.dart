import 'package:bettymeals/cubit/timetable_cubit.dart';
import 'package:bettymeals/ui/screens/dishes/widgets/day_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/colours.dart';

class DishesScreen extends StatelessWidget {
  const DishesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Dishes',
          style: TextStyle(color: AppColour(context).onPrimaryColour),
        ),
        backgroundColor: AppColour(context).primaryColour,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<TimetableCubit, TimetableState>(
          builder: (context, state) {
            if (state is TimetableLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TimetableLoaded) {
              int l = state.timetable.length > 7 ? 6: state.timetable.length-1;
              return Column(
                children: [
                  for (int i = 1; i <= l; i++)
                    DayContainer(day: 'Day $i', food: state.timetable[i].foods),
                ],
              );
            } else {
              return const Center(
                child: Text('Failed to load meals.'),
              );
            }
          },
        ),
      ),
    );
  }
}
