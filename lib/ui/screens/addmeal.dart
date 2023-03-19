import 'package:bettymeals/data/models/food.dart';
import 'package:bettymeals/data/repositories/food_repository.dart';
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
  final _foodCaloriesController = TextEditingController();
  final _foodCategoryController = TextEditingController();
  late FoodCubit _foodCubit;

  @override
  void initState() {
    super.initState();
    _foodCubit = BlocProvider.of<FoodCubit>(context);

    _foodCubit.getAllMeals();
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _foodCaloriesController.dispose();
    _foodCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Meal'),
      ),
      body: Column(
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
                    controller: _foodCaloriesController,
                    decoration: const InputDecoration(
                      labelText: 'Calories',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _foodCategoryController,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final food = Food(
                            name: _foodNameController.text,
                            // calories: int.parse(_foodCaloriesController.text),
                            // category: _foodCategoryController.text,
                            description: '',
                            id: 1,
                            image: '');
                        // await FoodRepository().insertFood(food);

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
                  print('welcome herr ${state.foods.length}');
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
    );
  }
}
