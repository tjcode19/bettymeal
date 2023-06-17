import 'package:bettymeals/cubit/timetable_cubit.dart';
import 'package:bettymeals/data/api/models/GetTimetable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/colours.dart';
import '../../../utils/enums.dart';
import '../daily_menu/widgets/plan_card.dart';

class RecordsScreen extends StatelessWidget {
  const RecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Records',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColour(context).primaryColour.withOpacity(0.7),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColour(context).background,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<TimetableCubit, TimetableState>(
          builder: (context, state) {
            if (state is TimetableLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetTableSuccess) {
              List<GetTimetableData> l = state.allData;
              return l.length > 0
                  ? Column(
                      children: [
                        CustomLayout.lPad.sizedBoxH,
                        for (int i = 0; i < l.length; i++)
                          PlanCard(
                            plan: l[i].sub!,
                            showBadge: DateTime.parse(l[i].endDate!)
                                .isAfter(DateTime.now()),
                            background: DateTime.parse(l[i].endDate!)
                                    .isBefore(DateTime.now())
                                ? AppColour(context)
                                    .secondaryColour
                                    .withOpacity(0.1)
                                : Colors.blue.withOpacity(0.1),
                            onPress: () {},
                          ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('No Plan Records Found'),
                      ],
                    );
            } else {
              return Column(
                children: [
                  CustomLayout.xxlPad.sizedBoxH,
                  Icon(
                    Icons.notification_important,
                    size: 50,
                  ),
                  Center(
                    child: Text('No Record Found'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
