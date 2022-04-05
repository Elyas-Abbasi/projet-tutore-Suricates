import '/services/firebase_stockage/get_image.dart';
import '/services/firestore/get_list_ad.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/switch_tabbar.dart';
import 'package:flutter/material.dart';
import '../navigations/appbar.dart';
import '/globals.dart' as globals;
import '/model/current_user.dart';
import '/model/global_user.dart';
import 'edit_profile_page.dart';
import '/strings.dart';
import '/colors.dart';

class ProfilPage extends StatefulWidget {
  final GlobalUser user;
  final bool isAppBar;

  const ProfilPage({required this.user, required this.isAppBar, key})
      : super(key: key);

  @override
  _ProfilPage createState() => _ProfilPage();
}

class _ProfilPage extends State<ProfilPage> {
  int _currentSelection = 0;

  changeItemSelection(int itemSelection) {
    if (_currentSelection != itemSelection) {
      setState(() {
        _currentSelection = itemSelection;
        _controller.animateToPage(_currentSelection,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      });
    }
  }

  final PageController _controller = PageController(
    initialPage: 0,
  );

  void selectList(int select) {
    if (_currentSelection != select) {
      setState(() => _currentSelection = select);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAppBar == true
          ? AppBarWidget(
              title: TextsSuricates.profile,
              icon: const Icon(Icons.arrow_back_ios_new),
              function: () => Navigator.pop(context),
          )
          : null,
      body: Column(children: [
        Material(
          color: ColorsSuricates.white,
          elevation: 4.0,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: SizedBox(
                      child: Wrap(children: [
                    SizedBox(
                        width: 120,
                        height: 120,
                        child: Material(
                          color: ColorsSuricates.lightGrey,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            child: FutureBuilder(
                                future: GetImage.get(
                                    widget.user.uid, "profile_pictures"),
                                builder: (context, snap) {
                                  if (snap.data == null) {
                                    return Image.asset(
                                      "images/noProfilePicture.jpg",
                                      fit: BoxFit.cover,
                                    );
                                  } else {
                                    return Image.network(
                                      snap.data.toString(),
                                      fit: BoxFit.cover,
                                    );
                                  }
                                }),
                          ),
                        )),
                  ])),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.user.pseudo,
                              style: const TextStyle(
                                  color: ColorsSuricates.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Container(
                                margin: const EdgeInsets.only(right: 8),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Material(
                                        color: ColorsSuricates.white,
                                        child: widget.user is CurrentUser
                                            ? InkWell(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: SvgPicture.asset(
                                                        "./images/settings.svg")),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditProfilePage(
                                                                  isNewUser:
                                                                      false,
                                                                  currentUser:
                                                                      globals
                                                                          .currentUser!)));
                                                },
                                              )
                                            : Container())))
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            widget.user is CurrentUser
                                ? (widget.user as CurrentUser).email
                                : "",
                            maxLines: 2,
                            style: const TextStyle(
                                color: ColorsSuricates.blue,
                                decoration: TextDecoration.underline,
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: SwitchTabBar(
                  selectItem: (selectItem) => selectList(selectItem),
                  title1: widget.user.uid == globals.currentUser?.uid
                      ? TextsSuricates.myDeals
                      : TextsSuricates.hisDeals,
                  title2: TextsSuricates.opinion,
                  position: _currentSelection,
                ))
          ]),
        ),
        Expanded(
          child: PageView(
            controller: _controller,
            onPageChanged: (int index) => changeItemSelection(index),
            children: [
              GetListAd(justUserAds: widget.user.uid),
            ],
          ),
        ),
      ]),
    );
  }
}
