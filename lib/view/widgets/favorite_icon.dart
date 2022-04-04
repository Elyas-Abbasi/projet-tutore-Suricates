import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/colors.dart';

class FavoriteIcon extends StatefulWidget {
  final Function(bool) onChanged;
  final bool isChecked;

  const FavoriteIcon(
      {Key? key, required this.onChanged, required this.isChecked})
      : super(key: key);

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool _isChecked = false;
  SvgPicture _icon = SvgPicture.asset(
    "images/favorite_outlined.svg",
    color: ColorsSuricates.blue,
    width: 32,
    height: 32,
  );

  void toggleFavorite() {
    setState(() {
      _isChecked = !_isChecked;
      if (_isChecked) {
        _icon = SvgPicture.asset(
          "images/favorite_filled.svg",
          color: ColorsSuricates.orange,
          width: 32,
          height: 32,
        );
      } else {
        _icon = SvgPicture.asset(
          "images/favorite_outlined.svg",
          color: ColorsSuricates.blue,
          width: 32,
          height: 32,
        );
      }
      widget.onChanged(_isChecked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => toggleFavorite(),
        icon: _icon);
  }
}
