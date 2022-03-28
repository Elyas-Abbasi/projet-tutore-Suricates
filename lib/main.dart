import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:suricates_app/services/authentification/auth_service.dart';
import 'package:suricates_app/services/authentification/onboarding.dart';
import 'package:suricates_app/view/pages/edit_profile_page.dart';
import 'package:suricates_app/view/pages/main_page.dart';
import 'package:suricates_app/view/widgets/onboarding.dart';
import 'colors_suricates.dart';
import 'model/current_user.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background message : ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  AuthService().getUser();

}

class MyApp extends StatelessWidget {
  final CurrentUser? currentUser;
  final bool? hasFinishRegister;
  
  const MyApp({Key? key, this.currentUser, this.hasFinishRegister}) : super(key: key);
  get initScreen => null;
  @override
  Widget build(BuildContext context) {
  Widget navigation = MainPage(currentUser: currentUser);


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Suricates',
      theme: ThemeData(
          fontFamily: 'Poppins',
          backgroundColor: ColorsSuricates.backgroundPrimary,
          primaryColor: ColorsSuricates.blue,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: ColorsSuricates.orange)),
      home: FutureBuilder(
        future: OnBoarding().checkFirstSeen(),
        builder: (context, snap) {
          if(snap.hasData) {
            switch (snap.data) {
              case "HomePage" : navigation = MainPage(currentUser: currentUser);
                break;
                case "onBoarding": navigation = const MyOnboarding();
                break;
              default: navigation =  MainPage(currentUser: currentUser);
            }
            if (hasFinishRegister == false) {
              navigation = EditProfilePage(isNewUser: true, currentUser: currentUser!);
            }
            return navigation;
          } else {
          if (hasFinishRegister == false) {
            navigation = EditProfilePage(isNewUser: true, currentUser: currentUser!);
          }
          return navigation;
        }
        } 
        ),
      // initialRoute: '/',
      // routes: {
      //   // When navigating to the "/" route, build the FirstScreen widget.
      //   '/': (context) => MainPage(currentUser: currentUser),
      //   // When navigating to the "/second" route, build the SecondScreen widget.
      //   '/chat': (context) => ChatPage(otherUID: globals.otherUID!),
      // },
    );
  }
}
