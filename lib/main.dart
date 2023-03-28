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
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
              .copyWith(
                  secondary: const Color(0xff576F72),
                  secondaryContainer: const Color(0xffCBE4DE),
                  onSurface: Colors.black,
                  onBackground: Colors.black,
                  background: Colors.grey[300]),
          fontFamily: "Roboto",
          textTheme: TextTheme(
            // displayLarge:
            //     TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            titleLarge: const TextStyle(fontWeight: FontWeight.bold),
            bodySmall: TextStyle(color: Colors.white.withOpacity(0.7)),
            bodyMedium: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
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
