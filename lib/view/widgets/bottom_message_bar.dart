import '/services/messaging/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'text_field.dart';
import '/colors.dart';

class BottomMessageBar extends StatefulWidget {
  final ChatService chatParams;
  final TextEditingController messageController;
  final Function() sendFunction;
  // Instance d'une annonce
  const BottomMessageBar({Key? key, required this.chatParams, required this.messageController, required this.sendFunction}) : super(key: key);
  @override
  _BottomMessageBar createState() => _BottomMessageBar();
}

class _BottomMessageBar extends State<BottomMessageBar> {

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          right: 4,
          left: 4,
          top: 0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Row(
          children: [
            Material(
              color: ColorsSuricates.orange,
              borderRadius: const BorderRadius.all(Radius.circular(13)),
              child: InkWell(
                borderRadius: BorderRadius.circular(13),
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: SvgPicture.asset("images/troc_msg.svg",
                      width: 20, height: 20, color: ColorsSuricates.white),
                ),
              ),
            ),
            Expanded(
                child: SuricatesTextField(
              hint: "Ecrivez un message",
              controller: widget.messageController,
              getText: (text) {},
              textInputType: TextInputType.multiline,
              maxLines: 3,
            )),
            Material(
              color: ColorsSuricates.blue,
              borderRadius: const BorderRadius.all(Radius.circular(13)),
              child: InkWell(
                borderRadius: BorderRadius.circular(13),
                onTap: () => widget.sendFunction(),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    "images/arrow.svg",
                    width: 20,
                    height: 20,
                    color: ColorsSuricates.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
