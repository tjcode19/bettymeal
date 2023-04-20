import 'dart:convert';

import 'package:bettymeals/data/models/food.dart';
import 'package:bettymeals/data/repositories/food_repository.dart';
import 'package:bettymeals/ui/widgets/badge.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../cubit/food_cubit.dart';
import '../../data/shared_preference.dart';
import '../../utils/enums.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({this.typeId, Key? key}) : super(key: key);

  final int? typeId;

  @override
  _AddMealScreenState createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  final _foodNameController = TextEditingController();
  final _foodDescriptionController = TextEditingController();
  final _foodImageController = TextEditingController();
  final _foodExtraController = TextEditingController();
  late FoodCubit _foodCubit;
  final SharedPreferenceApp sharedPreference = SharedPreferenceApp();

  List<String> category = ['Breakfast', 'Lunch', 'Dinner'];
  List<int> items = [];
  bool isError = false;

  @override
  void initState() {
    if (widget.typeId! < 3) {
      items.add(widget.typeId!);
    }

    print(widget.typeId);
    super.initState();

    _foodCubit = BlocProvider.of<FoodCubit>(context);

    _foodCubit.getAllMeals();
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _foodDescriptionController.dispose();
    _foodImageController.dispose();
    _foodExtraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 24.0,
        foregroundColor: Colors.white,
        title: Text(
          'Add Meal',
          style: TextStyle(color: AppColour(context).onPrimaryColour),
        ),
        backgroundColor: AppColour(context).primaryColour,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: CommonUtils.padding),
              child: BlocConsumer<FoodCubit, FoodState>(
                listener: (context, state) {
                  if (state is FoodLoaded) {
                    if (state.bf.length >= 3 &&
                        state.ln.length >= 3 &&
                        state.dn.length >= 3) {
                      // isOkay = true;
                    }
                  }
                },
                builder: (context, state) {
                  if (state is FoodLoaded) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: CommonUtils.padding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBadge(
                            onTap: () {},
                            badgeContent: Text(
                              (state.bf.length +
                                      state.ln.length +
                                      state.dn.length)
                                  .toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            label: const Text(
                              'All',
                            ),
                          ),
                          CustomBadge(
                            onTap: () {},
                            badgeContent: Text(
                              state.bf.length.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            label: const Text(
                              'Breakfast',
                            ),
                          ),
                          CustomBadge(
                            onTap: () {},
                            badgeContent: Text(
                              state.ln.length.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            label: const Text(
                              'Lunch',
                            ),
                          ),
                          CustomBadge(
                            onTap: () {},
                            badgeContent: Text(
                              state.dn.length.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            label: const Text(
                              'Dinner',
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Text('No Record');
                  }
                },
              ),
            ),
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
                          labelText: 'Enter Food Name',
                          hintText: 'e.g White Rice'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter food name';
                        }
                        return null;
                      },
                    ),
                    CustomLayout.sPad.sizedBoxH,
                    TextFormField(
                      controller: _foodDescriptionController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter a valid number';
                      //   }
                      //   return null;
                      // },
                    ),
                    CustomLayout.sPad.sizedBoxH,
                    TextFormField(
                      controller: _foodImageController,
                      decoration: const InputDecoration(
                        labelText: 'Image',
                      ),
                    ),
                    // CustomLayout.sPad.sizedBoxH,
                    // TextFormField(
                    //   controller: _foodExtraController,
                    //   decoration: const InputDecoration(
                    //     labelText: 'Extra',
                    //   ),
                    // ),
                    CustomLayout.lPad.sizedBoxH,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline),
                        CustomLayout.mPad.sizedBoxW,
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87),
                              text:
                                  'Select the meal type(s) for this food. You can select multiple if application  ' +
                                      'If the food can be taken as ',
                              children: [
                                TextSpan(
                                  text: 'breakfast ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: AppColour(context)
                                              .secondaryColour),
                                ),
                                TextSpan(
                                  text: 'and ',
                                ),
                                TextSpan(
                                  text: 'lunch ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: AppColour(context)
                                              .secondaryColour),
                                ),
                                TextSpan(
                                  text: 'kindly select both.',
                                ),
                              ],
                            ),
                          ),
                          // Text(
                          //   'Select the meal type(s) for this food. You can select multiple if application. ' +
                          //       'If the food can be taken as Breakfast and Lunch, kindly select both',
                          //   textAlign: TextAlign.justify,
                          // ),
                        )
                      ],
                    ),
                    CustomLayout.lPad.sizedBoxH,
                    Row(
                      children: [
                        ...category.map((e) {
                          int pos = category.indexOf(e);
                          return chips(name: e, index: pos);
                        })
                      ],
                    ),
                    CustomLayout.lPad.sizedBoxH,
                    if (isError)
                      Row(
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                          CustomLayout.mPad.sizedBoxW,
                          Text('Please select meal')
                        ],
                      ),
                    CustomLayout.mPad.sizedBoxH,
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (items.isNotEmpty) {
                            FoodRequestModel food = FoodRequestModel(
                              name: _foodNameController.text,
                              description: _foodDescriptionController.text,
                              type: jsonEncode(items),
                              image:
                                  'https://images.pexels.com/photos/1410235/pexels-photo-1410235.jpeg?auto=compress&cs=tinysrgb&w=1200',
                            );

                            _foodNameController.clear();
                            _foodDescriptionController.clear();

                            items = [];

                            await _foodCubit.addFood(food);
                            _foodCubit.getAllMeals();

                            final ft = await sharedPreference.getSharedPrefs(
                                    sharedType: SpDataType.bool,
                                    fieldName: 'firstTimer') ??
                                true;
                            if (ft)
                              Navigator.of(context).pop();
                            else
                              EasyLoading.showSuccess(
                                  'Food added successfully');
                          } else {
                            setState(() {
                              isError = true;
                            });
                          }
                        }
                      },
                      child: const Text('Add Meal'),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.4,
            //   child: BlocBuilder<FoodCubit, FoodState>(
            //     builder: (context, state) {
            //       if (state is FoodLoading) {
            //         return Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       } else if (state is FoodLoaded) {
            //         return ListView.separated(
            //           itemCount: state.foods.length,
            //           itemBuilder: (context, index) {
            //             final meal = state.foods[index];
            //             return Padding(
            //               padding: EdgeInsets.symmetric(
            //                   horizontal: CommonUtils.mpadding),
            //               child: Text(meal.name),
            //             );
            //           },
            //           separatorBuilder: (BuildContext context, int index) {
            //             return Divider(
            //               color: AppColour(context).primaryColour.withOpacity(0.4),
            //               thickness: 3,
            //             );
            //           },
            //         );
            //       } else {
            //         return Center(
            //           child: Text('Failed to load meals.'),
            //         );
            //       }
            //     },
            //   ),
            // ),
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

          if (items.isEmpty)
            isError = true;
          else
            isError = false;
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
