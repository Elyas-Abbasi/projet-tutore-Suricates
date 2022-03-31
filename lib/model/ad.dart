import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import "ad_type.dart";

class Ad {
  late String id;
  late String title;
  late String description;
  late String city;
  late AdType? type;
  late String url;
  late String userID;
  late String userPseudo;
  late DateTime date;

  Ad(this.id, this.title, this.description, this.city, this.type);

  Ad.fromSnapShot(DocumentSnapshot document){
      id = document.id;
      title = document['title'];
      description = document['subtitle'];
      city = document['city'];
      url = document['url'];
      userID = document['userID'];
      userPseudo = document['userPseudo'];
      type = EnumToString.fromString(AdType.values, document['type']);
  }

}


