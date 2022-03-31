import 'package:suricates_app/colors_suricates.dart';
import 'package:flutter/material.dart';

class InfoBar extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;

  const InfoBar(
      {Key? key,
      required this.text,
      this.textColor,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
          child: Container(
              child: Text(
                text,
                style: TextStyle(color: textColor ?? ColorsSuricates.blue),
                textAlign: TextAlign.center,
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12)),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: backgroundColor ?? ColorsSuricates.backgroundBlue,
        ),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 4));
  }
}
