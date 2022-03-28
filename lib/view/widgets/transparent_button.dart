import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suricates_app/colors_suricates.dart';

class TransparentButton extends StatelessWidget {
  final String text;
  final Color? color;
  final double? textSize;
  final Function() onPressed;

  const TransparentButton(
      {Key? key,
      required this.text,
      this.color,
      required this.onPressed,
      this.textSize = 17})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text,
          style: TextStyle(
            color: color ?? ColorsSuricates.blue,
            fontSize: textSize,
          )),
      style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.fromLTRB(25, 12, 25, 12)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          overlayColor: color == null
              ? MaterialStateProperty.all(ColorsSuricates.blue.withOpacity(0.3))
              : MaterialStateProperty.all(color!.withOpacity(0.3))),
      onPressed: onPressed,
    );
  }
}
