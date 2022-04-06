import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'profil_picture_message.dart';
import '/globals.dart' as globals;
import 'package:intl/intl.dart';
import '/colors.dart';

class ChatMessage extends StatefulWidget {
  final String messageText;
  final Timestamp time;
  final String userID;

  const ChatMessage({
    Key? key,
    required this.messageText,
    required this.time,
    required this.userID,
  }) : super(key: key);

  @override
  _ChatMessage createState() => _ChatMessage();
}

class _ChatMessage extends State<ChatMessage> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser =
        widget.userID == globals.currentUser!.uid ? true : false;
    DateTime dateTime = widget.time.toDate();
    String formatter = DateFormat('HH:mm').format(dateTime);

    Color messageColor = isCurrentUser
        ? ColorsSuricates.textBlue
        : ColorsSuricates.textOrange;

    Color messageBackground = isCurrentUser
        ? ColorsSuricates.backgroundBlue
        : ColorsSuricates.backgroundOrange;

    void setHourVisible() => setState(() => visible = !visible);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        ProfilPictureMessage(
          userID: widget.userID,
          isCurrentUser: !isCurrentUser,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 4,
          ),
          child: Column(
            crossAxisAlignment: isCurrentUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Material(
                color: messageBackground,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6,
                  ),
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    onTap: () => setHourVisible(),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      child: Text(
                        widget.messageText,
                        style: TextStyle(
                          color: messageColor,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 100),
                child: Column(
                  mainAxisAlignment: isCurrentUser
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 4,
                        right: 4,
                      ),
                      child: Text(
                        formatter,
                        style: TextStyle(
                          color: messageColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ProfilPictureMessage(
          userID: widget.userID,
          isCurrentUser: isCurrentUser,
        ),
      ],
    );
  }
}
