import 'package:cloud_firestore/cloud_firestore.dart';
import '/model/current_user.dart';
import '/model/global_user.dart';
import '/model/message.dart';
import '/model/ad.dart';

class ChatService {
  final CurrentUser currentUser;
  final GlobalUser peerUser;
  final Ad ad;

  ChatService(
    this.currentUser,
    this.peerUser,
    this.ad,
  );

  String getChatGroupId() {
    if (currentUser.uid.hashCode <= peerUser.uid.hashCode) {
      return '${ad.id}-${currentUser.uid}-${peerUser.uid}';
    } else {
      return '${ad.id}-${peerUser.uid}-${currentUser.uid}';
    }
  }

  Stream getMessages() {
    return FirebaseFirestore.instance
        .collection('messages')
        .doc(getChatGroupId())
        .snapshots();
  }

  onRead() {
    var conversationCurrentDoc = FirebaseFirestore.instance
        .collection('conversations')
        .doc("${ad.id}-${currentUser.uid}");

    conversationCurrentDoc.update({'receiverRead': true});
  }

  void sendMessage(bool isFirstMessage, Message message) {
    var documentReference =
        FirebaseFirestore.instance.collection('messages').doc(getChatGroupId());
    var conversationCurrentDoc = FirebaseFirestore.instance
        .collection('conversations')
        .doc("${ad.id}-${currentUser.uid}");
    var conversationPeerDoc = FirebaseFirestore.instance
        .collection('conversations')
        .doc("${ad.id}-${peerUser.uid}");

    FirebaseFirestore.instance.runTransaction((transaction) async {
      if (isFirstMessage == true) {
        // upload new message in conv
        transaction.set(documentReference, {
          'messages': FieldValue.arrayUnion([message.toHashMap()]),
        });

        // create currentUID conversation if first message
        transaction.set(conversationCurrentDoc, {
          'lastMessage': message.content,
          'currentUID': currentUser.uid,
          'peerUID': peerUser.uid,
          'peerPseudo': peerUser.pseudo,
          'receiver': peerUser.uid,
          'receiverRead': true,
          'time': message.time,
          'adTitle': ad.title,
          'adId': ad.id
        });

        // create peerUID conversation if first message
        transaction.set(conversationPeerDoc, {
          'lastMessage': message.content,
          'currentUID': peerUser.uid,
          'peerUID': currentUser.uid,
          'peerPseudo': currentUser.pseudo,
          'receiver': peerUser.uid,
          'receiverRead': false,
          'time': message.time,
          'adTitle': ad.title,
          'adId': ad.id
        });
      } else {
        // upload new message in conv
        transaction.update(documentReference, {
          'messages': FieldValue.arrayUnion([message.toHashMap()]),
        });

        // update currentUID conversation if first message
        transaction.update(conversationCurrentDoc, {
          'lastMessage': message.content,
          'currentUID': currentUser.uid,
          'peerUID': peerUser.uid,
          'peerPseudo': peerUser.pseudo,
          'receiver': peerUser.uid,
          'receiverRead': true,
          'time': message.time,
          'adTitle': ad.title,
          'adId': ad.id
        });

        // update peerUID conversation if first message
        transaction.update(conversationPeerDoc, {
          'lastMessage': message.content,
          'currentUID': peerUser.uid,
          'peerUID': currentUser.uid,
          'peerPseudo': currentUser.pseudo,
          'receiver': peerUser.uid,
          'receiverRead': false,
          'time': message.time,
          'adTitle': ad.title,
          'adId': ad.id
        });
      }
    });
  }
}
