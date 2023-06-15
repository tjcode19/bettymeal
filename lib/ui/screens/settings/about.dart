import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../utils/colours.dart';
import '../../../utils/enums.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  bool _showFab = true;
  bool _isElevated = true;
  bool _isVisible = true;

  void _onShowFabChanged(bool value) {
    setState(() {
      _showFab = value;
    });
  }

  void _onElevatedChanged(bool value) {
    setState(() {
      _isElevated = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(10, 56),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: CommonUtils.spadding, vertical: 0.0),
          child: AppBar(
            leadingWidth: 24,
            title: Text(
              'About',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColour(context).primaryColour.withOpacity(0.7),
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: AppColour(context).background,
          ),
        ),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CommonUtils.padding),
          child: Column(
            children: <Widget>[
              Text(
                'Edit Profile ' * 245,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black.withOpacity(0.7),
                    ),
              ),
              CustomLayout.lPad.sizedBoxH,
              Text(
                'Mealble 1.0.0',
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black.withOpacity(0.3),
                    ),
              )
      
              // Expanded(
              //   child: ListView(
              //     controller: _controller,
              //     children: items.toList(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
