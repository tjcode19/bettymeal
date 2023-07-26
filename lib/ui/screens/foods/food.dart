import 'package:bettymeals/cubit/meal_cubit.dart';
import 'package:bettymeals/data/api/models/MealResponse.dart';
import 'package:bettymeals/ui/screens/foods/widgets/food_listtile.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/food_cubit.dart';
import '../../../utils/colours.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<MealData> showMeal = [];
  bool pageOver = false;
  bool showBackTop = false;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // _foodCubit = BlocProvider.of<FoodCubit>(context);

    // _foodCubit.getAllMeals();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Our Recipes',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColour(context).primaryColour.withOpacity(0.7),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColour(context).background,
        //   bottom: TabBar(
        //     controller: _tabController,
        //     dividerColor: AppColour(context).primaryColour.withOpacity(0.4),
        //     indicatorColor: AppColour(context).primaryColour,
        //     labelColor: AppColour(context).primaryColour,
        //     unselectedLabelColor:
        //         AppColour(context).primaryColour.withOpacity(0.6),
        //     tabs: const [
        //       Tab(
        //         // icon: Icon(Icons.favorite),
        //         text: 'Breakfast',
        //       ),
        //       Tab(
        //         // icon: Icon(Icons.star),
        //         text: 'Lunch',
        //       ),
        //       Tab(
        //         // icon: Icon(Icons.star),
        //         text: 'Dinner',
        //       ),
        //     ],
        //   ),
        // ),
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<MealCubit>().getAllMeal(),

        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: CommonUtils.padding),
            width: CommonUtils.sw(context),
            height: CommonUtils.sh(context),
            child: BlocBuilder<MealCubit, MealState>(
              builder: (context, state) {
                if (state is MealSuccess) {
                  if (state.meals.isEmpty) {
                    pageOver = true;
                  } else
                    showMeal.addAll(state.meals);
                }
                // else {
                //   return const Center(
                //     child: Text('Failed to load meals.'),
                //   );
                // }
                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollEndNotification) {
                      // Check if the user has reached the end of the list
                      if (_scrollController.position.extentAfter == 0) {
                        // Call the function to load the next page here
                        // loadNextPage();
                        if (!pageOver) {
                          setState(() {
                            page++;
                          });
                          context
                              .read<MealCubit>()
                              .getAllMeal(page: page, limit: 10);
                        } else {
                          setState(() {
                            showBackTop = true;
                          });
                        }
                      }
                    }
                    return true;
                  },
                  child: Column(
                    children: [
                      if (state is MealLoading)
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      Expanded(
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          itemCount: showMeal.length,
                          itemBuilder: (context, index) {
                            final meala = showMeal[index];
                            return FoodListTile(meal: meala);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        // Center(
        //   child: Container(
        //     padding: EdgeInsets.only(top: CommonUtils.padding),
        //     width: CommonUtils.sw(context),
        //     child: BlocBuilder<MealCubit, MealState>(
        //       builder: (context, state) {
        //         if (state is MealLoading) {
        //           return const Center(
        //             child: CircularProgressIndicator(),
        //           );
        //         } else if (state is MealSuccess) {
        //           return ListView.builder(
        //             itemCount: state.ln.length,
        //             itemBuilder: (context, index) {
        //               final meal = state.ln[index];
        //               return FoodListTile(meal: meal);
        //             },
        //           );
        //         } else {
        //           return const Center(
        //             child: Text('Failed to load meals.'),
        //           );
        //         }
        //       },
        //     ),
        //   ),
        // ),
        // Center(
        //   child: Container(
        //     padding: EdgeInsets.only(top: CommonUtils.padding),
        //     width: CommonUtils.sw(context),
        //     child: BlocBuilder<MealCubit, MealState>(
        //       builder: (context, state) {
        //         if (state is FoodLoading) {
        //           return const Center(
        //             child: CircularProgressIndicator(),
        //           );
        //         } else if (state is MealSuccess) {
        //           return ListView.builder(
        //             itemCount: state.dn.length,
        //             itemBuilder: (context, index) {
        //               final meal = state.dn[index];
        //               return FoodListTile(meal: meal);
        //             },
        //           );
        //         } else {
        //           return const Center(
        //             child: Text('Failed to load meals.'),
        //           );
        //         }
        //       },
        //     ),
        //   ),
        // ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, Routes.addFood, arguments: 3);
      //   },
      //   child: Icon(Icons.add),
      // ),
      floatingActionButton: showBackTop
          ? FloatingActionButton(
              onPressed: () {
                // When the FAB is pressed, scroll to the top of the ListView
                _scrollController.animateTo(0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut);

                setState(() {
                  showBackTop = false;
                });
              },
              child: Icon(Icons.arrow_upward),
            )
          : null,
    );
  }
}
