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
import '../../main.dart';
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
  //******** New Implementation */
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  final iapConnection = IAPConnection.instance;
  List<PurchasableProduct> products = [];
  //****** End here */

  static const Set<String> _kIds = <String>{'product1', 'product2'};

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

  // Future<void> initStoreInfo() async {
  //   final bool isAvailable = await _inAppPurchase.isAvailable();

  //   if (isAvailable) {
  //     final ProductDetailsResponse response =
  //         await _inAppPurchase.queryProductDetails(_kIds);

  //     if (response.notFoundIDs.isNotEmpty) {
  //       // Handle the error.
  //     }
  //     products = response.productDetails;

  //     for (final ProductDetails product in products) {
  //       print(product.id);
  //       print(product.price);
  //       print(product.description);
  //     }
  //   } else {
  //     print('Sorry, store is unavailable');
  //   }
  // }

  @override
  void initState() {
    // _subscription = _inAppPurchase.purchaseStream.listen((purchaseDetailsList) {
    //   print('listen');
    //   _listenToPurchaseUpdated(purchaseDetailsList);
    // }, onDone: () {
    //   print('listen');
    //   _subscription.cancel();
    // }, onError: (error) {
    //   // handle error here.
    //   print('errror INAPP');
    // });
    // initStoreInfo();
    super.initState();

    isActiveSub = context.read<UserCubit>().isActiveSub();

    final purchaseUpdated = iapConnection.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
    loadPurchases();
  }

  Future<void> _onPurchaseUpdate(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      await _handlePurchase(purchaseDetails);
    }
    print('Purchase Update');
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      switch (purchaseDetails.productID) {
        case 'm_regenerate_100':
          print('get credit');
          break;
        case "m_standard_week":
          print('standard week');
          break;
        case "m_standard":
          print('standard month');
          break;
      }
    }

    if (purchaseDetails.pendingCompletePurchase) {
      await iapConnection.completePurchase(purchaseDetails);
    }
  }

  void _updateStreamOnDone() {
    _subscription.cancel();
  }

  void _updateStreamOnError(dynamic error) {
    //Handle error here
  }

  Future<void> loadPurchases() async {
    final available = await iapConnection.isAvailable();
    if (!available) {
      print('Store not available');
      return;
    }

    const ids = <String>{
      "m_regenerate_100",
      "m_standard_week",
      "m_standard",
    };
    final response = await iapConnection.queryProductDetails(ids);
    for (var element in response.notFoundIDs) {
      debugPrint('Purchase $element not found');
    }
    products =
        response.productDetails.map((e) => PurchasableProduct(e)).toList();
    print('store available');
    inspect(products);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
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
                                    ? AppColour(context).secondaryColour
                                    : pos == 2
                                        ? Colors.blue
                                        : null,
                                onPress: () {
                                  Navigator.pushNamed(
                                      context, Routes.planDetails,
                                      arguments: [e, products[0]]);
                                  // buy(products[1]);
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

enum ProductStatus {
  purchasable,
  purchased,
  pending,
}

class PurchasableProduct {
  String get id => productDetails.id;
  String get title => productDetails.title;
  String get description => productDetails.description;
  String get price => productDetails.price;
  ProductStatus status;
  ProductDetails productDetails;

  PurchasableProduct(this.productDetails) : status = ProductStatus.purchasable;
}
