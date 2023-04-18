import 'package:flutter/material.dart';

enum CustomLayout { msPad, sPad, mPad, lPad, xlPad, xxlPad }

enum UserState { merchant, payer }

enum SignUpState { merchant, payer }

enum SpDataType { String, bool, int, double, object }

enum ToastType { success, error, info }

extension MyPaddingExtension on CustomLayout {
  EdgeInsets get padding {
    switch (this) {
      case CustomLayout.msPad:
        return const EdgeInsets.all(5.0);
      case CustomLayout.sPad:
        return const EdgeInsets.all(10.0);
      case CustomLayout.mPad:
        return const EdgeInsets.all(15.0);
      case CustomLayout.lPad:
        return const EdgeInsets.all(20.0);
      case CustomLayout.xlPad:
        return const EdgeInsets.all(25.0);
      case CustomLayout.xxlPad:
        return const EdgeInsets.all(30.0);
      default:
        return const EdgeInsets.all(35.0);
    }
  }

  SizedBox get sizedBoxH {
    switch (this) {
      case CustomLayout.msPad:
        return const SizedBox(height: 4.0);
      case CustomLayout.sPad:
        return const SizedBox(height: 8.0);
      case CustomLayout.mPad:
        return const SizedBox(height: 12.0);
      case CustomLayout.lPad:
        return const SizedBox(height: 16.0);
      case CustomLayout.xlPad:
        return const SizedBox(height: 25.0);
      case CustomLayout.xxlPad:
        return const SizedBox(height: 40.0);
      default:
        return const SizedBox(height: 30.0);
    }
  }

  SizedBox get sizedBoxW {
    switch (this) {
      case CustomLayout.sPad:
        return const SizedBox(width: 2.0);
      case CustomLayout.mPad:
        return const SizedBox(width: 5.0);
      case CustomLayout.lPad:
        return const SizedBox(width: 8.0);
      case CustomLayout.xlPad:
        return const SizedBox(width: 10.0);
      default:
        return const SizedBox(width: 20.0);
    }
  }
}
