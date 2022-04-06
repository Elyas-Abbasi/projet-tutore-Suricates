import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  final String peerUID;
  final String peerPseudo;
  final String adTitle;
  final String adUID;
  final String lastMessage;
  final bool read;
  final Timestamp time;

  Conversation(
    this.peerUID,
    this.peerPseudo,
    this.adTitle,
    this.adUID,
    this.lastMessage,
    this.time,
    this.read,
  );

  Map<String, dynamic> toHashMap() {
    return {
      'peerPseudo': peerPseudo,
      'peerUID': peerUID,
      'lastMessage': lastMessage,
      'adTitle': adTitle,
      'adUID': adUID,
      'time': time
    };
  }
}
