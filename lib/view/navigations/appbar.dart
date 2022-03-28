import 'dart:io';

import 'package:flutter/material.dart';
import 'package:suricates_app/colors_suricates.dart';

class AppBarWidget extends PreferredSize {
  final String title;
  bool? burgerMenu;
  final Icon? icon;
  final Color? backgroundColor;
  final Function()? function;

  AppBarWidget({
    Key? key,
    required this.title,
    this.burgerMenu,
    this.icon,
    this.backgroundColor,
    this.function,
  }) : super(
            key: key, preferredSize: const Size.fromHeight(0), child: AppBar());

  @override
  Size get preferredSize => const Size.fromHeight(130);

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorsSuricates.white,
        ),
        height: preferredSize.height,
        child: CustomPaint(
          painter: HeaderPaint(),
          child: Padding(
            padding: Platform.isAndroid
                ? const EdgeInsets.only(top: 15.0)
                : EdgeInsets.zero,
            child: AppBar(
              elevation: 0,
              centerTitle: true,
              leading: Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: IconButton(
                    padding: const EdgeInsets.only(bottom: 0, right: 0),
                    icon: icon ?? Container(),
                    onPressed: () => function!(),
                  )),
              title: Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  )),
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                burgerMenu != null
                    ? Container(
                        padding: const EdgeInsets.only(bottom: 16, right: 4),
                        child: IconButton(
                          padding: const EdgeInsets.only(bottom: 0, right: 0),
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          onPressed: () => Scaffold.of(context).openEndDrawer(),
                        ))
                    : Container()
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorsSuricates.white,
        ),
        height: preferredSize.height,
        child: CustomPaint(
          painter: HeaderPaint(),
          child: Stack(children: [
            Positioned(
              bottom: 0,
              left: 10,
              child: Image.asset(
                "images/suricate.png",
                height: 84,
                color: backgroundColor ?? ColorsSuricates.white,
              ),
            ),
            Padding(
              padding: Platform.isAndroid
                  ? const EdgeInsets.only(top: 15.0)
                  : EdgeInsets.zero,
              child: AppBar(
                elevation: 0,
                centerTitle: true,
                title: Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    )),
                backgroundColor: Colors.transparent,
                actions: <Widget>[
                  burgerMenu != null
                      ? Container(
                          padding: const EdgeInsets.only(bottom: 16, right: 4),
                          child: IconButton(
                            padding: const EdgeInsets.only(bottom: 0, right: 0),
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                            onPressed: () =>
                                Scaffold.of(context).openEndDrawer(),
                          ))
                      : Container()
                ],
              ),
            ),
          ]),
        ),
      );
    }
  }
}

class HeaderPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = ColorsSuricates.blue;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 20);
    path.lineTo(0, size.height);
    path.close();
    // canvas.drawShadow(path, Colors.grey, 5, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
