import 'package:bettymeals/cubit/dashboard_cubit.dart';
import 'package:bettymeals/cubit/store_cubit.dart';
import 'package:bettymeals/cubit/timetable_cubit.dart';
import 'package:bettymeals/routes.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  ScrollController _scrollController = ScrollController();

  int shuffle = 0;
  bool firstTime = true;
  bool isEnd = false;
  bool _showRightButton = true, _showLeftButton = false;

  double currentPos = 0.1;
  late double maxPoint;

  void animateNow(pos) {
    print('The $pos');
    setState(() {
      if (isEnd) {
        if (pos < currentPos) {
          isEnd = false;
          currentPos = pos;
        }
      } else {
        if (pos < 50) {
          currentPos = 0.0;
        } else {
          currentPos = pos;
        }
      }
    });

    _scrollController.animateTo(currentPos,
        duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
  }

  _scrollListener() {
    setState(() {
      _showLeftButton = true;
      _showRightButton = true;
    });
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        debugPrint("reach the end");
        isEnd = true;
        _showRightButton = false;
        currentPos = _scrollController.position.maxScrollExtent;
      });
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        debugPrint("reach the start");
        _showLeftButton = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
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
                            BlocBuilder<DashboardCubit, DashboardState>(
                                builder: (context, state) {
                              if (state is LoadDashboard) {
                                // setState(() {
                                shuffle = state.shuffle;
                                // });
                              }

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('You have '),
                                  CircleAvatar(
                                    child: Text(shuffle.toString()),
                                  ),
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
                                            text: 'Shuffle ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: AppColour(context)
                                                        .primaryColour),
                                          ),
                                          TextSpan(
                                            text: 'credit left',
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                            CustomLayout.lPad.sizedBoxH,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Visibility(
                                  visible: _showLeftButton,
                                  child: InkWell(
                                    onTap: () {
                                      var pos = currentPos - 70;
                                      animateNow(pos);
                                    },
                                    child: Icon(
                                      Icons.arrow_circle_left_outlined,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                Text('Scroll right or left'),
                                Visibility(
                                  visible: _showRightButton,
                                  child: InkWell(
                                    onTap: () {
                                      var pos = currentPos + 70;
                                      animateNow(pos);
                                    },
                                    child: Icon(
                                      Icons.arrow_circle_right_outlined,
                                      size: 30,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            CustomLayout.mPad.sizedBoxH,
                            TimeTable(
                              _scrollController,
                              key: const ValueKey("time_table"),
                              meals: state.data[0],
                            ),
                            CustomLayout.lPad.sizedBoxH,
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
