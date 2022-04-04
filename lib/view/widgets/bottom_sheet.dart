import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'filled_button.dart';
import '/strings.dart';
import '/colors.dart';

class BottomSheetDialog extends StatefulWidget {
  final bool? dismissOnContinue;
  final Function()? onBack;
  final Function(int selectedItemPosition)? onContinue;

  const BottomSheetDialog(
      {Key? key, this.dismissOnContinue, this.onBack, this.onContinue})
      : super(key: key);

  @override
  _BottomSheetDialogState createState() => _BottomSheetDialogState();
}

class _BottomSheetDialogState extends State<BottomSheetDialog> {
  late int selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = -1;
  }

  changeSelectedItem(int position) => setState(() => selectedItem = position);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Material(
        color: ColorsSuricates.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                TextsSuricates.proposeDeal,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: RadioButton(
                  TextsSuricates.exchangeExisting,
                  checked: (selectedItem == 0),
                  function: () => changeSelectedItem(0),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: RadioButton(
                  TextsSuricates.exchangePhoto,
                  checked: (selectedItem == 1),
                  function: () => changeSelectedItem(1),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                    text: TextsSuricates.back,
                    fontWeight: FontWeight.w600,
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onBack;
                    },
                    enabled: true,
                    backgroundColor: Colors.transparent,
                    textColor: ColorsSuricates.orange,
                  ),
                  FilledButton(
                    text: TextsSuricates.textContinue,
                    fontWeight: FontWeight.w600,
                    onPressed: () {
                      if (widget.dismissOnContinue ?? true) {
                        Navigator.of(context).pop();
                      }
                      widget.onContinue!(selectedItem);
                    },
                    enabled: selectedItem != -1,
                    backgroundColor: ColorsSuricates.orange,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ]);
  }
}

class RadioButton extends StatefulWidget {
  final String text;
  final bool? checked;
  final Function()? function;

  const RadioButton(this.text, {Key? key, this.checked, this.function})
      : super(key: key);

  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.function,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: (widget.checked ?? false)
            ? ColorsSuricates.backgroundOrange
            : ColorsSuricates.backgroundBlue,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              SvgPicture.asset(
                (widget.checked ?? false)
                    ? "images/radio_filled.svg"
                    : "images/radio_outlined.svg",
                width: 24,
                height: 24,
                color: (widget.checked ?? false)
                    ? ColorsSuricates.textOrange
                    : ColorsSuricates.textBlue,
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: (widget.checked ?? false)
                          ? ColorsSuricates.textOrange
                          : ColorsSuricates.textBlue,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
