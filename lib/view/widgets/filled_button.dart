import 'package:flutter/material.dart';
import '/colors.dart';

class FilledButton extends StatefulWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? backgroundColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final Function() onPressed;
  final bool enabled;

  const FilledButton(
      {Key? key,
      required this.text,
      this.textAlign,
      this.backgroundColor,
      this.textColor,
      this.fontWeight,
      required this.onPressed,
      required this.enabled})
      : super(key: key);

  @override
  _FilledButtonState createState() => _FilledButtonState();
}

class _FilledButtonState extends State<FilledButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        widget.text,
        style: TextStyle(
            color: widget.textColor ?? Colors.white,
            fontSize: 18,
            fontWeight: widget.fontWeight ?? FontWeight.bold),
        textAlign: widget.textAlign ?? TextAlign.left,
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        shadowColor: Colors.transparent,
        primary: widget.backgroundColor ?? ColorsSuricates.blue,
        padding: const EdgeInsets.fromLTRB(40, 12, 40, 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: widget.enabled ? widget.onPressed : null,
    );
  }
}
