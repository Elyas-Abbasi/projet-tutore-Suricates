import 'package:flutter/material.dart';
import '/colors.dart';

class SuricatesTextField extends StatefulWidget {
  final Function(String) getText;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final String hint;
  final int? maxLines;
  final bool enable;

  const SuricatesTextField(
      {Key? key,
      this.textInputType = TextInputType.text,
      required this.hint,
      required this.getText,
      this.enable = true,
      this.controller,
      this.maxLines})
      : super(key: key);

  @override
  _SuricatesTextFieldState createState() => _SuricatesTextFieldState();
}

class _SuricatesTextFieldState extends State<SuricatesTextField> {
  void updateText(String text) => widget.getText(text);

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.only(right: 12, left: 12),
      decoration: const BoxDecoration(
          color: ColorsSuricates.backgroundSecondary,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: TextField(
        minLines: 1,
        controller: widget.controller,
        enabled: widget.enable,
        keyboardType: widget.textInputType,
        obscureText: widget.textInputType == TextInputType.visiblePassword
            ? true
            : false,
        textCapitalization:
            widget.textInputType == TextInputType.emailAddress ||
                    widget.textInputType == TextInputType.visiblePassword
                ? TextCapitalization.none
                : TextCapitalization.sentences,
        cursorColor: ColorsSuricates.orange,
        maxLines: widget.maxLines ?? 1,
        decoration:
            InputDecoration(hintText: widget.hint, border: InputBorder.none),
        onChanged: (text) => updateText(text),
      ),
    );
  }
}
