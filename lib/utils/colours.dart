import 'package:flutter/material.dart';

class AppColour {
  AppColour(this.context);

  final BuildContext context;

  Color get primaryColour => Theme.of(context).colorScheme.primary;
  Color get onPrimaryColour => Theme.of(context).colorScheme.onPrimary;

  Color get secondaryColour => Theme.of(context).colorScheme.secondary;
  Color get onSecondaryColour => Theme.of(context).colorScheme.onSecondary;

  Color get cardColor => Theme.of(context).colorScheme.secondaryContainer;
}
