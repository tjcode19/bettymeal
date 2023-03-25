import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: CommonUtils.padding, vertical: CommonUtils.mpadding),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
