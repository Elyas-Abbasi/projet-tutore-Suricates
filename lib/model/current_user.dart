import 'package:firebase_auth/firebase_auth.dart';
import 'package:suricates_app/model/global_user.dart';

class CurrentUser extends GlobalUser {
  late String email;

  CurrentUser(uid, pseudo, this.email) : super(uid, pseudo);

  /*CurrentUser.id(String id) {
    super.uid = id;
  }*/

  static CurrentUser? fromUserFirebase(User user) {
    return null;
  }
}
