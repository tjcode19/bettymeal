import 'dart:async';
import 'dart:developer';

import 'package:bettymeals/cubit/sub_cubit.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../../cubit/user_cubit.dart';
import '../../routes.dart';
import '../widgets/plan_card.dart';

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

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  static const Set<String> _kIds = <String>{'product1', 'product2'};
  List<ProductDetails> products = [];
  List<PurchaseDetails> _purchases = [];
  late ProductDetailsResponse response;

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsL) {
    _purchases.addAll(purchaseDetailsL);

    inspect(_purchases);
    _purchases.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // _showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // _handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            // _deliverProduct(purchaseDetails);
          } else {
            // _handleInvalidPurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }

  Future<bool> _verifyPurchase(purchaseDetails) {
    //TDO
    //check the server for purchase status
    return Future.value(true);
  }

  makePurchase(ProductDetails prod) {
    // final ProductDetails productDetails = ... // Saved earlier from queryProductDetails().
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);

    InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);

// From here the purchase flow will be handled by the underlying store.
// Updates will be delivered to the `InAppPurchase.instance.purchaseStream`.
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();

    if (isAvailable) {
      final ProductDetailsResponse response =
          await _inAppPurchase.queryProductDetails(_kIds);

      if (response.notFoundIDs.isNotEmpty) {
        // Handle the error.
      }
      products = response.productDetails;

      for (final ProductDetails product in products) {
        print(product.id);
        print(product.price);
        print(product.description);
      }
    } else {
      print('Sorry, store is unavailable');
    }
  }

  @override
  void initState() {
    _subscription = _inAppPurchase.purchaseStream.listen((purchaseDetailsList) {
      print('listen');
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      print('listen');
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
      print('errror INAPP');
    });
    initStoreInfo();
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
                                plan: e,
                                showBadge: widget.planId == e.sId,
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
                                  // makePurchase(products[0]);
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
