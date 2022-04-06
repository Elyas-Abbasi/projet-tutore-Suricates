import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

FirebaseStorage storage = FirebaseStorage.instance;

class PostImage {
  Future<String> postImage(String id, String storagePath, File? _image) async {
    Reference storageRef = storage.ref(storagePath).child(id);
    UploadTask uploadTask = storageRef.putFile(_image!);

    String result = "";

    await uploadTask.whenComplete(() {}).catchError((error) {
      result = error.error;
    });

    await uploadTask.snapshot.ref.getDownloadURL().then((downloadUrl) {
      result = downloadUrl.toString();
    }).catchError((e) {
      result = 'Un problème est survenu: ${e.error}';
    });

    return result;
  }
}
