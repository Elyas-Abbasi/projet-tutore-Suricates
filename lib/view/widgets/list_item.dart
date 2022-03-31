import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '/model/ad.dart';
import '/colors.dart';

class ListItemWidget extends StatefulWidget {
  // Instance d'une annonce
  final Ad ad;
  final String url;
  final Function() onTapItem;
  final bool? isNetwork;
  const ListItemWidget(
      {Key? key,
      required this.ad,
      required this.url,
      required this.onTapItem,
      this.isNetwork})
      : super(key: key);
  @override
  _ListItemWidgetState createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    // Chemin icône position
    String iconPosition = "images/icon_position.svg";

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.zero,
        child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
                onTap: () {
                  setState(() {
                    widget.onTapItem();
                  });
                },
                child: Container(
                    padding: const EdgeInsets.all(13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(
                          tag: widget.ad.id,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: widget.isNetwork == true
                                ? FadeInImage.assetNetwork(
                                  placeholder: 'images/unknown.jpg',
                                  fadeInDuration: const Duration(milliseconds: 200),
                                  image: widget.url,
                                  height: 70, width: 70, fit: BoxFit.cover)
                                : Image.asset(widget.url,
                                    height: 70, width: 70, fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.ad.title,
                                style: myStyle(18, true),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                widget.ad.description,
                                style: myStyle(14),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        iconPosition,
                                        width: 16,
                                        height: 16,
                                      ),
                                      Flexible(
                                        child: Container(
                                            padding:
                                                const EdgeInsets.only(left: 3),
                                            child: Text(
                                              widget.ad.city,
                                              style: myStyle(12),
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Icon(Icons.arrow_forward_ios,
                                color: ColorsSuricates.blue),
                          ],
                        ),
                      ],
                    )))));
  }

  // Style du texte de l'item
  TextStyle myStyle(double size, [bool isBold = false]) {
    TextStyle ts;
    isBold
        ? ts = TextStyle(
            color: ColorsSuricates.blue,
            fontSize: size,
            fontWeight: FontWeight.bold)
        : ts = TextStyle(color: ColorsSuricates.blue, fontSize: size);
    return ts;
  }
}
