import 'package:flutter/material.dart';

class DeviceUtils {
  static hideKeyboard(
    BuildContext context,
  ) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static double getScaledSize(BuildContext context, {double scale = 1.0}) =>
      scale *
      (MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.height);

  static double width(BuildContext context, {double scale = 1.0}) =>
      scale * MediaQuery.of(context).size.width;

  static double height(BuildContext context, {double scale = 1.0}) =>
      scale * MediaQuery.of(context).size.height;

 
}
