import 'dart:developer';

import 'package:bettymeals/cubit/dashboard_cubit.dart';
import 'package:bettymeals/cubit/store_cubit.dart';
import 'package:bettymeals/cubit/timetable_cubit.dart';
import 'package:bettymeals/routes.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:bettymeals/utils/noti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/api/models/GetTimetable.dart';
import '../../../utils/colours.dart';
import '../../../utils/enums.dart';
import '../../widgets/time_table.dart';

class MealTableScreen extends StatefulWidget {
  const MealTableScreen({super.key});

  @override
  State<MealTableScreen> createState() => _MealTableScreenState();
}

class _MealTableScreenState extends State<MealTableScreen> {
  String tableId = "";

  List<ScrollController> scrollControllers = [];

  final PageController pageController = PageController();

  List<List<Timetable>> meal = [];

  int shuffle = 0;
  int regenerate = 0;
  int weeks = 0;
  bool firstTime = true;
  bool fLoad = true;
  // bool isEnd = false;
  bool isShuffleBtnClicked = false;
  bool isRegenerateBtnClicked = false;
  // bool _showRightButton = true, _showLeftButton = false;
  int selectedWeekIndex = 0;

  double currentPos = 0.1;
  late double maxPoint;
  DateTime todayDate = DateTime.now();

  // void animateNow(pos) {
  //   setState(() {
  //     if (isEnd) {
  //       if (pos < currentPos) {
  //         isEnd = false;
  //         currentPos = pos;
  //       }
  //     } else {
  //       if (pos < 50) {
  //         currentPos = 0.0;
  //       } else {
  //         currentPos = pos;
  //       }
  //     }
  //   });

  //   scrollControllers[selectedWeekIndex].animateTo(currentPos,
  //       duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
  // }

  // _scrollListener() {
  //   setState(() {
  //     _showLeftButton = true;
  //     _showRightButton = true;
  //   });
  //   if (scrollControllers[selectedWeekIndex].offset >=
  //           scrollControllers[selectedWeekIndex].position.maxScrollExtent &&
  //       !scrollControllers[selectedWeekIndex].position.outOfRange) {
  //     setState(() {
  //       isEnd = true;
  //       _showRightButton = false;
  //       currentPos =
  //           scrollControllers[selectedWeekIndex].position.maxScrollExtent;
  //     });
  //   }
  //   if (scrollControllers[selectedWeekIndex].offset <=
  //           scrollControllers[selectedWeekIndex].position.minScrollExtent &&
  //       !scrollControllers[selectedWeekIndex].position.outOfRange) {
  //     setState(() {
  //       _showLeftButton = false;
  //     });
  //   }
  // }

  currentWeek() {
    int i = 0;

    while (i < meal.length) {
      final v = meal[i].map((element) {
        return HelperMethod.formatDate(
                DateTime.parse(element.meals!.first.date!).toIso8601String()) ==
            HelperMethod.formatDate(todayDate.toIso8601String());
      });

      if (v.contains(true)) {
        selectedWeekIndex = i;

        log("here:" + selectedWeekIndex.toString());
      }

      i++;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.animateToPage(
        selectedWeekIndex,
        duration: Duration(milliseconds: 900),
        curve: Curves.easeInOut,
      );
    });
    fLoad = false;
  }

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
                Icons.local_grocery_store,
                color: AppColour(context).primaryColour.withOpacity(0.8),
              ),
              tooltip: 'My Store',
              onPressed: () {
                // handle the press
                // Notificatn.showInfoModal(context, msg: "Available in Pro Plan");

                if (firstTime) {
                  context.read<StoreCubit>().getStoreItems();

                  setState(() {
                    firstTime = false;
                  });
                }

                Navigator.pushNamed(context, Routes.storeScreen, arguments: "");
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
              // padding: EdgeInsets.all(CommonUtils.padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocConsumer<TimetableCubit, TimetableState>(
                    listenWhen: (previous, current) {
                      if (current is TimetableError) {
                        return true;
                      }
                      return previous != current;
                    },
                    listener: (context, state) {
                      if (state is GetTableSuccess) {
                        isRegenerateBtnClicked = false;
                        isShuffleBtnClicked = false;
                        context.read<DashboardCubit>().prepareDashboard();
                      }
                      if (state is TimetableError) {
                        isRegenerateBtnClicked = false;
                        isShuffleBtnClicked = false;
                        Notificatn.showErrorToast(context,
                            errorMsg: state.errorMessage);
                      }
                    },
                    builder: (context, state) {
                      if (state is GetTableSuccess) {
                        tableId = state.data[0].sId.toString();
                        meal = state.dataWeekly;
                        shuffle = state.data[0].subData!.shuffle!;
                        regenerate = state.data[0].subData!.regenerate!;

                        weeks = meal.length;

                        if (fLoad) currentWeek();

                        // for (int i = 0; i < weeks; i++) {
                        //   ScrollController scrollController =
                        //       ScrollController();
                        //   scrollControllers.add(scrollController);
                        // }
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
                      }

                      // else {
                      //   return Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Icon(Icons.notification_important),
                      //       const Center(
                      //         child: Text('Failed to load meals.'),
                      //       ),
                      //     ],
                      //   );
                      // }

                      return Column(
                        children: [
                          Container(
                            width: CommonUtils.sw(context),
                            margin: EdgeInsets.symmetric(
                                horizontal: CommonUtils.padding,
                                vertical: CommonUtils.spadding),
                            decoration: BoxDecoration(
                              color: AppColour(context).onPrimaryColour,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: -10,
                                  right: -2,
                                  child: Transform.rotate(
                                    angle: -20 * 0.0174533,
                                    child: Icon(
                                      Icons.info_outline,
                                      color: AppColour(context)
                                          .secondaryColour
                                          .withOpacity(0.2),
                                      size: 80,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(CommonUtils.spadding),
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.black87),
                                      text: '* ',
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
                                ),
                              ],
                            ),
                          ),
                          CustomLayout.sPad.sizedBoxH,
                          Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(
                              minHeight: 50.0,
                              maxHeight: 80.0,
                            ),
                            color: AppColour(context)
                                .primaryColour
                                .withOpacity(0.1),
                            padding: EdgeInsets.only(
                                top: 8, bottom: 8, left: CommonUtils.padding),
                            child: Center(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: weeks,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedWeekIndex = index;
                                      });
                                      pageController.animateToPage(
                                        selectedWeekIndex,
                                        duration: Duration(milliseconds: 900),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: CommonUtils.spadding),
                                      margin: EdgeInsets.only(
                                          right: CommonUtils.xspadding),
                                      decoration: BoxDecoration(
                                        // shape: BoxShape.circle,
                                        color: (selectedWeekIndex != index)
                                            ? AppColour(context).onPrimaryColour
                                            : AppColour(context).primaryColour,
                                        border: Border.all(
                                            width: 1.0,
                                            color: AppColour(context)
                                                .primaryColour),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Week ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: (selectedWeekIndex !=
                                                            index)
                                                        ? AppColour(context)
                                                            .primaryColour
                                                        : AppColour(context)
                                                            .onPrimaryColour),
                                          ),
                                          Text(
                                            '${index + 1}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: (selectedWeekIndex !=
                                                            index)
                                                        ? AppColour(context)
                                                            .primaryColour
                                                        : AppColour(context)
                                                            .onPrimaryColour,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          // CustomLayout.lPad.sizedBoxH,
                          // Row(
                          //   mainAxisAlignment:
                          //       MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Visibility(
                          //       visible: _showLeftButton,
                          //       child: InkWell(
                          //         onTap: () {
                          //           var pos = currentPos - 70;
                          //           animateNow(pos);
                          //         },
                          //         child: Icon(
                          //           Icons.arrow_circle_left_outlined,
                          //           size: 30,
                          //         ),
                          //       ),
                          //     ),
                          //     Text('Scroll right or left'),
                          //     Visibility(
                          //       visible: _showRightButton,
                          //       child: InkWell(
                          //         onTap: () {
                          //           var pos = currentPos + 70;
                          //           animateNow(pos);
                          //         },
                          //         child: Icon(
                          //           Icons.arrow_circle_right_outlined,
                          //           size: 30,
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // ),

                          CustomLayout.mPad.sizedBoxH,
                          if (meal.length > 0)
                            SizedBox(
                              height: CommonUtils.sh(context, s: 0.5),
                              child: PageView(
                                  controller: pageController,
                                  onPageChanged: (index) {
                                    setState(() {
                                      selectedWeekIndex = index;
                                    });
                                  },
                                  children: [
                                    for (final element in meal)
                                      TimeTable(
                                        key: ValueKey(
                                            "time_table ${meal.indexOf(element)}"),
                                        meals: element,
                                      ),
                                  ]),
                            ),
                          Padding(
                            padding: EdgeInsets.all(CommonUtils.padding),
                            child: Column(
                              children: [
                                CustomLayout.mPad.sizedBoxH,
                                Row(
                                  children: [
                                    // Expanded(
                                    //   child: OutlinedButton(
                                    //     onPressed: !isShuffleBtnClicked &&
                                    //             shuffle > 0
                                    //         ? () {
                                    //             setState(() {
                                    //               isShuffleBtnClicked = true;
                                    //             });
                                    //             context
                                    //                 .read<TimetableCubit>()
                                    //                 .shuffleTimeableApi(
                                    //                     tableId);
                                    //           }
                                    //         : null,
                                    //     style: OutlinedButton.styleFrom(
                                    //       side: BorderSide(
                                    //           color: AppColour(context)
                                    //               .primaryColour),
                                    //     ),
                                    //     child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.center,
                                    //       children: [
                                    //         const Text('Shuffle'),
                                    //         Container(
                                    //           margin: EdgeInsets.all(6),
                                    //           padding: EdgeInsets.all(6),
                                    //           decoration: BoxDecoration(
                                    //             shape: BoxShape.circle,
                                    //             color: AppColour(context)
                                    //                 .primaryColour,
                                    //           ),
                                    //           child: isShuffleBtnClicked
                                    //               ? SizedBox(
                                    //                   width: 10,
                                    //                   height: 10,
                                    //                   child:
                                    //                       CircularProgressIndicator(
                                    //                     strokeWidth: 2,
                                    //                     color: AppColour(
                                    //                             context)
                                    //                         .onPrimaryColour,
                                    //                   ),
                                    //                 )
                                    //               : Text(
                                    //                   shuffle.toString(),
                                    //                   style: TextStyle(
                                    //                       color: AppColour(
                                    //                               context)
                                    //                           .onPrimaryColour),
                                    //                 ),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    // CustomLayout.lPad.sizedBoxW,
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: !isRegenerateBtnClicked &&
                                                regenerate > 0
                                            ? () {
                                                setState(() {
                                                  isRegenerateBtnClicked = true;
                                                });
                                                context
                                                    .read<TimetableCubit>()
                                                    .regenrateTimeableApi(
                                                        tableId);
                                              }
                                            : null,
                                        style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                                color: AppColour(context)
                                                    .primaryColour),
                                            disabledBackgroundColor:
                                                AppColour(context)
                                                    .primaryColour
                                                    .withOpacity(0.5)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text('Regenerate'),
                                            Container(
                                              margin: EdgeInsets.all(6),
                                              padding: EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColour(context)
                                                    .onPrimaryColour,
                                              ),
                                              child: isRegenerateBtnClicked
                                                  ? SizedBox(
                                                      width: 10,
                                                      height: 10,
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                      ),
                                                    )
                                                  : Text(
                                                      regenerate.toString(),
                                                      style: TextStyle(
                                                          color: AppColour(
                                                                  context)
                                                              .primaryColour),
                                                    ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
