import 'package:firebase_auth/firebase_auth.dart';
import 'global_user.dart';

class CurrentUser extends GlobalUser {
  late String email;

  CurrentUser(
    uid,
    pseudo,
    this.email,
  ) : super(uid, pseudo);

  static CurrentUser? fromUserFirebase(User user) => null;
}
