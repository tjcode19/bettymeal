import 'package:bettymeals/ui/screens/daily_menu/widgets/inactive_plan_card.dart';
import 'package:bettymeals/ui/screens/daily_menu/widgets/update_profile.dart';
import 'package:flutter/material.dart';
import '../../../../data/api/models/GetTimetable.dart';
import '../../../../data/api/models/GetUserDetails.dart';
import '../../../../utils/colours.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/helper.dart';
import '../../../../utils/timer.dart';
import '../../../widgets/food_card.dart';
import 'active_plan_card.dart';

class ExistingUserWidget extends StatefulWidget {
  const ExistingUserWidget(this.name, this.isActiveSub, this.activeSub,
      this.shuffle, this.regenerate,
      {super.key});

  final String name;
  final bool isActiveSub;
  final List<ActiveSub>? activeSub;
  final int shuffle;
  final int regenerate;

  @override
  State<ExistingUserWidget> createState() => _ExistingUserWidgetState();
}

class _ExistingUserWidgetState extends State<ExistingUserWidget> {
  ScrollController _scrollController = ScrollController();
  ScrollController _upScrollController = ScrollController();
  int _selected = 0;
  bool justLaunch = true;
  final List<String> period = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];
  late List<Timetable> tVal;

  void _scrollToCurrentDate(pos) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _upScrollController.animateTo(
        double.parse(pos.toString()), // Adjust the scroll position based on item width
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    tVal = widget.isActiveSub ? widget.activeSub![0].timetable! : [];
    super.initState();
    _upScrollController.addListener(()=>_scrollToCurrentDate);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.name == "Guest") UpdateProfile(),

            tVal.length > 0
                ? Column(
                    children: [
                      CustomLayout.mPad.sizedBoxH,
                      ActivePlanCard(widget.activeSub![0], widget.shuffle,
                          widget.regenerate),
                      CustomLayout.lPad.sizedBoxH,
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
                          itemCount: tVal.length,
                          controller: _upScrollController,
                          itemBuilder: (context, index) {
                            final d = tVal.firstWhere((element) =>
                                HelperMethod.formatDate(
                                    element.meals![0].date) ==
                                HelperMethod.formatDate(
                                    DateTime.now().toIso8601String()));

                            // WidgetsBinding.instance.addPostFrameCallback((_) {
                            // _upScrollController.animateTo(
                            //   index *
                            //       50.0, // Adjust the scroll position based on item width
                            //   duration: const Duration(milliseconds: 500),
                            //   curve: Curves.easeInOut,
                            // );
                            // });

                            

                            var pos = tVal.indexOf(d);
                            _scrollToCurrentDate(pos * 40);
                            if (justLaunch) {
                              _selected = pos;
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
                                margin: EdgeInsets.only(
                                    right: CommonUtils.xspadding),
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
                                                  ? AppColour(context)
                                                      .primaryColour
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
                                                  ? AppColour(context)
                                                      .primaryColour
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
                                                  ? AppColour(context)
                                                      .primaryColour
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
                : InactivePlanCard(),
            CustomLayout.lPad.sizedBoxH,
            //The card listview implemetation starts here
            if (widget.isActiveSub)
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
                      width: CommonUtils.sw(context, s: 0.6),
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
                CustomLayout.mPad.sizedBoxH,
                // GestureDetector(
                //   onTap: () =>
                //       Navigator.pushNamed(context, Routes.profileScreen),
                //   child: Padding(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: CommonUtils.padding),
                //     child: Container(
                //       padding: EdgeInsets.symmetric(
                //           horizontal: CommonUtils.padding, vertical: 6),
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //             color: AppColour(context)
                //                 .primaryColour
                //                 .withOpacity(0.5)),
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(10),
                //         ),
                //       ),
                //       child: Row(children: [
                //         Icon(Icons.tips_and_updates_outlined),
                //         CustomLayout.lPad.sizedBoxW,
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               'Quick Suggestion',
                //               style: Theme.of(context).textTheme.titleMedium,
                //             ),
                //             Text(
                //               'Tap to see meal suggestions for lunch',
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .bodyMedium!
                //                   .copyWith(
                //                     color: Colors.black.withOpacity(0.6),
                //                   ),
                //             ),
                //           ],
                //         )
                //       ]),
                //     ),
                //   ),
                // ),
                // CustomLayout.mPad.sizedBoxH,
                Container(
                  width: CommonUtils.sw(context),
                  margin: EdgeInsets.symmetric(horizontal: CommonUtils.padding),
                  decoration: BoxDecoration(
                    color: AppColour(context).onPrimaryColour,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: -50,
                        child: Transform.rotate(
                          angle: -30 * 0.0174533,
                          child: Icon(
                            Icons.tips_and_updates_outlined,
                            color: AppColour(context)
                                .secondaryColour
                                .withOpacity(0.1),
                            size: 150,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(CommonUtils.padding),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0.0),
                          dense: false,
                          title: Row(children: [
                            // Icon(Icons.tips_and_updates,
                            //     color: AppColour(context).secondaryColour),
                            SizedBox(
                                height: 20,
                                width: 4,
                                child: VerticalDivider(
                                  color: AppColour(context).secondaryColour,
                                  thickness: 4,
                                )),
                            CustomLayout.mPad.sizedBoxW,
                            Text(
                              'Today\'s tip',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColour(context)
                                        .secondaryColour
                                        .withOpacity(0.7),
                                  ),
                            )
                          ]),
                          subtitle: Column(
                            children: [
                              CustomLayout.mPad.sizedBoxH,
                              Text(
                                'Experts recommend that males consume 15.5 cups (3.7 liters) of water daily and females 11.5 cups (2.7 liters).',
                                textAlign: TextAlign.justify,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: AppColour(context).secondaryColour,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomLayout.xxlPad.sizedBoxH,
                // const SectionTitle(text: 'Popular meals'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
