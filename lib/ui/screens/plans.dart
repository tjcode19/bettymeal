import 'package:bettymeals/cubit/sub_cubit.dart';
import 'package:bettymeals/cubit/user_cubit.dart' as cs;
import 'package:bettymeals/ui/screens/daily_menu/widgets/plan_card.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/user_cubit.dart';
import '../../../routes.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({this.planId, super.key});

  final String? planId;

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  // late final TimetableCubit _timetableCubit;

  DateTime currentDate = DateTime.now();
  final List<String> period = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];
  final today = HelperMethod.formatDate(DateTime.now().toIso8601String(),
      pattern: 'yyyy-MM-dd');

  final List<String> daysOfWeek = HelperMethod.dayOfWeek();

  int foodSize = 0;

  bool isActiveSub = false;

  @override
  void initState() {
    super.initState();

    isActiveSub = context.read<UserCubit>().isActiveSub();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColour(context).background,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.only(
            //     top: CommonUtils.topPadding(context, s: 1.4),
            //     bottom: CommonUtils.padding,
            //   ),
            //   decoration: BoxDecoration(
            //       color: AppColour(context).primaryColour,
            //       borderRadius:
            //           const BorderRadius.only(bottomLeft: Radius.circular(35))),
            //   width: double.infinity,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.only(
            //             left: CommonUtils.padding, right: CommonUtils.padding),
            //         child: BlocBuilder<cs.UserCubit, cs.UserState>(
            //           builder: (context, state) {
            //             String name = 'Guest';

            //             if (state is cs.GetUser) {
            //               name = state.name;
            //             }
            //             return Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 RichText(
            //                   text: TextSpan(
            //                     text: 'Hey, $name \n',
            //                     children: [
            //                       TextSpan(
            //                         text: 'Meal is ready!',
            //                         style: Theme.of(context)
            //                             .textTheme
            //                             .bodySmall!
            //                             .copyWith(
            //                               color: AppColour(context)
            //                                   .onPrimaryColour
            //                                   .withOpacity(0.7),
            //                             ),
            //                       )
            //                     ],
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .titleLarge!
            //                         .copyWith(
            //                             color:
            //                                 AppColour(context).onPrimaryColour),
            //                   ),
            //                 ),
            //                 Container(
            //                   color: AppColour(context).onPrimaryColour,
            //                   child: Text('The plan'),
            //                 )
            //               ],
            //             );
            //           },
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            CommonUtils.spaceH,
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
                                      color: AppColour(context).primaryColour,
                                      fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'to get started',
                            )
                          ],
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.black.withOpacity(0.7)),
                        ),
                      ),
                    ),
                    BlocBuilder<SubCubit, SubState>(
                      builder: (context, state) {
                        if (state is SubSuccess) {
                          var a = state.data.map(
                            (e) {
                              int pos = state.data.indexOf(e);
                              return PlanCard(
                                duration: "7 Days",
                                plan: e.name!,
                                price: e.price.toString(),
                                showBadge: widget.planId == e.sId,
                                background: pos == 1
                                    ? AppColour(context)
                                        .secondaryColour
                                        .withOpacity(0.1)
                                    : pos == 2
                                        ? Colors.blue.withOpacity(0.1)
                                        : null,
                                onPress: () {
                                  Navigator.pushNamed(context, Routes.planDetails,
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
        ),
      ),
    );
  }
}
