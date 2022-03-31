import 'package:suricates_app/services/firebase_stockage/get_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilPictureMessage extends StatefulWidget {
  final String userID;
  final bool isCurrentUser;

  const ProfilPictureMessage(
      {Key? key, required this.userID, required this.isCurrentUser})
      : super(key: key);

  @override
  _ProfilPictureMessage createState() => _ProfilPictureMessage();
}

class _ProfilPictureMessage extends State<ProfilPictureMessage> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isCurrentUser,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(150)),
            child: FutureBuilder(
                future: GetImage.get(widget.userID, "profile_pictures"),
                builder: (context, snap) {
                  if (snap.data == null) {
                    return Image.asset(
                      "images/noProfilePicture.jpg",
                      fit: BoxFit.cover,
                      width: 36,
                      height: 36,
                    );
                  } else {
                    return Image.network(
                      snap.data.toString(),
                      fit: BoxFit.cover,
                      width: 36,
                      height: 36,
                    );
                  }
                }),
          )),
    );
  }
}
