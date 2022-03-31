import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_stockage/post_image.dart';
import '/globals.dart' as globals;
import '/model/ad_type.dart';
import '/model/ad.dart';
import 'dart:io';

class PublishNewAd {
  final databaseReference = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future publishAdOnFirestore(Ad ad, File? _image) async {

    CollectionReference trocs = databaseReference.collection('trocs');
    String type;
    ad.type == AdType.search ? type = "search" : type = "exchange";
    List<dynamic> result = [];

    ad.userID = globals.currentUser!.uid;
    ad.userPseudo = globals.currentUser!.pseudo;
    ad.url = "";

    result.add(ad);

    await trocs.add({
      "title": ad.title,
      "subtitle": ad.description,
      "type": type,
      "city": ad.city,
      "userID": ad.userID,
      "userPseudo": ad.userPseudo,
      "url": ""
    }).then((value) async {

      result.add(value.id);
      result.add(await PostImage().postImage(value.id, 'ad_images', _image));

    }).catchError((error) {
      result.add(error);
    });
    return result;
  }

  void clearCache() {
    databaseReference.terminate();
    databaseReference.clearPersistence();
  }
}
