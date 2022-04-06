import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      return "HomePage";
    } else {
      await prefs.setBool('seen', true);
      return "onBoarding";
    }
  }
}
