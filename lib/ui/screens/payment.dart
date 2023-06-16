import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/timetable_cubit.dart';
import '../../data/api/models/GetSubscription.dart';
import '../../routes.dart';
import '../../utils/enums.dart';
import '../../utils/noti.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({required this.plan, required this.type, super.key});

  final SubscriptionData plan;
  final bool type;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // late final TimetableCubit _timetableCubit;

  DateTime currentDate = DateTime.now();
  final List<String> period = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];
  final today = HelperMethod.formatDate(DateTime.now().toIso8601String(),
      pattern: 'yyyy-MM-dd');

  final List<String> daysOfWeek = HelperMethod.dayOfWeek();

  int duration = 0;
  int price = 0;

  bool _isMonth = true;

  void _onSwitch(bool value) {
    setState(() {
      _isMonth = value;

      if (_isMonth) {
        price = widget.plan.period!.month!.price!;
        duration = widget.plan.period!.month!.duration!;
      } else {
        price = widget.plan.period!.week!.price!;
        duration = widget.plan.period!.week!.duration!;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _onSwitch(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColour(context).background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: CommonUtils.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Secured ',
                    children: [
                      TextSpan(
                        text: 'Payment ',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.black.withOpacity(0.8)),
                      ),
                    ],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black.withOpacity(0.5)),
                  ),
                ),
                CustomLayout.xxlPad.sizedBoxH,
                BlocBuilder<TimetableCubit, TimetableState>(
                    builder: (context, state) {
                  if (state is TimetableLoading) {
                    Notificatn.showLoading(context,
                        title: 'Preparing your meal table');
                  } else if (state is TimetableSuccess) {
                    Notificatn.hideLoading();
                    Navigator.pushNamed(context, Routes.home);
                  }
                  else if (state is TimetableInfo) {
                    Notificatn.hideLoading();
                    Notificatn.showInfoModal(context, msg: state.msg);
                  }
                  return Column(
                    children: [
                      Center(
                        child: Icon(
                          Icons.security_outlined,
                          size: CommonUtils.sw(context, s: 0.7),
                        ),
                      ),
                      CustomLayout.lPad.sizedBoxH,
                      RichText(
                        text: TextSpan(
                          text: 'Proceed to Payment of ',
                          children: [
                            TextSpan(
                              text: '\$$price ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: AppColour(context).primaryColour,
                                      fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'for ',
                            ),
                            TextSpan(
                              text: 'Basic Plan ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: AppColour(context).primaryColour,
                                      fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: '\nto be enjoyed for ',
                            ),
                            TextSpan(
                              text: '$duration days ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: AppColour(context).primaryColour,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.black.withOpacity(0.7)),
                        ),
                      ),
                      CustomLayout.xxlPad.sizedBoxH,
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                if (price == 0) {
                                  context
                                      .read<TimetableCubit>()
                                      .generateTimeableApi(widget.plan.sId);
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('PayStack'),
                                        content: Text(
                                            'You will be redirected to paystack to make payment'),
                                        actions: [
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Pay Now'),
                                            onPressed: () {},
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text('Continue'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
                // BlocBuilder<SubCubit, SubState>(
                //   builder: (context, state) {
                //     if (state is SubSuccess) {
                //       var a = state.data.map(
                //         (e) {
                //           int pos = state.data.indexOf(e);
                //           return PlanCard(
                //             duration: "7 Days",
                //             plan: e.name!,
                //             price: e.price.toString(),
                //             showBadge: widget.planId == e.sId,
                //             background: pos == 1
                //                 ? AppColour(context)
                //                     .secondaryColour
                //                     .withOpacity(0.1)
                //                 : pos == 2
                //                     ? Colors.blue.withOpacity(0.1)
                //                     : null,
                //             onPress: () {
                //               Navigator.pushNamed(
                //                   context, Routes.planDetails,
                //                   arguments: e);
                //             },
                //           );
                //         },
                //       );

                //       return Column(children: [...a]);
                //     } else {
                //       return Text('No record');
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
