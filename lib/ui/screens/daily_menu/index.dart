import 'package:bettymeals/cubit/sub_cubit.dart';
import 'package:bettymeals/ui/screens/daily_menu/widgets/infocard.dart';
import 'package:bettymeals/ui/screens/daily_menu/widgets/update_profile.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/enums.dart';
import 'widgets/active_plan_card.dart';

class DailyMenuScreen extends StatefulWidget {
  const DailyMenuScreen({super.key});

  @override
  State<DailyMenuScreen> createState() => _DailyMenuScreenState();
}

class _DailyMenuScreenState extends State<DailyMenuScreen> {
  @override
  void initState() {
    context.read<SubCubit>().getActiveSub();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: CommonUtils.topPadding(context, s: 1.4),
              bottom: CommonUtils.padding,
            ),
            decoration: BoxDecoration(
                color: AppColour(context).primaryColour,
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(35))),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: CommonUtils.padding, right: CommonUtils.padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Hey, name \n',
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
                                  color: AppColour(context).onPrimaryColour),
                        ),
                      ),
                      GestureDetector(
                        // onTap: () => Navigator.pushNamed(context, Routes.plans,
                        //     arguments: subId),
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
                            'plan',
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
          CustomLayout.lPad.sizedBoxH,
          UpdateProfile(),
          CustomLayout.sPad.sizedBoxH,
          ActivePlanCard(),
          CustomLayout.sPad.sizedBoxH,
          InfoCard()
        ],
      ),
    );
  }
}
