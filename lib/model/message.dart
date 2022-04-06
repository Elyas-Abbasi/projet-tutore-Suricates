import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderUID;
  final String receiverUID;
  final Timestamp time;
  final String content;
  final MessageType type;

  Message(
    this.senderUID,
    this.receiverUID,
    this.time,
    this.content,
    this.type,
  );

  Map<String, dynamic> toHashMap() {
    return {
      'content': content,
      'senderUID': senderUID,
      'receiverUID': receiverUID,
      'type': type == MessageType.message ? "message" : "proposal",
      'time': time
    };
  }
}

enum MessageType {
  message,
  proposal,
}
