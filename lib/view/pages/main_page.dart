import '../navigations/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../navigations/burger_menu.dart';
import 'package:flutter/material.dart';
import '../navigations/appbar.dart';
import '/globals.dart' as globals;
import '/model/current_user.dart';
import 'conversation_page.dart';
import 'connection_page.dart';
import 'add_ad_page.dart';
import 'profil_page.dart';
import 'deals_page.dart';
import '/strings.dart';

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

    void updateSelected(int select) => setState(() => selectedIndex = select);

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
