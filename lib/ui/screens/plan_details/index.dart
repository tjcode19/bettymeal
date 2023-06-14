import 'dart:ui';

import 'package:bettymeals/data/api/models/GetSubscription.dart';
import 'package:bettymeals/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../cubit/timetable_cubit.dart';
import '../../../../routes.dart';
import '../../../../utils/colours.dart';
import '../../../cubit/user_cubit.dart' as cs;

import 'package:badges/badges.dart' as badges;

import '../../../cubit/user_cubit.dart';
import '../../../utils/constants.dart';
import 'widgets/features.dart';

class PlanDetails extends StatefulWidget {
  const PlanDetails({required this.plan, super.key});

  final SubData plan;

  @override
  State<PlanDetails> createState() => _PlanDetailsState();
}

class _PlanDetailsState extends State<PlanDetails> {
  String gender = 'None';

  bool _isMonth = true;

  void _onSwitch(bool value) {
    setState(() {
      _isMonth = value;
    });
  }

  @override
  void initState() {
    super.initState();

    context.read<UserCubit>().getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     widget.plan.name!,
      //     style: Theme.of(context)
      //         .textTheme
      //         .titleLarge!
      //         .copyWith(color: AppColour(context).onPrimaryColour),
      //   ),
      //   backgroundColor: AppColour(context).primaryColour,
      // ),
      backgroundColor: Colors.white,
      body: BlocListener<cs.UserCubit, cs.UserState>(
        listener: (context, state) {},
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: CommonUtils.sh(context, s: 0.3),
                padding: EdgeInsets.only(
                    top: CommonUtils.xlpadding,
                    left: CommonUtils.padding,
                    right: CommonUtils.padding),
                decoration: BoxDecoration(
                  color: AppColour(context).onSecondaryColour,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://images.pexels.com/photos/1410235/pexels-photo-1410235.jpeg?auto=compress&cs=tinysrgb&w=1200'),
                      fit: BoxFit.cover,
                      opacity: 0.6),
                  borderRadius: BorderRadius.vertical(
                    top: const Radius.circular(20),
                    bottom: Radius.elliptical(CommonUtils.sw(context), 50.0),
                  ),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    textTheme: Theme.of(context).textTheme.apply(
                        displayColor: Colors.white, bodyColor: Colors.white),
                  ),
                  child: Column(
                    children: [
                      CustomLayout.lPad.sizedBoxH,
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: CircleAvatar(
                                backgroundColor:
                                    AppColour(context).secondaryColour,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.only(
                            //       left: 5, top: 5, bottom: 5),
                            //   decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       borderRadius:
                            //           BorderRadius.all(Radius.circular(8))),
                            //   child: Row(
                            //     children: [
                            //       for (String a in widget.meal.category!)
                            //         Text(
                            //           a + ' ',
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .bodyMedium!
                            //               .copyWith(
                            //                   fontWeight: FontWeight.bold),
                            //         )
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      CustomLayout.xxlPad.sizedBoxH,
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: AppColour(context).secondaryColour,
                                width: 2.0),
                          ),
                        ),
                        child: Text(
                          widget.plan.name!,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  color: AppColour(context).onPrimaryColour,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomLayout.xlPad.sizedBoxH,
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('What you will enjoy:',
                        style: Theme.of(context).textTheme.bodyLarge),
                    CustomLayout.sPad.sizedBoxH,

                    FeatureText('14 unique recipes or more'),
                    FeatureText('3 meals per day'),
                    FeatureText('3 regenerate credit per week'),
                    FeatureText('Daily Snacks'),
                    FeatureText(
                      'Access to store',
                      available: false,
                    ),
                    FeatureText(
                      'How to prepare meal',
                      available: false,
                    ),
                    FeatureText(
                      'Set favourite meal',
                      available: false,
                    ),
                    FeatureText(
                      'Auto generate',
                      available: false,
                    ),

                    CustomLayout.sPad.sizedBoxH,

                    CustomLayout.xlPad.sizedBoxH,
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: CommonUtils.padding),
                      decoration: BoxDecoration(
                        color: AppColour(context).onPrimaryColour,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: widget.plan.price! == 0
                          ? Container(
                              padding: EdgeInsets.all(CommonUtils.padding),
                              decoration: BoxDecoration(
                                color: AppColour(context).secondaryColour,
                                borderRadius: BorderRadius.horizontal(
                                  left: const Radius.circular(5),
                                  right: Radius.elliptical(
                                      CommonUtils.sw(context), 70.0),
                                ),
                              ),
                              child: RichText(
                                text: TextSpan(
                                  text: '',
                                  children: [
                                    WidgetSpan(
                                      child: Transform.translate(
                                        offset: const Offset(0.0, -10.0),
                                        child: Text(
                                          '\$',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  color: AppColour(context)
                                                      .onPrimaryColour
                                                      .withOpacity(0.7)),
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${widget.plan.price!}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              color: AppColour(context)
                                                  .onPrimaryColour),
                                    ),
                                    TextSpan(
                                      text: '.00 ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: AppColour(context)
                                                .onPrimaryColour
                                                .withOpacity(0.7),
                                          ),
                                    ),
                                    TextSpan(text: '\nfor '),
                                    TextSpan(
                                      text: '${widget.plan.duration!}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: AppColour(context)
                                                .onPrimaryColour,
                                          ),
                                    ),
                                    TextSpan(
                                      text: ' Days',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: AppColour(context)
                                                .onPrimaryColour
                                                .withOpacity(0.7),
                                          ),
                                    )
                                  ],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color:
                                            AppColour(context).onPrimaryColour,
                                      ),
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(CommonUtils.padding),
                                  decoration: BoxDecoration(
                                    color: AppColour(context).secondaryColour,
                                    borderRadius: BorderRadius.horizontal(
                                      left: const Radius.circular(5),
                                      right: Radius.elliptical(
                                          CommonUtils.sw(context), 70.0),
                                    ),
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      text: '',
                                      children: [
                                        WidgetSpan(
                                          child: Transform.translate(
                                            offset: const Offset(0.0, -10.0),
                                            child: Text(
                                              '\$',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      color: AppColour(context)
                                                          .onPrimaryColour
                                                          .withOpacity(0.7)),
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: _isMonth
                                              ? '${widget.plan.price! * 3}'
                                              : '${widget.plan.price!}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  color: AppColour(context)
                                                      .onPrimaryColour),
                                        ),
                                        TextSpan(
                                          text: '.00 ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: AppColour(context)
                                                    .onPrimaryColour
                                                    .withOpacity(0.7),
                                              ),
                                        ),
                                        TextSpan(text: '\nfor '),
                                        TextSpan(
                                          text:
                                              '${_isMonth ? widget.plan.duration! : 7}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: AppColour(context)
                                                    .onPrimaryColour,
                                              ),
                                        ),
                                        TextSpan(
                                          text: ' Days',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: AppColour(context)
                                                    .onPrimaryColour
                                                    .withOpacity(0.7),
                                              ),
                                        )
                                      ],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: AppColour(context)
                                                .onPrimaryColour,
                                          ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text('Weekly'),
                                    Switch(
                                      value: _isMonth,
                                      onChanged: _onSwitch,
                                      activeColor:
                                          AppColour(context).secondaryColour,
                                      inactiveTrackColor: AppColour(context)
                                          .secondaryColour
                                          .withOpacity(0.4),
                                      inactiveThumbColor:
                                          AppColour(context).secondaryColour,
                                    ),
                                    Text('Monthly'),
                                  ],
                                ),
                              ],
                            ),
                    ),
                    CustomLayout.xlPad.sizedBoxH,
                    // Center(
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       Navigator.pushNamed(context, Routes.addFood);
                    //     },
                    //     child: const Text('Add New Food'),
                    //   ),
                    // ),
                    // CustomLayout.lPad.sizedBoxH,
                    Center(
                      child: OutlinedButton(
                        onPressed: () {
                          context
                              .read<TimetableCubit>()
                              .generateTimeableApi(widget.plan.sId);

                          // context.read<UserCubit>().setFirstTimer(false);

                          Navigator.pushNamed(context, Routes.home);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: AppColour(context).primaryColour),
                        ),
                        child: const Text('Generate Mealtable'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget badgeer(
      {required int typeId,
      required Widget badgeContent,
      required Widget label}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.addFood, arguments: typeId);
      },
      child: badges.Badge(
        badgeContent: badgeContent,
        badgeStyle: badges.BadgeStyle(
          badgeColor: AppColour(context).primaryColour,
          padding: const EdgeInsets.all(8),
          borderSide:
              BorderSide(color: AppColour(context).primaryColour, width: 1),
        ),
        child: Chip(
          label: label,
          side: BorderSide(color: AppColour(context).primaryColour),
        ),
      ),
    );
  }
}
