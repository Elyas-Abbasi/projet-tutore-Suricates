import '/services/authentification/auth_service.dart';
import '../pages/connection_page.dart';
import 'package:flutter/material.dart';
import '/globals.dart' as globals;
import '../pages/profil_page.dart';
import '/strings.dart';
import '/colors.dart';

class MyBurgerMenu extends StatefulWidget {
  const MyBurgerMenu({Key? key}) : super(key: key);

  @override
  State<MyBurgerMenu> createState() => _MyBurgerMenuState();
}

class _MyBurgerMenuState extends State<MyBurgerMenu> {
  @override
  Widget build(BuildContext context) {
    String email;
    String pseudo;
    bool isConnected;
    if (globals.currentUser != null) {
      email = globals.currentUser!.email;
      pseudo = globals.currentUser!.pseudo;
      isConnected = true;
    } else {
      email = "";
      pseudo = "";
      isConnected = false;
    }

    return Drawer(
        child: Container(
            color: ColorsSuricates.blue,
            child: ListView(padding: EdgeInsets.zero, children: [
              DrawerHeader(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.account_circle,
                              color: ColorsSuricates.white,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: const Text(
                                TextsSuricates.appName,
                                style: TextStyle(color: ColorsSuricates.white),
                              ),
                            )
                          ]),
                    ),
                    Visibility(
                      child: Row(children: [
                        Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: Text(
                            email,
                            style:
                                const TextStyle(color: ColorsSuricates.white),
                          ),
                          padding: const EdgeInsets.only(top: 10),
                        ),
                      ]),
                      visible: isConnected,
                    ),
                    Visibility(
                      child: Row(children: [
                        Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: Text(
                            pseudo,
                            style:
                                const TextStyle(color: ColorsSuricates.white),
                          ),
                          padding: const EdgeInsets.only(top: 10),
                        )
                      ]),
                      visible: isConnected,
                    )
                  ])),
              Visibility(
                visible: isConnected,
                child: const Divider(
                  color: ColorsSuricates.white,
                  thickness: 1,
                  indent: 30,
                  endIndent: 30,
                ),
              ),
              Visibility(
                visible: isConnected,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilPage(
                                    user: globals.currentUser!,
                                    isAppBar: true)));
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: const Icon(Icons.person,
                                  color: ColorsSuricates.white)),
                          const Text(
                            TextsSuricates.myProfile,
                            style: TextStyle(color: ColorsSuricates.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isConnected,
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: const Icon(Icons.favorite,
                                  color: ColorsSuricates.white)),
                          const Text(
                            TextsSuricates.favorites,
                            style: TextStyle(color: ColorsSuricates.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isConnected,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        setState(() {
                          AuthService().signOut();
                          email = "";
                          pseudo = "";
                        });
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: const Icon(Icons.exit_to_app,
                                  color: ColorsSuricates.white)),
                          const Text(
                            TextsSuricates.logout,
                            style: TextStyle(color: ColorsSuricates.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !isConnected,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConnectionPage(
                                    hasAccount: true, connectionPage: true)));
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: const Icon(Icons.login,
                                  color: ColorsSuricates.white)),
                          const Text(
                            TextsSuricates.connection,
                            style: TextStyle(color: ColorsSuricates.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: ColorsSuricates.white,
                thickness: 1,
                indent: 30,
                endIndent: 30,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Icon(Icons.settings,
                                color: ColorsSuricates.white)),
                        const Text(
                          TextsSuricates.setting,
                          style: TextStyle(color: ColorsSuricates.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Icon(Icons.help_outline,
                                color: ColorsSuricates.white)),
                        const Text(
                          TextsSuricates.help,
                          style: TextStyle(color: ColorsSuricates.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ])));
  }
}
