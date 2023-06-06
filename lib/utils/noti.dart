import 'package:bettymeals/utils/colours.dart';
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
    EasyLoading.instance
      ..backgroundColor = AppColour(context).errorColor;
    EasyLoading.instance
      ..maskColor = AppColour(context).errorColor.withOpacity(0.2);

    EasyLoading.showError(
      errorMsg,
      maskType: EasyLoadingMaskType.custom,
    );
  }

  static showErrorToast(context,
      {errorMsg = 'Error occured',
      toastPosition = EasyLoadingToastPosition.top}) {
    EasyLoading.instance
      ..backgroundColor = AppColour(context).primaryColour.withOpacity(0.3);
    EasyLoading.instance
      ..maskColor = AppColour(context).primaryColour.withOpacity(0.3);

    EasyLoading.showToast(errorMsg, toastPosition: toastPosition);
  }
}