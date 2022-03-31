import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {

  static void initialize() {
    //ios
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen((event) {
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    });
  }

  static Future<String?> getToken() async {
    return FirebaseMessaging.instance.getToken();
  }


}