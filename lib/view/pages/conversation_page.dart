import 'package:suricates_app/services/firebase_stockage/get_image.dart';
import 'package:suricates_app/services/messaging/chat_service.dart';
import 'package:suricates_app/view/widgets/conversation_item.dart';
import 'package:suricates_app/view/widgets/loading_widget.dart';
import 'package:suricates_app/view/pages/chat_page.dart';
import 'package:suricates_app/model/conversation.dart';
import 'package:suricates_app/globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suricates_app/model/global_user.dart';
import 'package:suricates_app/model/ad_type.dart';
import 'package:suricates_app/model/ad.dart';
import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({ Key? key }) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {

  Stream getConversation() {
  return FirebaseFirestore.instance.collection('conversations').where('currentUID', isEqualTo: globals.currentUser!.uid).orderBy('time').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: StreamBuilder(
        stream: getConversation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingWidget());
          }

          if (snapshot.hasData) {
            List conversations = snapshot.data!.docs;
            conversations = conversations.reversed.toList();
            // conversations.sort((a, b) {
            //   return b['time'] - a['time'];
            // });
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var conv = conversations[index];
                Conversation conversation = Conversation(conv['peerUID'], conv['peerPseudo'], conv['adTitle'], conv['adId'], conv['lastMessage'], conv['time'], conv['receiverRead']);
                return FutureBuilder(
                  future: GetImage.get(conversation.adUID, 'ad_images'),
                  builder: (context, snapAd) {
                    return FutureBuilder(
                      future: GetImage.get(conversation.peerUID, 'profile_pictures'),
                      builder: (context, snapUser) {

                        return ConversationItem(conv: conversation, urlAd: snapAd.data.toString(), urlUser: snapUser.data.toString(), onTapItem: () {
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChatPage(chatParams: ChatService(globals.currentUser!, GlobalUser(conversation.peerUID, conversation.peerPseudo), Ad(conversation.adUID, conversation.adTitle, "", "", AdType.exchange)))));
                        });
                      }
                      );
                    
                  }
                  );
                
                
              }
              );
          } else {
            return const Center(child: Text("Démarrez votre première discussion en proposant un produit ou en faisant une offre !", textAlign: TextAlign.center,));
          }
        },
      ),
    );
  }
}
