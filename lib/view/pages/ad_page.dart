import '/services/messaging/chat_service.dart';
import '../navigations/burger_menu.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widgets/favorite_icon.dart';
import '../widgets/filled_button.dart';
import '../navigations/appbar.dart';
import '/globals.dart' as globals;
import '/model/global_user.dart';
import 'connection_page.dart';
import '/model/ad_type.dart';
import 'profil_page.dart';
import 'chat_page.dart';
import '/model/ad.dart';
import '/strings.dart';
import '/colors.dart';

class AdPage extends StatefulWidget {
  final Ad ad;
  final String url;
  final bool isNetwork;

  const AdPage(
      {Key? key, required this.ad, required this.url, required this.isNetwork})
      : super(key: key);

  @override
  _AdPageState createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: TextsSuricates.deal,
          burgerMenu: true,
          icon: const Icon(Icons.arrow_back_ios_new),
          function: () => Navigator.pop(context)),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.only(bottom: 4),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
            child: Column(children: [
              Container(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Hero(
                      tag: widget.ad.id,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: widget.isNetwork == true
                              ? Image.network(
                                  widget.url,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  widget.url,
                                  fit: BoxFit.cover,
                                )),
                    ),
                  )),
              Text(widget.ad.title,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorsSuricates.blue)),
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(20, 4, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: widget.ad.type == AdType.search
                                        ? TextsSuricates.searchedBy
                                        : TextsSuricates.proposedBy,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsSuricates.blue),
                                    children: <TextSpan>[
                                  TextSpan(
                                      text: widget.ad.userPseudo,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsSuricates.orange,
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilPage(
                                                          user: GlobalUser(
                                                              widget.ad.userID,
                                                              widget.ad
                                                                  .userPseudo),
                                                          isAppBar: true)));
                                        }),
                                ])),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: FavoriteIcon(
                          onChanged: (isChecked) {},
                          isChecked: true,
                        ),
                      ),
                    ],
                  )),
            ]),
          ),
        ),
        Expanded(
            child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        TextsSuricates.description,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorsSuricates.blue),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 32,
                        child: Text(
                          widget.ad.description,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        TextsSuricates.place,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.ad.city),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    child: FilledButton(
                        text: TextsSuricates.buttonSearch,
                        backgroundColor: ColorsSuricates.orange,
                        onPressed: () {
                          globals.otherUID = widget.ad.userID;
                          globals.selectedIndex = 1;
                          if (globals.currentUser == null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConnectionPage(
                                        hasAccount: true,
                                        connectionPage: true,
                                        route:
                                            globals.currentUser != null ? ChatPage(chatParams: ChatService(globals.currentUser!, GlobalUser(widget.ad.userID, widget.ad.userPseudo), widget.ad)) : Container(),
                                        passByMainPage: true)));
                          } else {
                            Navigator.pushNamed(context, "/");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChatPage(chatParams: ChatService(globals.currentUser!, GlobalUser(widget.ad.userID, widget.ad.userPseudo), widget.ad))));
                          }
                        },
                        enabled: true),
                    visible: globals.currentUser != null &&
                            widget.ad.userID == globals.currentUser!.uid
                        ? false
                        : true,
                  ),
                ],
              ),
            ),
          ],
        ))
      ]),
      endDrawer: const MyBurgerMenu(),
    );
  }
}
