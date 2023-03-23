import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/category_cubit.dart';
import 'cubit/food_cubit.dart';
import 'cubit/timetable_cubit.dart';
import 'data/database/app_database.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryCubit(),
        ),
        BlocProvider(
          create: (context) => FoodCubit(),
        ),
        BlocProvider(
          create: (context) => TimetableCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
            fontFamily: "Roboto",
            textTheme: const TextTheme(
                // displayLarge:
                //     TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                // titleLarge:
                //     TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold),
                )),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.teal, brightness: Brightness.dark),
        ),
        themeMode: ThemeMode.light,
        initialRoute: Routes.home,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
