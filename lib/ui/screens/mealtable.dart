import 'dart:math';

import 'package:bettymeals/cubit/timetable_cubit.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/colours.dart';
import '../../utils/enums.dart';
import '../widgets/time_table.dart';

class MealTableScreen extends StatefulWidget {
  const MealTableScreen({super.key});

  @override
  State<MealTableScreen> createState() => _MealTableScreenState();
}

class _MealTableScreenState extends State<MealTableScreen> {
  String tableId = "";
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
            'Meal Table',
            style: TextStyle(color: AppColour(context).onPrimaryColour),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.store, color: AppColour(context).onPrimaryColour,),
              tooltip: 'My Store',
              onPressed: () {
                // handle the press
              },
            ),
          ],
          backgroundColor: AppColour(context).primaryColour,
        ),
        body: RefreshIndicator(
          onRefresh: () => context.read<TimetableCubit>().getTimeableApi(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(CommonUtils.padding),
              child: Column(
                children: [
                  CustomLayout.lPad.sizedBoxW,
                  BlocBuilder<TimetableCubit, TimetableState>(
                    builder: (context, state) {
                      if (state is TimetableLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetTableSuccess) {
                        tableId = state.data[0].sId.toString();
                        return TimeTable(
                          key: const ValueKey("time_table"),
                          meals: state.data[0],
                        );
                      } else if (state is NoSubSuccess) {
                        return Center(
                          child: Text(state.msg),
                        );
                      } else {
                        return const Center(
                          child: Text('Failed to load meals.'),
                        );
                      }
                    },
                  ),
                  CustomLayout.xlPad.sizedBoxH,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline),
                      CustomLayout.mPad.sizedBoxW,
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.black87),
                            text:
                                'If you are not satisfied with the table, you can  ',
                            children: [
                              TextSpan(
                                text: 'Shuffle. ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color:
                                            AppColour(context).secondaryColour),
                              ),
                              TextSpan(
                                text: 'And for more robust table, add more ',
                              ),
                              TextSpan(
                                text: 'foods ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color:
                                            AppColour(context).secondaryColour),
                              ),
                              TextSpan(
                                text: 'to your list.',
                              ),
                            ],
                          ),
                        ),
                        // Text(
                        //   'Select the meal type(s) for this food. You can select multiple if application. ' +
                        //       'If the food can be taken as Breakfast and Lunch, kindly select both',
                        //   textAlign: TextAlign.justify,
                        // ),
                      )
                    ],
                  ),
                  CustomLayout.mPad.sizedBoxH,
                  OutlinedButton(
                      onPressed: () {
                        print("get: $tableId");
                        context
                            .read<TimetableCubit>()
                            .shuffleTimeableApi(tableId);
                      },
                      style: OutlinedButton.styleFrom(
                        side:
                            BorderSide(color: AppColour(context).primaryColour),
                      ),
                      child: const Text('Shuffle MealTable'))
                ],
              ),
            ),
          ),
        ));
  }
}
