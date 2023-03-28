import 'package:bettymeals/ui/widgets/food_card.dart';
import 'package:bettymeals/ui/widgets/section_title.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/timetable_cubit.dart';
import '../../../data/models/food.dart';
import '../../../data/models/timetable.dart';
import '../../widgets/food_item_sub.dart';

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
      FoodModel(
          description: 'Good as breakfast because it is very light',
          image:
              'https://www.thespruceeats.com/thmb/D5lsBYYAz2NiIup3evaCXteK8hM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/hausa-koko-spicy-millet-porridge-39547-hero-01-edb486a34d6a4ee3b8b347430838d1f7.jpg',
          name: 'Koko',
          type: 0,
          extra: [
            'Kose',
            'Bofloat',
            'Kose Bread',
            'Sugar bread/Tea bread/Butter bread'
          ]),
      FoodModel(
          description: 'Laagba good for luch',
          image:
              'https://images.pexels.com/photos/1660030/pexels-photo-1660030.jpeg?auto=compress&cs=tinysrgb&w=1200',
          name: 'Laagba',
          type: 1,
          extra: ['Beef/Salmon/Chicken', 'Ademe/Okro/Stew']),
      FoodModel(
          description: 'Suitable for dinner',
          image:
              'https://images.pexels.com/photos/1410235/pexels-photo-1410235.jpeg?auto=compress&cs=tinysrgb&w=1200',
          name: 'Rice',
          type: 2,
          extra: ['Vegetables/Eggs/Salmon', 'Stew', 'Fruit Juice'])
    ])
  ];

  late ScrollController _scrollController;
  int _scrollPosition = 0;
  int _selected = 0;

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

    // int a = 0;
    // while (a < 6) {
    //   currentDate = currentDate.add(const Duration(days: 1));
    //   timetable.add(
    //     TimetableModel(date: currentDate, foods: [
    //       FoodModel(
    //           description: 'Light food', image: '', name: 'Koko', extra: []),
    //       FoodModel(
    //           description: 'Light food', image: '', name: 'Laagba', extra: []),
    //       FoodModel(
    //           description: 'Light food', image: '', name: 'Rice', extra: [])
    //     ]),
    //   );

    //   a++;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: CommonUtils.topPadding(context, s: 1.4),
              bottom: CommonUtils.padding,
            ),
            decoration: BoxDecoration(
                color: AppColour(context).primaryColour,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(35))),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: CommonUtils.padding),
                  child: RichText(
                    text: TextSpan(
                      text: 'Hey, Betty \n',
                      children: [
                        TextSpan(
                          text: 'Meal is ready!',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColour(context)
                                        .onPrimaryColour
                                        .withOpacity(0.7),
                                  ),
                        )
                      ],
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: AppColour(context).onPrimaryColour),
                    ),
                  ),
                )
              ],
            ),
          ),
          CommonUtils.spaceH,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 50.0,
                      maxHeight: 80.0,
                    ),
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        top: 8, bottom: 8, left: CommonUtils.padding),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: timetable.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selected = index;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: CommonUtils.mpadding),
                            margin:
                                EdgeInsets.only(right: CommonUtils.xspadding),
                            decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              color: _selected != index
                                  ? AppColour(context).primaryColour
                                  : AppColour(context).secondaryColour,
                              border: Border.all(
                                  width: 1.0,
                                  color: AppColour(context).onPrimaryColour),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateWay(timetable[index].date).tDay,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  DateWay(timetable[index].date).tDate,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  DateWay(timetable[index].date).tMon,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  CommonUtils.spaceH,
                  //The card listview implemetation starts here
                  SizedBox(
                    height: CommonUtils.sh(context, s: 0.4),
                    width: CommonUtils.sw(context, s: 1),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: timetable[_selected].foods.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        List<FoodModel> t = timetable[_selected].foods;
                        return SizedBox(
                            width: CommonUtils.sw(context) -
                                (CommonUtils.padding * 0.8),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: FoodCard(
                                food: t[index],
                                period: period[index],
                              ),
                            ));
                      },
                    ),
                  ),
                  //The card listview implemetation ends here
                  Column(
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
                            itemCount: timetable.length,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
