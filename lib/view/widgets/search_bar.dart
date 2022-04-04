import 'package:flutter/material.dart';
import '/colors.dart';

class MySearchBar extends StatefulWidget {
  final Function(String) getText;
  final TextInputType textInputType;
  final String hint;
  final bool? obscureText;

  const MySearchBar({Key? key, required this.getText, required this.textInputType, required this.hint, this.obscureText}) : super(key: key);

  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }
  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  void updateText(String text) => widget.getText(text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 12, left: 12),
      decoration: const BoxDecoration(
          color: ColorsSuricates.backgroundSecondary,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: TextField(
        focusNode: _focusNode,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: widget.textInputType,
        obscureText: widget.obscureText ?? false,
        cursorColor: ColorsSuricates.orange,
        decoration:
        InputDecoration(
            hintText: widget.hint,
            border: InputBorder.none,
            suffixIcon: IconButton(
              color: ColorsSuricates.blue,
              icon: const Icon(Icons.search),
              onPressed: () => _focusNode.unfocus(),
            ),
        ),
        onChanged: (text) => updateText(text),
      ),
    );


  }
}
