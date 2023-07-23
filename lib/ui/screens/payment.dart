import 'dart:developer';

import 'package:bettymeals/cubit/dashboard_cubit.dart';
import 'package:bettymeals/cubit/sub_cubit.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
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
  List<PurchasableProduct> products = [];

  DateTime currentDate = DateTime.now();

  int duration = 0;
  int price = 0;
  late String planPeriodId;

  bool _isMonth = true;
  bool _isSuccess = false;

  void _onSwitch(bool value) {
    setState(() {
      _isMonth = value;

      if (_isMonth) {
        price = widget.plan.period!.month!.price!;
        duration = widget.plan.period!.month!.duration!;
        planPeriodId = widget.plan.period!.month!.id!;
      } else {
        price = widget.plan.period!.week!.price!;
        duration = widget.plan.period!.week!.duration!;
        planPeriodId = widget.plan.period!.week!.id!;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _onSwitch(widget.type);
    products = context.read<SubCubit>().products;
  }

  Future<void> buy(PurchasableProduct product) async {
    final a = context.read<SubCubit>().iapConnection;
    final purchaseParam = PurchaseParam(productDetails: product.productDetails);
    switch (product.id) {
      case "m_regenerate_100":
        await a.buyConsumable(purchaseParam: purchaseParam);
        break;
      case "m_standard_week":
      case "m_standard":
        await a.buyNonConsumable(purchaseParam: purchaseParam);
        break;
      default:
        throw ArgumentError.value(
            product.productDetails, '${product.id} is not a known product');
    }
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
                BlocListener<TimetableCubit, TimetableState>(
                  listener: (context, state) {
                    if (state is TimetableLoading) {
                      Notificatn.showLoading(context,
                          title: 'Preparing your meal table');
                    } else if (state is TimetableSuccess) {
                      Notificatn.hideLoading();

                      setState(() {
                        _isSuccess = true;
                      });
                    } else if (state is TimetableInfo) {
                      Notificatn.hideLoading();
                      Notificatn.showInfoModal(context, msg: state.msg);
                    }
                  },
                  child: !_isSuccess
                      ? Column(
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
                                            color: AppColour(context)
                                                .primaryColour,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: 'for ',
                                  ),
                                  TextSpan(
                                    text: '${widget.plan.name} ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: AppColour(context)
                                                .primaryColour,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: '\nto be enjoyed for ',
                                  ),
                                  TextSpan(
                                    text: '$duration days',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: AppColour(context)
                                                .primaryColour,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Colors.black.withOpacity(0.7)),
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
                                            .generateTimeableApi(
                                                widget.plan.sId, planPeriodId);
                                      } else {
                                        final checker = planPeriodId == 'WK'
                                            ? widget.plan.period!.week!.playId
                                            : widget.plan.period!.month!.playId;
                                        final p = products.firstWhere((e) {
                                          return e.id == checker;
                                        });
                                        inspect(p);
                                        buy(p);
                                        // showDialog(
                                        //   context: context,
                                        //   builder: (BuildContext context) {
                                        //     return AlertDialog(
                                        //       title: Text('Process Payment'),
                                        //       content: Text(
                                        //           'Your plan will be activated after succesful payment'),
                                        //       actions: [
                                        //         TextButton(
                                        //           child: Text('Cancel'),
                                        //           onPressed: () {
                                        //             Navigator.of(context).pop();
                                        //           },
                                        //         ),
                                        //         TextButton(
                                        //           child: Text('Pay Now'),
                                        //           onPressed: () {
                                        //             Navigator.of(context).pop();
                                        //             buy(widget.product);
                                        //             // context
                                        //             //     .read<TimetableCubit>()
                                        //             //     .generateTimeableApi(
                                        //             //         widget.plan.sId,
                                        //             //         planPeriodId);
                                        //           },
                                        //         ),
                                        //       ],
                                        //     );
                                        //   },
                                        // );
                                      }
                                    },
                                    child: const Text('Continue'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Center(
                              child: Icon(
                                Icons.check_circle_outline,
                                size: CommonUtils.sw(context, s: 0.7),
                              ),
                            ),
                            CustomLayout.lPad.sizedBoxH,
                            RichText(
                              text: TextSpan(
                                text: 'Payment Successful and meal table ',
                                children: [
                                  TextSpan(
                                    text: 'generated succeefully',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: AppColour(context)
                                                .primaryColour,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Colors.black.withOpacity(0.7)),
                              ),
                            ),
                            CustomLayout.xxlPad.sizedBoxH,
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      context
                                          .read<SubCubit>()
                                          .getSubscription();

                                      context
                                          .read<DashboardCubit>()
                                          .prepareDashboard('Payment screen');

                                      Navigator.popAndPushNamed(
                                          context, Routes.home);
                                    },
                                    child: const Text('Go to Dashboard'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                )

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
