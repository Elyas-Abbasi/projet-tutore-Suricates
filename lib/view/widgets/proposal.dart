import 'package:flutter/material.dart';
import '/model/proposal_status.dart';
import 'filled_button.dart';
import '/strings.dart';
import '/colors.dart';

class Proposal extends StatefulWidget {
  final bool propositionByCurrentUser;
  final String proposerImagePath;
  final String responderImagePath;
  final ProposalStatus status;

  const Proposal({
    Key? key,
    required this.propositionByCurrentUser,
    required this.status,
    required this.proposerImagePath,
    required this.responderImagePath,
  }) : super(key: key);

  @override
  _ProposalState createState() => _ProposalState();
}

class _ProposalState extends State<Proposal> {
  late Color backgroundColor;
  late String title;

  @override
  void initState() {
    super.initState();
    if (widget.propositionByCurrentUser) {
      backgroundColor = ColorsSuricates.backgroundOrange;
    } else {
      backgroundColor = ColorsSuricates.backgroundBlue;
    }
    switch (widget.status) {
      case ProposalStatus.waiting:
        if (widget.propositionByCurrentUser) {
          title = TextsSuricates.youHavePropose;
        } else {
          title = TextsSuricates.youHaveAProposal;
        }
        break;
      case ProposalStatus.accepted:
        if (widget.propositionByCurrentUser) {
          title = TextsSuricates.proposalAccepted;
        } else {
          title = TextsSuricates.youAccepted;
        }
        break;
      case ProposalStatus.refused:
        if (widget.propositionByCurrentUser) {
          title = TextsSuricates.proposalRefused;
        } else {
          title = TextsSuricates.youRefused;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 12,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ProposalBody(
              propositionByCurrentUser: widget.propositionByCurrentUser,
              proposerImagePath: widget.proposerImagePath,
              responderImagePath: widget.responderImagePath,
              status: widget.status,
            )
          ],
        ),
      ),
    );
  }
}

class ProposalBody extends StatefulWidget {
  final bool propositionByCurrentUser;
  final String proposerImagePath;
  final String responderImagePath;
  final ProposalStatus status;

  const ProposalBody({
    Key? key,
    required this.propositionByCurrentUser,
    required this.proposerImagePath,
    required this.responderImagePath,
    required this.status,
  }) : super(key: key);

  @override
  _ProposalBodyState createState() => _ProposalBodyState();
}

class _ProposalBodyState extends State<ProposalBody> {
  late Color textColor;
  late Color backgroundColor;
  late Color buttonBackgroundColor;
  late String leftText;
  late String rightText;

  @override
  void initState() {
    super.initState();
    if (widget.propositionByCurrentUser) {
      textColor = ColorsSuricates.textOrange;
      backgroundColor = ColorsSuricates.backgroundOrange;
      buttonBackgroundColor = ColorsSuricates.backgroundOrangeDark;
      leftText = TextsSuricates.you;
      rightText = TextsSuricates.him;
    } else {
      textColor = ColorsSuricates.textBlue;
      backgroundColor = ColorsSuricates.backgroundBlue;
      buttonBackgroundColor = ColorsSuricates.backgroundBlueDark;
      leftText = TextsSuricates.him;
      rightText = TextsSuricates.you;
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.status) {
      case ProposalStatus.waiting:
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Spacer(),
                ProposalImage(
                  imagePath: widget.proposerImagePath,
                  text: leftText,
                  textColor: textColor,
                ),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                ProposalImage(
                  imagePath: widget.responderImagePath,
                  text: rightText,
                  textColor: textColor,
                ),
                const Spacer(),
                const Spacer(),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  FilledButton(
                    text: widget.propositionByCurrentUser
                        ? TextsSuricates.waiting
                        : TextsSuricates.refuse,
                    onPressed: () {},
                    enabled: true,
                    backgroundColor: Colors.transparent,
                    textColor: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                  const Spacer(),
                  FilledButton(
                    text: widget.propositionByCurrentUser
                        ? TextsSuricates.cancel
                        : TextsSuricates.accept,
                    onPressed: () {},
                    enabled: true,
                    backgroundColor: buttonBackgroundColor,
                    textColor: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        );
      case ProposalStatus.accepted:
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Text(
            TextsSuricates.meetYou,
            style: TextStyle(color: textColor),
            textAlign: TextAlign.center,
          ),
        );
      case ProposalStatus.refused:
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: FilledButton(
            text: TextsSuricates.makeANewProposal,
            textAlign: TextAlign.center,
            onPressed: () {},
            enabled: true,
            fontWeight: FontWeight.w600,
            textColor: textColor,
            backgroundColor: buttonBackgroundColor,
          ),
        );
    }
  }
}

class ProposalImage extends StatelessWidget {
  final String imagePath;
  final String text;
  final Color textColor;

  const ProposalImage({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorsSuricates.white,
              width: 4,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imagePath,
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.width / 4,
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(color: textColor),
        )
      ],
    );
  }
}
