import 'package:bettymeals/data/models/food.dart';
import 'package:bettymeals/data/repositories/food_repository.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/food_cubit.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({Key? key}) : super(key: key);

  @override
  _AddMealScreenState createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  final _foodNameController = TextEditingController();
  final _foodDescriptionController = TextEditingController();
  final _foodImageController = TextEditingController();
  late FoodCubit _foodCubit;

  List<String> category = ['Breakfast', 'Lunch', 'Dinner'];
  List<int> items = [];

  @override
  void initState() {
    super.initState();
    _foodCubit = BlocProvider.of<FoodCubit>(context);

    _foodCubit.getAllMeals();
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _foodDescriptionController.dispose();
    _foodImageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Meal'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _foodNameController,
                      decoration: const InputDecoration(
                        labelText: 'Meal Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _foodDescriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _foodImageController,
                      decoration: const InputDecoration(
                        labelText: 'Image',
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    Row(
                      children: [
                        ...category.map((e) {
                          int pos = category.indexOf(e);
                          return chips(name: e, index: pos);
                        })
                      ],
                    ),
                    CommonUtils.spaceHm,
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          List<FoodModel> food = [];

                          for (int f in items) {
                            food.add(
                              FoodModel(
                                name: _foodNameController.text,
                                description: '',
                                type: f,
                                image: '',
                                extra: [],
                              ),
                            );
                          }

                          _foodCubit.addFood(food);
                          _foodCubit.getAllMeals();
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Add Meal'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: BlocBuilder<FoodCubit, FoodState>(
                builder: (context, state) {
                  if (state is FoodLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FoodLoaded) {
                    return ListView.builder(
                      itemCount: state.foods.length,
                      itemBuilder: (context, index) {
                        final meal = state.foods[index];
                        return Text(meal.name);
                      },
                    );
                  } else {
                    return Center(
                      child: Text('Failed to load meals.'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chips({index, name}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (items.contains(index)) {
            items.remove(index);
          } else {
            items.add(index);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: CommonUtils.xspadding, horizontal: CommonUtils.spadding),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: AppColour(context).onPrimaryColour,
            border: items.contains(index)
                ? Border.all(
                    width: 2.0, color: AppColour(context).secondaryColour)
                : Border(),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Text(
          name,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColour(context).secondaryColour),
        ),
      ),
    );
  }
}
