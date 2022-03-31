import 'package:suricates_app/view/navigations/bottom_navigation_bar.dart';
import 'package:suricates_app/view/navigations/burger_menu.dart';
import 'package:suricates_app/view/pages/conversation_page.dart';
import 'package:suricates_app/view/pages/connection_page.dart';
import 'package:suricates_app/view/navigations/appbar.dart';
import 'package:suricates_app/view/pages/add_ad_page.dart';
import 'package:suricates_app/view/pages/profil_page.dart';
import 'package:suricates_app/view/pages/deals_page.dart';
import 'package:suricates_app/globals.dart' as globals;
import 'package:suricates_app/model/current_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:suricates_app/strings.dart';
import 'package:flutter/material.dart';
import 'connection_page.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class MainPage extends StatefulWidget {
  final CurrentUser? currentUser;

  const MainPage({Key? key, this.currentUser}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = globals.selectedIndex;

  @override
  Widget build(BuildContext context) {
    print("MAIN PAGE : " + globals.currentUser.toString());

    void updateSelected(int select) {
      setState(() {
        selectedIndex = select;
      });
    }

    List<PreferredSizeWidget> _appBar = [
      AppBarWidget(title: TextsSuricates.deals, burgerMenu: true),
      AppBarWidget(title: TextsSuricates.messages, burgerMenu: true),
      AppBarWidget(title: TextsSuricates.myProfile, burgerMenu: true)
    ];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _appBar.elementAt(selectedIndex),
        body: IndexedStack(
          children: <Widget>[
            const DealsPage(),
            globals.currentUser == null
                ? ConnectionPage(hasAccount: true, connectionPage: false)
                : const ConversationPage(),
            globals.currentUser == null
                ? ConnectionPage(hasAccount: true, connectionPage: false)
                : ProfilPage(user: globals.currentUser!, isAppBar: false)
          ],
          index: selectedIndex,
        ),
        endDrawer: const MyBurgerMenu(),
        bottomNavigationBar: NavBar(
          select: selectedIndex,
          onChanged: updateSelected,
        ),
        floatingActionButton: selectedIndex == 0
            ? FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  if (globals.currentUser != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddAdPage()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConnectionPage(
                                hasAccount: true,
                                connectionPage: true,
                                route: const AddAdPage(),
                                passByMainPage: true)));
                  }
                },
              )
            : null);
  }
}
