import 'package:flutter/material.dart';
import '/colors.dart';

// ignore: must_be_immutable
class SwitchTabBar extends StatefulWidget {
  final Function(int) selectItem;
  int position;
  final String title1;
  final String title2;
  final double? size;
  final double marginLeft;
  final double marginRight;

  SwitchTabBar(
      {Key? key,
      required this.selectItem,
      required this.title1,
      required this.title2,
      required this.position,
      this.size,
      this.marginLeft = 16,
      this.marginRight = 16})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SwitchTabBarState();
}

class _SwitchTabBarState extends State<SwitchTabBar> {
  void changeItemSelection(int itemSelected) {
    if (widget.position != itemSelected) {
      setState(() {
        widget.position = itemSelected;
        widget.selectItem(itemSelected);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin:
          EdgeInsets.only(left: widget.marginLeft, right: widget.marginRight),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: ColorsSuricates.blue,
        elevation: 4.0,
        child: Container(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => changeItemSelection(0),
                  child: SwitchTabBarItem(
                      enable: (widget.position == 0),
                      itemName: widget.title1,
                      textSize: widget.size ?? 16.0),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => changeItemSelection(1),
                  child: SwitchTabBarItem(
                      enable: (widget.position == 1),
                      itemName: widget.title2,
                      textSize: widget.size ?? 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SwitchTabBarItem extends StatefulWidget {
  final bool enable;
  final String itemName;
  final double textSize;
  const SwitchTabBarItem(
      {Key? key,
      this.enable = true,
      required this.itemName,
      required this.textSize})
      : super(key: key);

  @override
  State<SwitchTabBarItem> createState() => _SwitchTabBarItemState();
}

class _SwitchTabBarItemState extends State<SwitchTabBarItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.enable) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: ColorsSuricates.white,
            borderRadius: BorderRadius.all(Radius.circular(17))),
        child: Text(
          widget.itemName,
          style:
              TextStyle(color: ColorsSuricates.blue, fontSize: widget.textSize),
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: ColorsSuricates.blue,
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: Text(
        widget.itemName,
        style:
            TextStyle(color: ColorsSuricates.white, fontSize: widget.textSize),
        textAlign: TextAlign.center,
        maxLines: 1,
      ),
    );
  }
}
