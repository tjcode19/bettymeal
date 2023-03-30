import 'package:bettymeals/data/models/food.dart';
import 'package:bettymeals/routes.dart';
import 'package:bettymeals/ui/screens/foods/widgets/food_listtile.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/food_cubit.dart';
import '../../../cubit/timetable_cubit.dart';
import '../../../utils/colours.dart';
import '../../widgets/timetable.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen>
    with SingleTickerProviderStateMixin {
  late FoodCubit _foodCubit;

  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _foodCubit = BlocProvider.of<FoodCubit>(context);

    _foodCubit.getAllMeals();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Food Bank',
          style: TextStyle(color: AppColour(context).onPrimaryColour),
        ),
        backgroundColor: AppColour(context).primaryColour,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColour(context).onPrimaryColour,
          labelColor: AppColour(context).onPrimaryColour,
          unselectedLabelColor:
              AppColour(context).onPrimaryColour.withOpacity(0.6),
          tabs: const [
            Tab(
              icon: Icon(Icons.favorite),
              text: 'Breakfast',
            ),
            Tab(
              icon: Icon(Icons.star),
              text: 'Lunch',
            ),
            Tab(
              icon: Icon(Icons.star),
              text: 'Dinner',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(top: CommonUtils.padding),
              width: CommonUtils.sw(context),
              child: BlocBuilder<FoodCubit, FoodState>(
                builder: (context, state) {
                  if (state is FoodLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FoodLoaded) {
                    List<FoodModel> bf = [];

                    for (FoodModel f in state.foods) {
                      if (f.type == 0) bf.add(f);
                    }

                    return ListView.builder(
                      itemCount: bf.length,
                      itemBuilder: (context, index) {
                        final meal = bf[index];
                        return FoodListTile(meal: meal);
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Failed to load meals.'),
                    );
                  }
                },
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(top: CommonUtils.padding),
              width: CommonUtils.sw(context),
              child: BlocBuilder<FoodCubit, FoodState>(
                builder: (context, state) {
                  if (state is FoodLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FoodLoaded) {
                    List<FoodModel> ml = [];

                    for (FoodModel f in state.foods) {
                      if (f.type == 1) ml.add(f);
                    }

                    return ListView.builder(
                      itemCount: ml.length,
                      itemBuilder: (context, index) {
                        final meal = ml[index];
                        return FoodListTile(meal: meal);
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Failed to load meals.'),
                    );
                  }
                },
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(top: CommonUtils.padding),
              width: CommonUtils.sw(context),
              child: BlocBuilder<FoodCubit, FoodState>(
                builder: (context, state) {
                  if (state is FoodLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FoodLoaded) {
                    List<FoodModel> dn = [];

                    for (FoodModel f in state.foods) {
                      if (f.type == 2) dn.add(f);
                    }

                    return ListView.builder(
                      itemCount: dn.length,
                      itemBuilder: (context, index) {
                        final meal = dn[index];
                        return FoodListTile(meal: meal);
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Failed to load meals.'),
                    );
                  }
                },
              ),
            ),
          ),
        ],
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
