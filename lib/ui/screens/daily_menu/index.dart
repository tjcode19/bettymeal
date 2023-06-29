import 'package:bettymeals/cubit/dashboard_cubit.dart';
import 'package:bettymeals/ui/screens/daily_menu/widgets/existing_user.dart';
import 'package:bettymeals/ui/screens/daily_menu/widgets/new_user.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../routes.dart';
import '../../../utils/device_utils.dart';
import '../../widgets/shimmer_widget.dart';

class DailyMenuScreen extends StatefulWidget {
  const DailyMenuScreen({super.key});

  @override
  State<DailyMenuScreen> createState() => _DailyMenuScreenState();
}

class _DailyMenuScreenState extends State<DailyMenuScreen> {
  // late final TimetableCubit _timetableCubit;

  DateTime currentDate = DateTime.now();

  final today = HelperMethod.formatDate(DateTime.now().toIso8601String(),
      pattern: 'yyyy-MM-dd');

  final List<String> daysOfWeek = HelperMethod.dayOfWeek();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          String name = 'Guest';
          String plan = "Select Plan";
          bool isActiveSub = false;
          bool isFreshUser = false;
          String subId = '';
          late int shuffle;
          var subInfo;

          if (state is LoadDashboard) {
            name = state.data.user!.firstName!;
            plan = state.isActiveSub
                ? state.data.activeSub![0].sub!.name!
                : 'Select Plan';
            isActiveSub = state.isActiveSub;
            subId = state.isActiveSub ? state.data.activeSub![0].sub!.sId! : '';
            isFreshUser = state.data.isFreshUser!;
            subInfo = state.data.activeSub;
            shuffle = state.shuffle;
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
              // CustomLayout.mPad.sizedBoxH,
              if (state is DashboardLoading)
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 8.0, top: 8.0),
                  child: shimmerWidget(
                      row: 4,
                      height: (DeviceUtils.height(context) * 0.6).toDouble()),
                )
              else if (state is LoadDashboard)
                if (!isFreshUser)
                  ExistingUserWidget(name, isActiveSub, subInfo, shuffle)
                else
                  NewUserWidget(name)
            ],
          );
        },
      ),
    );
  }
}
