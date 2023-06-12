import 'package:bettymeals/cubit/timetable_cubit.dart';
import 'package:bettymeals/data/api/models/GetTimetable.dart';
import 'package:bettymeals/ui/screens/records/widgets/day_container.dart';
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
          'Plan History',
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
            } else if (state is GetTableSuccess) {
              List<GetTimetableData> l = state.data;
              return l.length > 0
                  ? Column(
                      children: [
                        for (int i = 0; i < l.length; i++)
                          Text(l[i].sub?.name! ?? 'NA'),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('No Plan Records Found'),
                      ],
                    );
            } else {
              return const Center(
                child: Text('Failed to load Plan History.'),
              );
            }
          },
        ),
      ),
    );
  }
}
