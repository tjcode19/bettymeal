import 'package:bettymeals/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/colours.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/helper.dart';
import '../../../../utils/timer.dart';
import 'active_plan_card.dart';
import 'inactive_plan_card.dart';

class ExistingUserWidget extends StatefulWidget {
  const ExistingUserWidget({super.key});

  @override
  State<ExistingUserWidget> createState() => _ExistingUserWidgetState();
}

class _ExistingUserWidgetState extends State<ExistingUserWidget> {
  ScrollController _upScrollController = ScrollController();
  ScrollController _scrollController = ScrollController();
  int _selected = 0;
  bool justLaunch = true;


  void _scrollToCurrentDate(pos) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _upScrollController.animateTo(
        double.parse(
            pos.toString()), // Adjust the scroll position based on item width
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        bool isActiveSub = false;
        if (state is LoadDashboard) {
          isActiveSub = state.isActiveSub;
          final tVal = state.data.activeSub![0].timetable!;
          return Column(
            children: [
              if (isActiveSub) ActivePlanCard() else InactivePlanCard(),
              Column(
                children: [
                  CustomLayout.mPad.sizedBoxH,
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 50.0,
                      maxHeight: 80.0,
                    ),
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        top: 8, bottom: 8, left: CommonUtils.padding),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.data.activeSub![0].timetable!.length,
                      controller: _upScrollController,
                      itemBuilder: (context, index) {
                        final d = tVal.firstWhere((element) =>
                            HelperMethod.formatDate(element.meals![0].date) ==
                            HelperMethod.formatDate(
                                DateTime.now().toIso8601String()));

                        var pos = tVal.indexOf(d);
                        if (justLaunch) {
                          _selected = pos;
                          _scrollToCurrentDate(pos * 45);
                          justLaunch = false;
                        }
                        return GestureDetector(
                          onTap: () {
                            _scrollController.animateTo(0.0,
                                duration: const Duration(milliseconds: 800),
                                curve: Curves.bounceOut);
                            setState(() {
                              _selected = index;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: CommonUtils.mpadding),
                            margin:
                                EdgeInsets.only(right: CommonUtils.xspadding),
                            decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              color: (_selected != index)
                                  ? AppColour(context).onPrimaryColour
                                  : AppColour(context).primaryColour,
                              border: Border.all(
                                  width: 1.0,
                                  color: AppColour(context).primaryColour),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateWay(DateTime.parse(
                                          tVal[index].meals![0].date!))
                                      .tDay,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: (_selected != index)
                                              ? AppColour(context).primaryColour
                                              : AppColour(context)
                                                  .onPrimaryColour),
                                ),
                                Text(
                                  DateWay(DateTime.parse(
                                          tVal[index].meals![0].date!))
                                      .tDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: (_selected != index)
                                              ? AppColour(context).primaryColour
                                              : AppColour(context)
                                                  .onPrimaryColour,
                                          fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  DateWay(DateTime.parse(
                                          tVal[index].meals![0].date!))
                                      .tMon,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: (_selected != index)
                                              ? AppColour(context).primaryColour
                                              : AppColour(context)
                                                  .onPrimaryColour),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          );
        } else
          return Text('');
      },
    );
  }
}
