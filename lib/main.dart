import 'package:bettymeals/cubit/dashboard_cubit.dart';
import 'package:bettymeals/cubit/records_cubit.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/noti.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'cubit/auth_cubit.dart';
import 'cubit/category_cubit.dart';
import 'cubit/food_cubit.dart';
import 'cubit/meal_cubit.dart';
import 'cubit/notification_cubit.dart';
import 'cubit/store_cubit.dart';
import 'cubit/sub_cubit.dart';
import 'cubit/timetable_cubit.dart';
import 'cubit/tips_cubit.dart';
import 'cubit/user_cubit.dart';
import 'data/local/database/app_database.dart';
import 'routes.dart';
import 'utils/custom_anim.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await AppDatabase().init();

  runApp(BlocProvider(
    create: (context) => NotificationCubit(),
    child: MyApp(),
  ));

  configLoading();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? _token;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  void _requestNotificationPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> _initializeFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        _token = token;
      });

      print('device id: $_token');
    });

    _firebaseMessaging.onTokenRefresh
    .listen((fcmToken) {
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.

      print('device id refreshed: $_token');
    })
    .onError((err) {
      // Error getting token.
    });


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground notification received ${message.data} hererr');
      // Handle the received message here

      Notificatn.showSuccessToast(context,
          msg: '${message.data['title']} \n ${message.data['body']} ');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Background/terminated notification opened ${message.data}');

      // Handle the notification when the user taps on it
      // Navigator.pushNamed(context, Routes.notificationScreen);
      context.read<NotificationCubit>().storeNoti(context, msg: message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    print('Handling a background message ${message.data} hanba');
    // Handle the background message here
    // Navigator.pushNamed(context, Routes.notificationScreen);
  }

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
          create: (context) => MealCubit(),
        ),
        BlocProvider(
          create: (context) => TimetableCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => SubCubit(),
          // lazy: false,
        ),
        BlocProvider(
          create: (context) => StoreCubit(),
          
        ),
        BlocProvider(
          create: (context) => NotificationCubit(),
        ),
        BlocProvider(
          create: (context) => TipsCubit(),
        ),
        BlocProvider(
          create: (context) => RecordsCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => DashboardCubit(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Mealble',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorScheme:
                ColorScheme.fromSwatch(primarySwatch: Colors.teal).copyWith(
              primary: const Color(0xff009688),
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
                  textStyle: const TextStyle(color: Colors.white, fontSize: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 15)),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  // backgroundColor: Colors.teal,
                  // foregroundColor: Colors.white,
                  // side: const BorderSide(color: Colors.teal),
                  textStyle: const TextStyle(color: Colors.white, fontSize: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 15)),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.red),
              ),
              filled: true,
              fillColor: Color.fromARGB(255, 236, 244, 243),
            ),
            listTileTheme: const ListTileThemeData(
                textColor: Color(0xff576F72), style: ListTileStyle.drawer),
            textTheme: const TextTheme(
                // displayLarge:
                //     TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                // titleLarge: TextStyle(fontWeight: FontWeight.bold),
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
        builder: EasyLoading.init(),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 3000)
    ..indicatorType = EasyLoadingIndicatorType.pouringHourGlass
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 35.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.teal
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.teal.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true
    ..fontSize = 16.0
    ..errorWidget = Column(
      children: const [
        Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 35.0,
        ),
        Text(
          'Error',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        )
      ],
    )
    ..customAnimation = CustomAnimation();
  // ..indicatorWidget = Text('Where ererer');
}
