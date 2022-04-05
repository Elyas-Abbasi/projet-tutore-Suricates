import '/services/authentification/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/services/firebase_stockage/post_image.dart';
import '/services/firebase_stockage/get_image.dart';
import '/services/image_picker/image_picker.dart';
import '../widgets/transparent_button.dart';
import '../widgets/loading_widget.dart';
import '../widgets/filled_button.dart';
import 'package:flutter/material.dart';
import '../navigations/appbar.dart';
import '../widgets/text_field.dart';
import '../widgets/info_bar.dart';
import '/model/current_user.dart';
import '/strings.dart';
import '/colors.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  final bool isNewUser;
  final CurrentUser currentUser;

  const EditProfilePage(
      {Key? key, required this.isNewUser, required this.currentUser})
      : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final databaseReference = FirebaseFirestore.instance;
  File? image;
  String? newPseudo;
  bool buttonEnabled = false;
  TextEditingController? pseudoController = TextEditingController();
  bool loading = false;
  bool fieldEnabled = true;
  bool showError = false;
  String textError = "";

  @override
  void initState() {
    super.initState();
    if (!widget.isNewUser) {
      pseudoController!.text = widget.currentUser.pseudo;
    }
  }

  void readyToSend() {
    String pseudo = pseudoController!.text;
    if (image != null &&
            pseudo.length >= 3 &&
            pseudo.length <= 14 &&
            !pseudo.contains(" ") ||
        pseudo != widget.currentUser.pseudo &&
            pseudo.length >= 3 &&
            pseudo.length <= 14 &&
            !pseudo.contains(" ")) {
      setState(() {
        buttonEnabled = true;
        showError = false;
      });
    } else {
      if (pseudo.length < 3) {
        setState(() {
          textError = TextsSuricates.tooSmallPseudo;
          showError = true;
        });
      }
      if (pseudo.length > 14) {
        setState(() {
          textError = TextsSuricates.tooBigPseudo;
          showError = true;
        });
      }
      if (pseudo.contains(" ")) {
        setState(() {
          textError = TextsSuricates.noSpacePseudo;
          showError = true;
        });
      }
      setState(() => buttonEnabled = false);
    }
  }

  send() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      buttonEnabled = false;
      loading = true;
    });

    bool resultImage = false;
    bool resultPseudo = false;
    if (image != null) {
      String url = await PostImage()
          .postImage(widget.currentUser.uid, 'profile_pictures', image);

      url.startsWith("https") ? resultImage = true : resultImage = false;
    } else {
      resultImage = true;
    }

    if (pseudoController!.text != widget.currentUser.pseudo &&
        !widget.isNewUser) {
      await databaseReference
          .collection('usersInfo')
          .doc(widget.currentUser.uid)
          .update({"pseudo": pseudoController!.text}).then((value) {
        resultPseudo = true;
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        resultPseudo = false;
      });
    } else if (pseudoController!.text != widget.currentUser.pseudo &&
        widget.isNewUser) {
      await databaseReference
          .collection('usersInfo')
          .doc(widget.currentUser.uid)
          .set({"pseudo": pseudoController!.text}).then((value) {
        resultPseudo = true;
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        resultPseudo = false;
      });
    } else {
      resultPseudo = true;
    }

    if (resultImage == true && resultPseudo == true) {
      if (resultPseudo == true || widget.isNewUser == true) {
        await AuthService().getUser();
      }

      if (widget.isNewUser) {
        Navigator.pushNamed(context, "/");
      } else {
        Navigator.pop(context);
      }
    } else {
      setState(() {
        buttonEnabled = true;
        loading = false;
        textError = TextsSuricates.errorMessage;
        showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.isNewUser) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: widget.isNewUser == false
            ? AppBarWidget(
                title: TextsSuricates.editProfile,
                icon: const Icon(Icons.arrow_back_ios_new),
                function: () => Navigator.pop(context),)
            : AppBarWidget(title: TextsSuricates.createProfile),
        body: Stack(children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                      width: 120,
                      height: 120,
                      child: Material(
                          color: ColorsSuricates.lightGrey,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(25),
                              onTap: () async {
                                if (fieldEnabled == true) {
                                  var imageTemporary =
                                      await PickImage().chooseImage();
                                  setState(() => image = imageTemporary);
                                  readyToSend();
                                }
                              },
                              child: image == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: FutureBuilder(
                                          future: GetImage.get(
                                              widget.currentUser.uid,
                                              "profile_pictures"),
                                          builder: (context, snap) {
                                            if (snap.data == null) {
                                              return Image.asset(
                                                "images/noProfilePicture.jpg",
                                                fit: BoxFit.cover,
                                              );
                                            } else {
                                              return Image.network(
                                                snap.data.toString(),
                                                fit: BoxFit.cover,
                                              );
                                            }
                                          }),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child:
                                          Image.file(image!, fit: BoxFit.cover),
                                    )))),
                  const SizedBox(height: 30),
                  SuricatesTextField(
                      hint: "Pseudo",
                      textInputType: TextInputType.name,
                      controller: pseudoController,
                      getText: (pseudo) =>readyToSend(), ),
                  Visibility(
                    child: InfoBar(
                        text: textError,
                        textColor: ColorsSuricates.redDark,
                        backgroundColor: ColorsSuricates.redLight),
                    visible: showError,
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: !widget.isNewUser,
                        child: TransparentButton(
                            text: TextsSuricates.cancel,
                            onPressed: () => Navigator.pop(context)),
                      ),
                      FilledButton(
                        text: TextsSuricates.save,
                        enabled: buttonEnabled,
                        backgroundColor: ColorsSuricates.orange,
                        onPressed: () => send(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Visibility(visible: loading, child: const LoadingWidget())
        ]),
      ),
    );
  }
}
