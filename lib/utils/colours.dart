import 'package:flutter/material.dart';

class AppColour {
  AppColour(this.context);

  final BuildContext context;

  Color get primaryColour => Theme.of(context).colorScheme.primary;
  Color get onPrimaryColour => Theme.of(context).colorScheme.onPrimary;
}
