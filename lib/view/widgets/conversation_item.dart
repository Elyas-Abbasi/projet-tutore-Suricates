import 'package:flutter/material.dart';
import '/model/conversation.dart';
import '/colors.dart';

class ConversationItem extends StatefulWidget {
  // Instance d'une annonce
  final Conversation conv;
  final String urlAd;
  final String urlUser;
  final Function() onTapItem;
  final bool? isNetwork;
  const ConversationItem(
      {Key? key,
      required this.conv,
      required this.urlAd,
      required this.urlUser,
      required this.onTapItem,
      this.isNetwork})
      : super(key: key);
  @override
  _ConversationItem createState() => _ConversationItem();
}

class _ConversationItem extends State<ConversationItem> {
  @override
  Widget build(BuildContext context) {
    // Chemin icône position
    String iconPosition = "images/icon_position.svg";

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: EdgeInsets.zero,
        child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
                onTap: () {
                  setState(() {
                    widget.onTapItem();
                  });
                },
                child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: !widget.urlAd.contains('https')
                                  ? FadeInImage.assetNetwork(
                                      placeholder: 'images/unknown.jpg',
                                      fadeInDuration:
                                          const Duration(milliseconds: 200),
                                      image: widget.urlAd,
                                      height: 35,
                                      width: 35,
                                      fit: BoxFit.cover)
                                  : Image.network(widget.urlAd,
                                      height: 35, width: 35, fit: BoxFit.cover),
                            ),
                            Positioned(
                              left: 25,
                              top: 25,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: widget.urlUser.contains("https")
                                    ? Image.network(widget.urlUser,
                                        height: 35,
                                        width: 35,
                                        fit: BoxFit.cover)
                                    : FadeInImage.assetNetwork(
                                        placeholder: 'images/noProfilePicture.jpg',
                                        fadeInDuration:
                                            const Duration(milliseconds: 200),
                                        image: widget.urlAd,
                                        height: 35,
                                        width: 35,
                                        fit: BoxFit.cover)
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.conv.peerPseudo +
                                    " - " +
                                    widget.conv.adTitle,
                                style: myStyle(18, true),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Visibility(
                                    visible: !widget.conv.read,
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        width: 10.0,
                                        height: 10.0,
                                        decoration: const BoxDecoration(
                                          color: Colors.orange,
                                          shape: BoxShape.circle,
                                        )),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.conv.lastMessage,
                                      style: myStyle(14, !widget.conv.read),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(Icons.arrow_forward_ios,
                                color: ColorsSuricates.blue),
                          ],
                        ),
                      ],
                    )))));
  }

  // Style du texte de l'item
  TextStyle myStyle(double size, [bool isBold = false]) {
    TextStyle ts;
    isBold
        ? ts = TextStyle(
            color: ColorsSuricates.blue,
            fontSize: size,
            fontWeight: FontWeight.bold)
        : ts = TextStyle(color: ColorsSuricates.blue, fontSize: size);
    return ts;
  }
}
