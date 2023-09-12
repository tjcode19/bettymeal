import 'package:bettymeals/cubit/dashboard_cubit.dart';
import 'package:bettymeals/cubit/notification_cubit.dart';
import '../../../routes.dart';
import '../../../utils/device_utils.dart';
import '../../widgets/shimmer_widget.dart';
import 'widgets/existing_user.dart';
import 'widgets/infocard.dart';
import 'widgets/new_user.dart';
import 'widgets/update_profile.dart';
import '../../../utils/colours.dart';
import '../../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;

import '../../../utils/enums.dart';

class DailyMenuScreen extends StatefulWidget {
  const DailyMenuScreen({super.key});

  @override
  State<DailyMenuScreen> createState() => _DailyMenuScreenState();
}

class _DailyMenuScreenState extends State<DailyMenuScreen> {
  String subId = '';
  String name = 'Guest';
  String plan = "...";

  @override
  void initState() {
    context.read<NotificationCubit>().getTips();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          bool isFreshUser = false;

          if (state is LoadDashboard) {
            isFreshUser = state.data.isFreshUser!;
            name = state.data.user!.firstName!;
            plan = state.isActiveSub
                ? state.data.activeSub![0].sub!.name!
                : 'Select Plan';
            subId = state.isActiveSub ? state.data.activeSub![0].sub!.sId! : '';
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
                                  context, Routes.notificationList, arguments: subId),
                              child: badges.Badge(
                                  position: badges.BadgePosition.topEnd(
                                      top: -20, end: -10),
                                  badgeContent: Text(
                                    '1',
                                    style: TextStyle(color: AppColour(context).primaryColour),
                                  ),
                                  badgeAnimation:
                                      badges.BadgeAnimation.rotation(
                                    animationDuration: Duration(seconds: 1),
                                    colorChangeAnimationDuration:
                                        Duration(seconds: 1),
                                    loopAnimation: false,
                                    curve: Curves.fastOutSlowIn,
                                    colorChangeAnimationCurve:
                                        Curves.easeInCubic,
                                  ),
                                  badgeStyle: badges.BadgeStyle(
                                    badgeColor:
                                        AppColour(context).onPrimaryColour,
                                    padding: const EdgeInsets.all(8),
                                    borderSide: BorderSide(
                                        color:
                                            AppColour(context).primaryColour,
                                        width: 1),
                                  ),
                                  child: Icon(
                                    Icons.notifications_none_outlined,
                                    color: Colors.white,
                                    size: 35,
                                  )))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    CustomLayout.mPad.sizedBoxH,
                    if (state is LoadDashboard && name == 'Guest')
                      UpdateProfile(),
                    CustomLayout.mPad.sizedBoxH,
                    if (state is DashboardLoading)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          right: 8.0,
                        ),
                        child: shimmerWidget(
                            row: 4,
                            height:
                                (DeviceUtils.height(context) * 0.3).toDouble()),
                      ),
                    if (isFreshUser) NewUserWidget() else ExistingUserWidget(),
                    CustomLayout.mPad.sizedBoxH,
                    InfoCard(),
                    CustomLayout.mPad.sizedBoxH,
                  ],
                )),
              )
            ],
          );
        },
      ),
    );
  }
}
