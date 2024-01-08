import 'dart:async';
import 'dart:developer';

import 'package:bettymeals/cubit/timetable_cubit.dart';
import 'package:bettymeals/data/api/repositories/timetableRepo.dart';
import 'package:bettymeals/utils/noti.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../data/api/models/GetSubscription.dart';
import '../data/api/models/GetUserDetails.dart';
import '../data/api/repositories/subRepo.dart';
import '../data/shared_preference.dart';
import '../services/inapp.dart';
import '../utils/enums.dart';

part 'sub_state.dart';

class SubCubit extends Cubit<SubState> {
  SubCubit()
      : sharedPreference = SharedPreferenceApp(),
        subRepository = SubRepository(),
        timetableRepo = TimetableRepo(),
        super(SubInitial());

  final SharedPreferenceApp sharedPreference;
  final SubRepository subRepository;
  final TimetableRepo timetableRepo;
  // final iapConnection;

  dynamic get iapConnection => IAPConnection.instance; //step 1
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<PurchasableProduct> productList = [];

  List<PurchasableProduct> get products => productList;

  var mSubId, mDuration;

  startListening() async {
    final purchaseUpdated = iapConnection.purchaseStream;
    _subscription = purchaseUpdated.listen(
      await _onPurchaseUpdate,
      onDone: await _updateStreamOnDone,
      onError: await _updateStreamOnError,
    );

    loadPurchases();
  }

  Future<void> loadPurchases() async {
    final available = await iapConnection.isAvailable();
    if (!available) {
      print('Store not available');
      return;
    }

    const ids = <String>{
      mGenerate100,
      mStardandM,
      mStardandW,
      mProM,
      mProW,
      mTest
    };
    final response = await iapConnection.queryProductDetails(ids);

    for (var element in response.notFoundIDs) {
      debugPrint('Purchase $element not found');
    }
    print('store available');

    productList = convertToPurchasableProducts(response.productDetails);
  }

  void _updateStreamOnDone() {
    print('Update stream on DOne');
    _subscription.cancel();
  }

  void _updateStreamOnError(dynamic error) {
    //Handle error here

    debugPrint('error $error');
  }

  void disposeSub() {
    debugPrint('dispose Sub');
    _subscription.cancel();
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    TimetableCubit tmCubit = TimetableCubit();
    // if (purchaseDetails.status == PurchaseStatus.purchased) {
    //   print('call handlePurchase after IF');
    //   switch (purchaseDetails.productID) {
    //     case mGenerate100:
    //       print('get credit');
    //       break;
    //     case mStardandM:
    //       print('standard Month');
    //       break;
    //     case mStardandW:
    //       print('standard Week');
    //       tmCubit.generateTimeableApi(mSubId, mDuration);
    //       break;
    //     case mProW:
    //       print('Pro Week');
    //       break;
    //     case mProM:
    //       print('Pro month');
    //       break;
    //   }
    // } else {
    //   print('call handlePurchase inside else ${purchaseDetails.status}');
    // }

    // if (purchaseDetails.pendingCompletePurchase) {
    //   await iapConnection.completePurchase(purchaseDetails);
    // }

    //######

    if (purchaseDetails.status == PurchaseStatus.pending) {
      emit(SubLoading());
    } else {
      print('call handlePurchase inside ELSE ${purchaseDetails.status}');
      if (purchaseDetails.status == PurchaseStatus.error) {
        // _handleError(purchaseDetails.error!);
        print("error");
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        bool valid = true;
        if (valid) {
          // _deliverProduct(purchaseDetails);
          print('standard Week');
          tmCubit.generateTimeableApi(mSubId, mDuration);
        }
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    }
  }

  Future<void> buy(PurchasableProduct product, subId, duration) async {
    mSubId = subId;
    mDuration = duration;
    final purchaseParam = PurchaseParam(productDetails: product.productDetails);
    switch (product.id) {
      case mGenerate100:
        await iapConnection.buyConsumable(purchaseParam: purchaseParam);
        break;
      case mStardandW:
      case mStardandM:
      case mProM:
      case mProW:
        await iapConnection.buyNonConsumable(purchaseParam: purchaseParam);
        break;
      default:
        throw ArgumentError.value(
            product.productDetails, '${product.id} is not a known product');
    }
  }

  Future<void> _onPurchaseUpdate(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      await _handlePurchase(purchaseDetails);
    }
  }

  List<PurchasableProduct> convertToPurchasableProducts(
      List<ProductDetails> productDetailsList) {
    return productDetailsList.map((productDetails) {
      return PurchasableProduct(
          id: productDetails.id,
          title: productDetails.title,
          description: productDetails.description,
          price: productDetails.price,
          currencyCode: productDetails.currencyCode,
          productDetails: productDetails);
    }).toList();
  }

  getSubscription() async {
    emit(SubLoading());
    try {
      final cal = await subRepository.getSubscription();

      if (cal.code != '000') {
        emit(SubError(cal.message!));
      } else {
        emit(SubSuccess(cal.data!));
      }
    } catch (e) {
      emit(SubError("Error Occured"));
    }
  }

  getActiveSub() async {
    final userData = await sharedPreference.getSharedPrefs(
        sharedType: SpDataType.object, fieldName: 'userData');
    UserData uData = UserData.fromJson(userData);

    int? regenerate;
    int l = uData.activeSub!.length;
    if (l > 0) {
      regenerate = uData.activeSub!.first.subData!.regenerate;
    }

    emit(ActiveSuccessLoaded(uData.activeSub!.first, regenerate!));
  }
}

enum ProductStatus {
  purchasable,
  purchased,
  pending,
}

const mStardandM = 'm_standard_month';
const mGenerate100 = 'm_regenerate_100';
const mStardandW = 'm_standard_week';
const mProM = 'm_pro_month';
const mProW = 'm_pro_week';
const mTest = 'test_service';

class PurchasableProduct {
  final String id;
  final String title;
  final String description;
  final String price;
  final String currencyCode;
  final ProductStatus status;
  final ProductDetails productDetails;

  PurchasableProduct(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.currencyCode,
      this.status = ProductStatus.purchasable,
      required this.productDetails});
}

// ...





