import 'package:bettymeals/cubit/timetable_cubit.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/noti.dart';
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
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColour(context).primaryColour.withOpacity(0.7),
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.store,
                color: AppColour(context).primaryColour.withOpacity(0.6),
              ),
              tooltip: 'My Store',
              onPressed: () {
                // handle the press
                Notificatn.showInfoModal(context, msg: "Available in Pro Plan");
              },
            ),
          ],
          backgroundColor: AppColour(context).background,
        ),
        body: RefreshIndicator(
          onRefresh: () => context.read<TimetableCubit>().getTimeableApi(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(CommonUtils.padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<TimetableCubit, TimetableState>(
                    builder: (context, state) {
                      if (state is TimetableLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetTableSuccess) {
                        tableId = state.data[0].sId.toString();
                        return Column(
                          children: [
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
                                      text: '',
                                      children: [
                                        TextSpan(
                                          text: 'Tap ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  color: AppColour(context)
                                                      .secondaryColour),
                                        ),
                                        TextSpan(
                                          text:
                                              'on any meal to see more details ',
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            CustomLayout.xlPad.sizedBoxH,
                            TimeTable(
                              key: const ValueKey("time_table"),
                              meals: state.data[0],
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
                                                  color: AppColour(context)
                                                      .secondaryColour),
                                        ),
                                        TextSpan(
                                          text:
                                              'And for more robust table, add more ',
                                        ),
                                        TextSpan(
                                          text: 'foods ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  color: AppColour(context)
                                                      .secondaryColour),
                                        ),
                                        TextSpan(
                                          text: 'to your list.',
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            CustomLayout.mPad.sizedBoxH,
                            OutlinedButton(
                              onPressed: () {
                                context
                                    .read<TimetableCubit>()
                                    .shuffleTimeableApi(tableId);
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: AppColour(context).primaryColour),
                              ),
                              child: const Text('Shuffle MealTable'),
                            )
                          ],
                        );
                      } else if (state is NoSubSuccess) {
                        return Column(
                          children: [
                            CustomLayout.xxlPad.sizedBoxH,
                            Icon(
                              Icons.notification_important,
                              size: 50,
                            ),
                            Center(
                              child: Text(state.msg),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.notification_important),
                            const Center(
                              child: Text('Failed to load meals.'),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
