import 'package:suricates_app/model/global_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CurrentUser extends GlobalUser {
  late String email;

  CurrentUser(uid, pseudo, this.email) : super(uid, pseudo);

  static CurrentUser? fromUserFirebase(User user) {
    return null;
  }
}
