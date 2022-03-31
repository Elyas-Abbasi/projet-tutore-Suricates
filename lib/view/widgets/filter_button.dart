import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '/colors.dart';

class FilterButton extends StatefulWidget {
  final Function() onPressed;
  final bool enabled;

  const FilterButton({
    Key? key,
    required this.onPressed,
    required this.enabled,
  }) : super(key: key);

  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorsSuricates.orange,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            "images/icon_filter.svg",
            width: 28,
            height: 28,
          ),
        ),
      ),
    );
  }
}
