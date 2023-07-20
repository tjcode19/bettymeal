import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> init() async {
    _fcm.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
      _handleNotificationClick(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
      _handleNotificationClick(message);
    });
  }

  void _handleNotificationClick(RemoteMessage message) {
    // Extract data from the message
    final notificationData = message.data;


    print(notificationData);

    // Perform the desired action
    // if (notificationData.containsKey('screen')) {
    //   final screen = notificationData['screen'];
    //   Navigator.of(context).pushNamed(screen);
    // } else {
    //   // Handle other types of notifications
    // }
  }
}
