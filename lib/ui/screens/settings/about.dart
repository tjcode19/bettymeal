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
          padding: EdgeInsets.symmetric(
              horizontal: CommonUtils.spadding, vertical: 0.0),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CommonUtils.padding),
          child: Column(
            children: <Widget>[
              Text(
                'Welcome to Mealble, your ultimate meal planning companion! Say goodbye to the hassle of deciding what to eat every day. With Mealble, you can effortlessly plan your meal timetable for a week or even a whole month, ensuring you never have to stress about your daily nutrition needs again.',
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black.withOpacity(0.7),
                    ),
              ),
              CustomLayout.sPad.sizedBoxH,
              Text(
                'Our app is designed to simplify your meal planning process, allowing you to focus on enjoying delicious and balanced meals. Whether you\'re a busy professional, a health-conscious individual, or someone who simply wants to optimize their eating habits, Mealble has got you covered.',
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black.withOpacity(0.7),
                    ),
              ),
              CustomLayout.sPad.sizedBoxH,
              Text(
                'One of the key features of Mealble is its ability to create a comprehensive meal timetable that covers three square meals a day, along with daily fruit suggestions and snack options. We understand the importance of a balanced diet, and our app provides you with carefully curated meal plans that incorporate a variety of nutrients, flavors, and culinary inspirations.',
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black.withOpacity(0.7),
                    ),
              ),
              CustomLayout.sPad.sizedBoxH,
              Text(
                'Not sure what to cook or feeling adventurous? Mealble\'s shuffle and regenerate feature is here to help. With just a tap, you can shuffle your meal plan to discover exciting new recipes or regenerate your entire timetable for a fresh and diverse culinary experience. No more boring meals or repetitive menus!',
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
