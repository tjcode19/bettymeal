// import 'package:bettymeals/data/api/models/GetUserDetails.dart';
import 'dart:developer';

import 'package:bettymeals/cubit/auth_cubit.dart';
import 'package:bettymeals/data/api/models/GetSubscription.dart';
import 'package:bettymeals/ui/screens/daily_menu/widgets/current_plan_card.dart';
import 'package:bettymeals/ui/screens/daily_menu/widgets/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/timetable_cubit.dart';
import '../../../../data/api/models/GetTimetable.dart';
import '../../../../data/api/models/GetUserDetails.dart';
import '../../../../routes.dart';
import '../../../../utils/colours.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/helper.dart';
import '../../../../utils/timer.dart';
import '../../../widgets/food_card.dart';
import '../../../widgets/section_title.dart';

class ExistingUserWidget extends StatefulWidget {
  const ExistingUserWidget(this.name, this.isActiveSub, this.activeSub,
      {super.key});

  final String name;
  final bool isActiveSub;
  final List<ActiveSub> activeSub;

  @override
  State<ExistingUserWidget> createState() => _ExistingUserWidgetState();
}

class _ExistingUserWidgetState extends State<ExistingUserWidget> {
  ScrollController _scrollController = ScrollController();
  int _selected = 0;
  bool justLaunch = true;
  final List<String> period = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];
  late List<Timetable> tVal;

  @override
  void initState() {
    tVal = widget.isActiveSub? widget.activeSub[0].timetable! : [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.name == "Guest") UpdateProfile(),
            CustomLayout.mPad.sizedBoxH,
            tVal.length>0?
            Container(
              constraints: const BoxConstraints(
                minHeight: 50.0,
                maxHeight: 80.0,
              ),
              color: Colors.white,
              padding:
                  EdgeInsets.only(top: 8, bottom: 8, left: CommonUtils.padding),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tVal.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // final d = tVal.firstWhere((element) =>
                      //     HelperMethod.formatDate(
                      //         element.meals![0].date) ==
                      //     HelperMethod.formatDate(
                      //         DateTime.now().toIso8601String()));
                      _scrollController.animateTo(0.8 * index,
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.bounceOut);
                      setState(() {
                        _selected = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: CommonUtils.mpadding),
                      margin: EdgeInsets.only(right: CommonUtils.xspadding),
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
                            DateWay(DateTime.parse(tVal[index].meals![0].date!))
                                .tDay,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: (_selected != index)
                                        ? AppColour(context).primaryColour
                                        : AppColour(context).onPrimaryColour),
                          ),
                          Text(
                            DateWay(DateTime.parse(tVal[index].meals![0].date!))
                                .tDate,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: (_selected != index)
                                        ? AppColour(context).primaryColour
                                        : AppColour(context).onPrimaryColour,
                                    fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateWay(DateTime.parse(tVal[index].meals![0].date!))
                                .tMon,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: (_selected != index)
                                        ? AppColour(context).primaryColour
                                        : AppColour(context).onPrimaryColour),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              
            ):CurrentPlanCard(),
            CommonUtils.spaceH,
            //The card listview implemetation starts here
            if (widget.isActiveSub)

              // List<Timetable> tVal = widget.subInfo.timetable!;
              //  tVal.isNotEmpty
              //     ?
              SizedBox(
                height: CommonUtils.sh(context, s: 0.35),
                width: CommonUtils.sw(context, s: 1),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: tVal[_selected].meals!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    List<Meals> t = tVal[_selected].meals!;
                    return SizedBox(
                      width: CommonUtils.sw(context, s: .6),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: FoodCard(
                          food: t[index],
                          period: period[index],
                        ),
                      ),
                    );
                  },
                ),
              ),

            //The card listview implemetation ends here
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonUtils.spaceH,
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.profileScreen),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: CommonUtils.padding),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: CommonUtils.padding, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColour(context)
                                .primaryColour
                                .withOpacity(0.5)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Row(children: [
                        Icon(Icons.tips_and_updates_outlined),
                        CustomLayout.lPad.sizedBoxW,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quick Suggestion',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'Tap to see meal suggestions for lunch',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
                CustomLayout.mPad.sizedBoxH,
                Container(
                  // height: CommonUtils.sh(context, s: 0.3),
                  width: CommonUtils.sw(context),
                  padding: EdgeInsets.all(CommonUtils.padding),
                  margin: EdgeInsets.symmetric(horizontal: CommonUtils.padding),
                  decoration: BoxDecoration(
                    color: AppColour(context).onPrimaryColour,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),

                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0.0),
                    title: Row(children: [
                      Icon(Icons.tips_and_updates),
                      CustomLayout.mPad.sizedBoxW,
                      const Text('Tips')
                    ]),
                    subtitle: Text(
                        'Experts recommend that males consume 15.5 cups (3.7 liters) of water daily and females 11.5 cups (2.7 liters).'),
                  ),
                ),
                const SectionTitle(text: 'Popular meals'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
