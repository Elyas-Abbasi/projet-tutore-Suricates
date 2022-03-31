import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {

  static void initialize() {
    //ios
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen((event) {
      print("A new onMessage has been published !");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("A new onMessageOpenedApp has been published !");
    });
  }

  static Future<String?> getToken() async {
    return FirebaseMessaging.instance.getToken();
  }


}