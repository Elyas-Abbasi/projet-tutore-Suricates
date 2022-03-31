import 'package:firebase_messaging/firebase_messaging.dart';
import 'services/authentification/auth_service.dart';
import 'services/authentification/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'view/pages/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'view/widgets/onboarding.dart';
import 'view/pages/main_page.dart';
import 'model/current_user.dart';
import 'colors.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
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

  const MyApp({Key? key, this.currentUser, this.hasFinishRegister})
      : super(key: key);

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
            .copyWith(secondary: ColorsSuricates.orange),
      ),
      home: FutureBuilder(
        future: OnBoarding().checkFirstSeen(),
        builder: (context, snap) {
          if (snap.hasData) {
            switch (snap.data) {
              case "HomePage":
                navigation = MainPage(currentUser: currentUser);
                break;
              case "onBoarding":
                navigation = const MyOnboarding();
                break;
              default:
                navigation = MainPage(currentUser: currentUser);
            }
            if (hasFinishRegister == false) {
              navigation = EditProfilePage(
                isNewUser: true,
                currentUser: currentUser!,
              );
            }
            return navigation;
          } else {
            if (hasFinishRegister == false) {
              navigation = EditProfilePage(
                isNewUser: true,
                currentUser: currentUser!,
              );
            }
            return navigation;
          }
        },
      ),
    );
  }
}
