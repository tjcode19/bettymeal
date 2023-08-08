import 'dart:developer';

import 'package:bettymeals/cubit/meal_cubit.dart';
import 'package:bettymeals/data/api/models/MealResponse.dart';
import 'package:bettymeals/ui/screens/foods/widgets/food_listtile.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/noti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  TextEditingController _searchController = TextEditingController();
  int page = 1;
  List<MealData> showMeal = [];
  bool pageOver =
      false; //this will be set to true so that it won't call loadNextpage method
  bool showBackTop = false;
  bool enableSearch = true;
  List<MealData> filteredList = [];

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  loadNextPage() {
    if (!pageOver) {
      print('Next page: $page');
      context.read<MealCubit>().getAllMeal('more', page: page + 1, data: showMeal);
    }
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Load next page or perform any other action when the user reaches the end of the list.
        loadNextPage();
      }

      if (_scrollController.position.pixels > 0) {
        setState(() {
          showBackTop = true;
        });
      } else {
        setState(() {
          showBackTop = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Our Recipes',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColour(context).primaryColour.withOpacity(0.7),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColour(context).background,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        // Get the available height
        double availableHeight = constraints.maxHeight;
        double availableW = constraints.maxWidth;

        // Calculate the height of the container based on the available height
        double listHeight = availableHeight * 0.7;
        return Container(
          color: Colors.transparent,
          height: availableHeight,
          child: Column(
            children: [
              Wrap(
                children: [
                  Chip(label: Text('All')),
                  Chip(label: Text('Breakfast')),
                  Chip(label: Text('Lunch')),
                  Chip(label: Text('Dinner')),
                  Chip(label: Text('Snacks')),
                  Chip(label: Text('Fruits'))
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: CommonUtils.padding),
                child: TextFormField(
                  controller: _searchController,
                  onChanged: (value) {
                    context.read<MealCubit>().filterMeal(value, showMeal);
                  },
                  // enabled: enableSearch,
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _searchController.clear();
                              context
                                  .read<MealCubit>()
                                  .filterMeal('', showMeal);
                            });
                          },
                          child: Icon(Icons.close))),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: listHeight,
                  width: CommonUtils.sw(context),
                  child: BlocConsumer<MealCubit, MealState>(
                    listener: (context, state) {
                      if (state is MealMoreSuccess) {
                        print('load more');
                        if (state.meals.isEmpty) {
                          pageOver = true;
                        } else {
                          // page += 1;
                          // filteredList.clear();
                          // filteredList.addAll(showMeal);
                          // showMeal.addAll(state.meals);
                          // inspect(showMeal);
                          // filteredList = showMeal;
                        }
                      }
                    },
                    builder: (context, state) {
                      Notificatn.hideLoading();
                      if (state is MealLoading) {
                        Notificatn.showLoading(context);
                      } else if (state is MealSuccess) {
                        showMeal = state.meals;
                        filteredList = state.meals;
                      } else if (state is MealSuccessFilter) {
                        filteredList = state.meals;
                        enableSearch = true;
                      }
                      // if (state is MealMoreSuccess) {
                      //   showMeal.addAll(state.meals);
                      //   filteredList = showMeal;

                      //   print('Add now');
                      // } 
                      else if (state is MealError) {
                        return const Center(
                          child: Text('Failed to load meals.'),
                        );
                      }

                      return ListView.builder(
                        // physics: const AlwaysScrollableScrollPhysics(),
                        controller: _scrollController,
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final meala = filteredList[index];
                          return FoodListTile(
                            meal: meala,
                            w: availableW * 0.6,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
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
