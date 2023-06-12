import 'package:bettymeals/cubit/auth_cubit.dart';
import 'package:bettymeals/cubit/sub_cubit.dart';
import 'package:bettymeals/ui/screens/daily_menu/widgets/plan_card.dart';
import 'package:bettymeals/ui/widgets/food_card.dart';
import 'package:bettymeals/ui/widgets/section_title.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:bettymeals/utils/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/timetable_cubit.dart';
import '../../../data/api/models/GetTimetable.dart';
import '../../../routes.dart';
import '../../../utils/enums.dart';

class DailyMenuScreen extends StatefulWidget {
  const DailyMenuScreen({super.key});

  @override
  State<DailyMenuScreen> createState() => _DailyMenuScreenState();
}

class _DailyMenuScreenState extends State<DailyMenuScreen> {
  // late final TimetableCubit _timetableCubit;

  DateTime currentDate = DateTime.now();
  final List<String> period = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];
  final today = HelperMethod.formatDate(DateTime.now().toIso8601String(),
      pattern: 'yyyy-MM-dd');

  final List<String> daysOfWeek = HelperMethod.dayOfWeek();

  int _selected = 0;

  @override
  void initState() {
    super.initState();

    _selected = daysOfWeek.indexOf(HelperMethod.formatDate(
        DateTime.now().toIso8601String(),
        pattern: 'yyyy-MM-dd'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          String name = 'Guest';
          String plan = "Basic";
          bool isActiveSub = false;
          String subId = '';

          if (state is LoginSuccess) {
            name = state.data.firstName!;
            plan = state.data.subInfo!.sub!.name!;
            isActiveSub = state.isActiveSub;
            subId = state.data.subInfo!.sub!.sId!;
          }
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: CommonUtils.topPadding(context, s: 1.4),
                  bottom: CommonUtils.padding,
                ),
                decoration: BoxDecoration(
                    color: AppColour(context).primaryColour,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(35))),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: CommonUtils.padding,
                          right: CommonUtils.padding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Hey, $name \n',
                              children: [
                                TextSpan(
                                  text: 'Meal is ready!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: AppColour(context)
                                            .onPrimaryColour
                                            .withOpacity(0.7),
                                      ),
                                )
                              ],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color:
                                          AppColour(context).onPrimaryColour),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, Routes.plans,
                                arguments: subId),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: CommonUtils.padding, vertical: 6),
                              decoration: BoxDecoration(
                                // color: AppColour(context).onPrimaryColour,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                plan,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              CommonUtils.spaceH,
              if (isActiveSub)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: CommonUtils.padding),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: CommonUtils.padding, vertical: 6),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Row(children: [
                              Icon(Icons.notification_important),
                              CustomLayout.sPad.sizedBoxW,
                              Text('Update your profile')
                            ]),
                          ),
                        ),
                        CustomLayout.mPad.sizedBoxH,
                        Container(
                          constraints: const BoxConstraints(
                            minHeight: 50.0,
                            maxHeight: 80.0,
                          ),
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              top: 8, bottom: 8, left: CommonUtils.padding),
                          child: BlocBuilder<TimetableCubit, TimetableState>(
                            builder: (context, state) {
                              if (state is TimetableLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is GetTableSuccess) {
                                List<Timetable> tVal = state.data[0].timetable!;
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: tVal.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
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
                                              ? AppColour(context).primaryColour
                                              : AppColour(context)
                                                  .secondaryColour,
                                          border: Border.all(
                                              width: 1.0,
                                              color: AppColour(context)
                                                  .onPrimaryColour),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              DateWay(DateTime.parse(tVal[index]
                                                      .meals![0]
                                                      .date!))
                                                  .tDay,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            Text(
                                              DateWay(DateTime.parse(tVal[index]
                                                      .meals![0]
                                                      .date!))
                                                  .tDate,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            Text(
                                              DateWay(DateTime.parse(tVal[index]
                                                      .meals![0]
                                                      .date!))
                                                  .tMon,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (state is NoSubSuccess) {
                                return Center(
                                  child: Text(state.msg),
                                );
                              } else {
                                return const Center(
                                  child: Text('Failed to retrieve timetable.'),
                                );
                              }
                            },
                          ),
                        ),
                        CommonUtils.spaceH,
                        //The card listview implemetation starts here
                        BlocBuilder<TimetableCubit, TimetableState>(
                          builder: (context, state) {
                            if (state is TimetableLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is GetTableSuccess) {
                              List<Timetable> tVal = state.data[0].timetable!;
                              return tVal.isNotEmpty
                                  ? SizedBox(
                                      height: CommonUtils.sh(context, s: 0.4),
                                      width: CommonUtils.sw(context, s: 1),
                                      child: ListView.builder(
                                        // controller: _scrollController,
                                        itemCount:
                                            tVal[_selected].meals!.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          List<Meals> t =
                                              tVal[_selected].meals!;
                                          return SizedBox(
                                            width: CommonUtils.sw(context) -
                                                (CommonUtils.padding * 0.8),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: FoodCard(
                                                food: t[index],
                                                period: period[index],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Text('You need to add some food',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: AppColour(context)
                                                  .secondaryColour));
                            } else {
                              return const Center(
                                child: Text('Failed to load meals.'),
                              );
                            }
                          },
                        ),
                        //The card listview implemetation ends here
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              child: SectionTitle(text: 'What\'s new?'),
                            ),
                            Container(
                              // height: CommonUtils.sh(context, s: 0.3),
                              width: CommonUtils.sw(context),
                              padding: EdgeInsets.all(CommonUtils.padding),
                              decoration: BoxDecoration(
                                  color: AppColour(context).cardColor),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(0.0),
                                title: const Text('Effect of Carbs'),
                                subtitle: Text('Lorem ipsum fd sum' * 8),
                              ),
                            ),
                            const SectionTitle(text: 'Popular meals'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              if (!isActiveSub)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: CommonUtils.padding,
                              vertical: CommonUtils.xspadding),
                          child: RichText(
                            text: TextSpan(
                              text: 'Select from ',
                              children: [
                                TextSpan(
                                  text: 'Our Plans ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color:
                                              AppColour(context).primaryColour,
                                          fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'to get started',
                                )
                              ],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Colors.black.withOpacity(0.7)),
                            ),
                          ),
                        ),
                        BlocBuilder<SubCubit, SubState>(
                          builder: (context, state) {
                            if (state is SubLoading) {
                              return Text('Loading Available Subscriptions');
                            }
                            if (state is SubSuccess) {
                              var a = state.data.map(
                                (e) {
                                  int pos = state.data.indexOf(e);
                                  return PlanCard(
                                    duration: "${e.duration!} Days",
                                    plan: e.name!,
                                    price: e.price.toString(),
                                    background: pos == 1
                                        ? AppColour(context)
                                            .secondaryColour
                                            .withOpacity(0.1)
                                        : pos == 2
                                            ? Colors.blue.withOpacity(0.1)
                                            : null,
                                    onPress: () {
                                      Navigator.pushNamed(
                                          context, Routes.planDetails,
                                          arguments: e);
                                    },
                                  );
                                },
                              );

                              return Column(children: [...a]);
                            } else {
                              return Text('No record');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
