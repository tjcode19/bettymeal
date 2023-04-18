import 'package:bettymeals/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/category_cubit.dart';
import 'cubit/food_cubit.dart';
import 'cubit/timetable_cubit.dart';
import 'cubit/user_cubit.dart';
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
        BlocProvider(
          create: (context) => UserCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorScheme:
                ColorScheme.fromSwatch(primarySwatch: Colors.teal).copyWith(
              secondary: const Color(0xffc26700), //#66b2b2
              secondaryContainer: const Color(0xffc26700),
              onSecondary: Colors.black,
              tertiary: const Color.fromARGB(255, 5, 79, 116),
              onSurface: Colors.black,
              onBackground: Colors.black,
              background: const Color.fromARGB(255, 236, 244, 243),
            ),
            fontFamily: "Roboto",
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(color: Colors.white, fontSize: 18),
                  padding: const EdgeInsets.symmetric(horizontal: 15)),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.teal),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2),
              ),
            ),
            listTileTheme: const ListTileThemeData(
                textColor: Color(0xff576F72), style: ListTileStyle.drawer),
            textTheme: const TextTheme(
              // displayLarge:
              //     TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              titleLarge: TextStyle(fontWeight: FontWeight.bold),
              // bodySmall: TextStyle(color: Colors.white.withOpacity(0.8)),
              // bodyMedium: const TextStyle(
              //     color: Colors.white, fontWeight: FontWeight.bold),
            ),
            dataTableTheme: DataTableThemeData(
                dataTextStyle:
                    TextStyle(color: AppColour(context).secondaryColour)),
            iconTheme: const IconThemeData(color: Colors.teal, size: 20)),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.teal, brightness: Brightness.dark),
        ),
        themeMode: ThemeMode.light,
        initialRoute: Routes.splashScreen,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
