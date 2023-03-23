import 'package:flutter/material.dart';

class CommonUtils {
  static double xspadding = 10.0;
  static double spadding = 14.0;
  static double mpadding = 18.0;
  static double padding = 20.0;
  static double lpadding = 30.0;
  static double xlpadding = 40.0;

  static double xmargin = 20;

  static sw(BuildContext context, {double s = 1.0}) {
    return MediaQuery.of(context).size.width * s;
  }

  static sh(BuildContext context, {double s = 1.0}) {
    return MediaQuery.of(context).size.height * s;
  }


  static topPadding(BuildContext context, {double s = 1.0}) {
    return MediaQuery.of(context).padding.top * s;
  }
}
