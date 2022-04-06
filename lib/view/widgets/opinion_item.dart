import 'package:flutter/material.dart';
import '/model/opinion.dart';
import '/colors.dart';

class OpinionItemWidget extends StatefulWidget {
  // Instance d'une annonce
  final Opinion opinion;
  final String url;
  final Function() onTapItem;
  final bool? isNetwork;

  const OpinionItemWidget({
    Key? key,
    required this.opinion,
    required this.url,
    required this.onTapItem,
    this.isNetwork,
  }) : super(key: key);

  @override
  _OpinionItemWidgetState createState() => _OpinionItemWidgetState();
}

class _OpinionItemWidgetState extends State<OpinionItemWidget> {
  @override
  Widget build(BuildContext context) {
    String url = "";
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 10,
      ),
      padding: EdgeInsets.zero,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () => setState(() => widget.onTapItem()),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: widget.isNetwork == true
                      ? Image.network(
                          url.toString(),
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "images/unknown.jpg",
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(
                  width: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.opinion.title,
                            style: const TextStyle(
                              color: ColorsSuricates.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 2,
                            ),
                            child: Text(
                              widget.opinion.note.toString(),
                              style: const TextStyle(
                                color: ColorsSuricates.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.star,
                            color: ColorsSuricates.orange,
                            size: 20,
                          ),
                        ],
                      ),
                      Text(
                        widget.opinion.description,
                        style: const TextStyle(
                          color: ColorsSuricates.blue,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
