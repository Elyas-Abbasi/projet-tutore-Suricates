import 'package:cloud_firestore/cloud_firestore.dart';
import '/services/messaging/chat_service.dart';
import '../widgets/bottom_message_bar.dart';
import '../widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/chat_message.dart';
import '../navigations/appbar.dart';
import '/model/message.dart';

class ChatPage extends StatefulWidget {
  final ChatService chatParams;

  const ChatPage({
    Key? key,
    required this.chatParams,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _ChatPageState createState() => _ChatPageState(chatParams);
}

class _ChatPageState extends State<ChatPage> {
  final ChatService chat;

  _ChatPageState(this.chat);

  final TextEditingController messageController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  bool loading = false;
  bool isFirstMessage = false;

  @override
  void initState() {
    super.initState();
    chat.onRead();
  }

  void sendMessage() {
    if (messageController.text.trim() != '') {
      FocusManager.instance.primaryFocus?.unfocus();
      chat.sendMessage(
        isFirstMessage,
        Message(
          chat.currentUser.uid,
          chat.peerUser.uid,
          Timestamp.now(),
          messageController.text,
          MessageType.message,
        ),
      );
      isFirstMessage = false;
      messageController.clear();
      listScrollController.animateTo(
        listScrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: '${chat.peerUser.pseudo} - ${chat.ad.title}',
        icon: const Icon(Icons.arrow_back_ios_new),
        function: () => Navigator.pop(context),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: chat.getMessages(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: LoadingWidget(),
                      );
                    }
                    if (snapshot.hasData && snapshot.data.exists) {
                      isFirstMessage = false;
                      chat.onRead();
                      List messages =
                          snapshot.data['messages'].reversed.toList();

                      return ListView.builder(
                        reverse: true,
                        controller: listScrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          var message = messages[index];

                          return ChatMessage(
                            messageText: message['content'],
                            time: message['time'],
                            userID: message['senderUID'],
                          );
                        },
                      );
                    } else {
                      isFirstMessage = true;
                      return const Center(
                        child: Text("Démarrer une conversation."),
                      );
                    }
                  },
                ),
              ),
              BottomMessageBar(
                chatParams: chat,
                messageController: messageController,
                sendFunction: sendMessage,
              )
            ],
          ),
          Visibility(
            visible: loading,
            child: const LoadingWidget(),
          )
        ],
      ),
    );
  }
}
