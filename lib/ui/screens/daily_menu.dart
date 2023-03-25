import 'package:bettymeals/routes.dart';
import 'package:bettymeals/ui/widgets/food_card.dart';
import 'package:bettymeals/ui/widgets/section_title.dart';
import 'package:bettymeals/ui/widgets/time_table.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../cubit/timetable_cubit.dart';
import '../../data/models/food.dart';
import '../../data/models/timetable.dart';
import '../widgets/food_item_sub.dart';
import '../widgets/timetable.dart';

class DailyMenuScreen extends StatefulWidget {
  const DailyMenuScreen({super.key});

  @override
  State<DailyMenuScreen> createState() => _DailyMenuScreenState();
}

class _DailyMenuScreenState extends State<DailyMenuScreen> {
  late final TimetableCubit _timetableCubit;

  DateTime currentDate = DateTime.now();
  final List<String> period = ['Breakfast', 'Lunch', 'Dinner'];

  final List<TimetableModel> timetable = [
    TimetableModel(date: DateTime.now(), foods: [
      FoodModel(description: 'Light food', image: '', name: 'Koko'),
      FoodModel(description: 'Light food', image: '', name: 'Laagba'),
      FoodModel(description: 'Light food', image: '', name: 'Rice')
    ])
  ];

  late ScrollController _scrollController;
  int _scrollPosition = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition =
          (_scrollController.position.pixels / CommonUtils.sw(context)).round();
    });
  }

  String periodOfTheDay() {
    var time = DateTime.now();

    if (time.hour < 12) {
      return "Breakfast";
    } else if (time.hour > 12 && time.hour < 15) {
      return "Lunch";
    } else {
      return "Dinner";
    }
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _timetableCubit = context.read<TimetableCubit>();
    _timetableCubit.loadMeals();

    int a = 0;
    while (a < 6) {
      currentDate = currentDate.add(const Duration(days: 1));
      timetable.add(
        TimetableModel(date: currentDate, foods: [
          FoodModel(description: 'Light food', image: '', name: 'Koko'),
          FoodModel(description: 'Light food', image: '', name: 'Laagba'),
          FoodModel(description: 'Light food', image: '', name: 'Rice')
        ]),
      );

      a++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: CommonUtils.sh(context),
        child: Stack(
          children: [
            Container(
              color: AppColour(context).primaryColour,
              height: CommonUtils.sh(context, s: 0.4),
              padding: EdgeInsets.only(
                  top: CommonUtils.topPadding(context, s: 1.4),
                  bottom: CommonUtils.padding,
                  right: CommonUtils.padding,
                  left: CommonUtils.padding),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    HelperMethod.formatDate(
                        timetable[_scrollPosition].date.toIso8601String(),
                        pattern: 'EEE, dd MMM, yy'),
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: AppColour(context).onPrimaryColour),
                  ),
                  Text(
                    periodOfTheDay(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColour(context)
                            .onPrimaryColour
                            .withOpacity(0.7)),
                  ),
                  Text(HelperMethod.formatDate(
                      timetable[2].date.toIso8601String(),
                      pattern: 'HH:mm:ss')),
                ],
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: SizedBox(
                height: CommonUtils.sh(context, s: 0.3),
                child: SingleChildScrollView(
                  physics: const PageScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: SectionTitle(text: 'What\'s new?'),
                      ),
                      Container(
                        // height: CommonUtils.sh(context, s: 0.3),
                        width: CommonUtils.sw(context),
                        padding: EdgeInsets.all(CommonUtils.padding),
                        decoration:
                            BoxDecoration(color: AppColour(context).cardColor),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0.0),
                          title: const Text('Effect of Carbs'),
                          subtitle: Text('Lorem ipsum fd sum' * 8),
                        ),
                      ),
                      const SectionTitle(text: 'Popular meals'),
                      // _buildSelectionRing(50),
                      SizedBox(
                        height: CommonUtils.sh(context, s: 0.1),
                        width: CommonUtils.sw(context, s: 1),
                        child: ListView.builder(
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return FoodItemSub(
                                timetable: timetable[index],
                                foodType: 1,
                                mealType: 'Lunch',
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: CommonUtils.sh(context, s: 0.2),
              child: SizedBox(
                height: CommonUtils.sh(context, s: 0.4),
                width: CommonUtils.sw(context, s: 1),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: timetable.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SizedBox(
                        width: CommonUtils.sw(context) -
                            (CommonUtils.padding * 0.6),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: FoodCard(
                            timetable: timetable[index],
                          ),
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionRing(double itemSize) {
    return IgnorePointer(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          width: itemSize,
          height: itemSize,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColour(context).primaryColour,
              border: Border.fromBorderSide(
                BorderSide(width: 6.0, color: Colors.red),
              ),
            ),
            
          ),
        ),
      ),
    );
  }
}
