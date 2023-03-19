import 'package:bettymeals/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/timetable_cubit.dart';
import '../widgets/timetable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TimetableCubit _timetableCubit;

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
        title: Text('Meal Timetable'),
      ),
      body: BlocBuilder<TimetableCubit, TimetableState>(
        builder: (context, state) {
          if (state is TimetableLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TimetableLoaded) {
            print('welcome herr');
            return ListView.builder(
              itemCount: state.timetable.length,
              itemBuilder: (context, index) {
                final meal = state.timetable[index];
                return TimetableItemWidget(timetable: meal);
              },
            );
          } else {
            return Center(
              child: Text('Failed to load meals.'),
            );
          }
        },
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
