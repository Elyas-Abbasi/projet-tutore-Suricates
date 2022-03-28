import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:suricates_app/colors_suricates.dart';
import 'package:suricates_app/strings.dart';

import '../../colors_suricates.dart';

class NavBar extends StatefulWidget {
  final Function(int) onChanged;
  final int select;

  const NavBar({Key? key, required this.onChanged, required this.select})
      : super(key: key);

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    widget.onChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedFontSize: 10,
      selectedFontSize: 10,
      showSelectedLabels: true,
      selectedItemColor: ColorsSuricates.orange,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.white,
      backgroundColor: ColorsSuricates.blue,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.search, size: 32,),
          label: TextsSuricates.deals,
          activeIcon: Icon(Icons.search, size: 32,),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "images/chat.svg",
            width: 30,
            height: 30,
          ),
          label: TextsSuricates.messages,
          activeIcon: SvgPicture.asset(
            "images/chat.svg",
            color: ColorsSuricates.orange,
            width: 30,
            height: 30,
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "images/user.svg",
            width: 30,
            height: 30,
          ),
          label: TextsSuricates.myProfile,
          activeIcon: SvgPicture.asset(
            "images/user.svg",
            color: ColorsSuricates.orange,
            width: 30,
            height: 30,
          ),
        ),
      ],
      currentIndex: widget.select,
      onTap: _onItemTapped,
    );
  }
}
