import 'package:firebase_storage/firebase_storage.dart';

FirebaseStorage storage = FirebaseStorage.instance;

class GetImage {

  static Future<String> get(String id, String path) async {

    Reference ref = storage.ref(path).child(id);
    String url = "";

    await ref.getDownloadURL().then((downloadUrl) {
      url = downloadUrl.toString();
    }).catchError((e) {
      url = 'Un problème est survenu: ${e.error}';
    });

    return url;
  }

}
