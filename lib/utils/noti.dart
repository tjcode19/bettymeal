import 'package:bettymeals/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Notificatn {
  static loading() {}

  static showLoading(context, {String? title}) async {
    await EasyLoading.instance
      ..backgroundColor = AppColour(context).primaryColour;
    await EasyLoading.show(
      status: title,
      maskType: EasyLoadingMaskType.black,
    );
  }

  static hideLoading() async {
    await EasyLoading.dismiss();
  }

  static showErrorModal(context,
      {errorMsg = 'Error occured',
      toastPosition = EasyLoadingToastPosition.top}) {
    EasyLoading.instance..backgroundColor = AppColour(context).errorColor;
    EasyLoading.instance
      ..maskColor = AppColour(context).errorColor.withOpacity(0.2);

    EasyLoading.showError(
      errorMsg,
      maskType: EasyLoadingMaskType.custom,
    );
  }

  static showInfoModal(context,
      {msg = 'An info', toastPosition = EasyLoadingToastPosition.top}) {
    EasyLoading.instance
      ..backgroundColor = AppColour(context).onPrimaryColour.withOpacity(0.5);
    EasyLoading.instance..maskColor = Colors.black.withOpacity(0.2);

    EasyLoading.showInfo(
      msg,
      maskType: EasyLoadingMaskType.custom,
    );
  }

  static showErrorToast(context,
      {errorMsg = 'Error occured',
      toastPosition = EasyLoadingToastPosition.top}) {
    EasyLoading.instance..backgroundColor = AppColour(context).errorColor;
    EasyLoading.instance
      ..maskColor = AppColour(context).primaryColour.withOpacity(0.3);

    EasyLoading.showToast(errorMsg, toastPosition: toastPosition);
  }

  static showSuccessToast(context,
      {msg = 'Action Successful',
      toastPosition = EasyLoadingToastPosition.bottom}) async {
    await EasyLoading.instance
      ..backgroundColor = AppColour(context).primaryColour;
    await EasyLoading.instance
      ..maskColor = AppColour(context).primaryColour.withOpacity(0.3);

    await EasyLoading.showToast(msg, toastPosition: toastPosition);
  }
}
