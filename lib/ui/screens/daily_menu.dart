import 'package:bettymeals/routes.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../cubit/timetable_cubit.dart';
import '../widgets/timetable.dart';

class DailyMenuScreen extends StatefulWidget {
  const DailyMenuScreen({super.key});

  @override
  State<DailyMenuScreen> createState() => _DailyMenuScreenState();
}

class _DailyMenuScreenState extends State<DailyMenuScreen> {
  late final TimetableCubit _timetableCubit;

  final List<String> period = ['Breakfast', 'Lunch', 'Dinner'];

  @override
  void initState() {
    super.initState();
    _timetableCubit = context.read<TimetableCubit>();
    _timetableCubit.loadMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s Menu'),
      ),
      body: Container(
        padding: EdgeInsets.all(CommonUtils.padding),
        child: BlocBuilder<TimetableCubit, TimetableState>(
          builder: (context, state) {
            if (state is TimetableLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TimetableLoaded) {
              return Column(
                children: [
                  SizedBox(
                    height: CommonUtils.sh(context, s: 0.4),
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: CommonUtils.sw(context),
                          height: 100,
                          child: Card(
                            child: Column(
                              children: [
                                Text(period[index]),
                                Image(
                                  width: 100,
                                  height: 100,
                                  image: Svg('assets/icons/meal.svg'),
                                ),
                                Text('Koko and Bread'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text('Failed to load meals.'),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new meal item
          Navigator.pushNamed(context, Routes.addFood);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
