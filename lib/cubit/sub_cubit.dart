import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
        super(SubInitial());

  final SharedPreferenceApp sharedPreference;
  final SubRepository subRepository;
  // final iapConnection;

  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<PurchasableProduct> productList = [];

  List<PurchasableProduct> get products => productList;
  dynamic get iapConnection => IAPConnection.instance;

  startListening() {
    final purchaseUpdated = iapConnection.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
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
    };
    final response = await iapConnection.queryProductDetails(ids);
    for (var element in response.notFoundIDs) {
      debugPrint('Purchase $element not found');
    }
    print('store available');

    productList = convertToPurchasableProducts(response.productDetails);
  }

  void _updateStreamOnDone() {
    _subscription.cancel();
  }

  void _updateStreamOnError(dynamic error) {
    //Handle error here
  }

  void disposeSub() {
    _subscription.cancel();
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      switch (purchaseDetails.productID) {
        case mGenerate100:
          print('get credit');
          break;
        case mStardandM:
          print('standard Month');
          break;
        case mStardandW:
          print('standard Week');
          break;
        case mProW:
          print('Pro Week');
          break;
        case mProM:
          print('Pro month');
          break;
      }
    }

    if (purchaseDetails.pendingCompletePurchase) {
      await iapConnection.completePurchase(purchaseDetails);
    }
  }

  Future<void> _onPurchaseUpdate(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      await _handlePurchase(purchaseDetails);
      inspect(purchaseDetails);
    }
    print('Purchase Update');
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

      inspect(cal);
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

const mStardandM = 'm_standard';
const mGenerate100 = 'm_regenerate_100';
const mStardandW = 'm_standard_week';
const mProM = 'm_pro_month';
const mProW = 'm_pro_week';

// class PurchasableProduct {
//   String get id => productDetails.id;
//   String get title => productDetails.title;
//   String get description => productDetails.description;
//   String get price => productDetails.price;
//   ProductStatus status;
//   ProductDetails productDetails;

//   PurchasableProduct(this.productDetails) : status = ProductStatus.purchasable;
// }

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





