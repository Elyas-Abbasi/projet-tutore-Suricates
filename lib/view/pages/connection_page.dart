import '/services/authentification/auth_service.dart';
import '../widgets/transparent_button.dart';
import '../widgets/loading_widget.dart';
import '../widgets/filled_button.dart';
import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../navigations/appbar.dart';
import '../widgets/info_bar.dart';
import '/model/current_user.dart';
import 'edit_profile_page.dart';
import '/strings.dart';
import '/colors.dart';

// ignore: must_be_immutable
class ConnectionPage extends StatefulWidget {
  bool hasAccount;
  final bool connectionPage;
  final Widget? route;
  final bool? passByMainPage;

  ConnectionPage(
      {Key? key,
      required this.hasAccount,
      required this.connectionPage,
      this.route,
      this.passByMainPage})
      : super(key: key);

  @override
  _ConnectionContainerState createState() => _ConnectionContainerState();
}

class _ConnectionContainerState extends State<ConnectionPage> {
  String? _loginEmail;
  String? _loginPassword;
  String? _registerEmail;
  String? _registerPassword;
  String? _registerPasswordConfirm;

  bool fieldEnabled = true;
  bool loginButtonEnabled = false;
  bool registerButtonEnabled = false;
  bool showLoginError = false;
  bool showRegisterError = false;
  bool loading = false;
  String textError = "";

  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";

  void connectionReady() {
    RegExp regex = RegExp(pattern);
    if (_loginEmail == null ||
        _loginEmail!.isEmpty ||
        !regex.hasMatch(_loginEmail!)) {
      setState(() {
        textError = TextsSuricates.incorrectEmail;
        showLoginError = true;
        loginButtonEnabled = false;
      });
    } else {
      setState(() => showLoginError = false);
      if (_loginPassword == null ||
          _loginPassword!.isEmpty ||
          _loginPassword!.length < 6) {
        setState(() {
          showLoginError = true;
          textError = TextsSuricates.incorrectPasswordSize;
          loginButtonEnabled = false;
        });
      } else {
        setState(() {
          showLoginError = false;
          loginButtonEnabled = true;
        });
      }
    }
  }

  void registerReady() {
    RegExp regex = RegExp(pattern);
    if (_registerEmail == null ||
        _registerEmail!.isEmpty ||
        !regex.hasMatch(_registerEmail!)) {
      setState(() {
        textError = TextsSuricates.incorrectEmail;
        showRegisterError = true;
        registerButtonEnabled = false;
      });
    } else {
      if (_registerPassword == null ||
          _registerPassword!.isEmpty ||
          _registerPassword!.length < 6) {
        setState(() {
          showRegisterError = true;
          textError = TextsSuricates.incorrectPasswordSize;
          registerButtonEnabled = false;
        });
      } else {
        if (_registerPasswordConfirm != _registerPassword) {
          setState(() {
            showRegisterError = true;
            textError = TextsSuricates.identicalPasswordFailed;
            registerButtonEnabled = false;
          });
        } else {
          setState(() {
            showRegisterError = false;
            registerButtonEnabled = true;
          });
        }
      }
    }
  }

  login() async {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      fieldEnabled = false;
      loginButtonEnabled = false;
      loading = true;
    });

    await AuthService()
        .signInWithEmailAndPassword(_loginEmail!, _loginPassword!)
        .then((value) async {
      if (value is CurrentUser) {
        AuthService().getUser();

        if (widget.connectionPage == true && widget.route != null) {
          if (widget.passByMainPage == true) {
            Navigator.pushNamed(context, "/");
          }
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => widget.route!));
        }
      } else {
        switch (value.code) {
          case "invalid-email":
            textError = TextsSuricates.invalidEmail;
            break;

          case "user-disabled":
            textError = TextsSuricates.userDisabled;
            break;

          case "user-not-found":
            textError = TextsSuricates.userNotFound;
            break;

          case "wrong-password":
            textError = TextsSuricates.wrongPassword;
            break;

          default:
            textError = TextsSuricates.errorMessage;
            break;
        }

        setState(() {
          loading = false;
          loginButtonEnabled = true;
          fieldEnabled = true;
          showLoginError = true;
        });
      }
    });
  }

  register() async {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      fieldEnabled = false;
      registerButtonEnabled = false;
      loading = true;
    });

    await AuthService()
        .registerWithEmailAndPassword(_registerEmail!, _registerPassword!)
        .then((value) async {
      if (value is CurrentUser) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(isNewUser: true, currentUser: value)));
      } else {
        switch (value.code) {
          case "invalid-email":
            textError = TextsSuricates.invalidEmail;
            break;

          case "email-already-in-use":
            textError = TextsSuricates.emailAlreadyInUse;
            break;

          case "weak-password":
            textError = TextsSuricates.weakPassword;
            break;

          default:
            textError = TextsSuricates.errorMessage;
            break;
        }

        setState(() {
          loading = false;
          registerButtonEnabled = true;
          fieldEnabled = true;
          showRegisterError = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: widget.connectionPage == true
            ? AppBarWidget(title: TextsSuricates.connection, icon: const Icon(Icons.arrow_back_ios_new), function: () {Navigator.pop(context);},)
            : null,
        body: widget.hasAccount == true
            ? Stack(
                children: [
                  Container(
                      margin: const EdgeInsets.only(
                          top: 12, right: 12, bottom: 24, left: 12),
                      child: Column(
                        children: [
                          Expanded(
                              child: Center(
                            child: Column(
                              children: [
                                const Text(
                                  TextsSuricates.connection,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      right: 24, left: 24),
                                  child: Column(
                                    children: [
                                      SuricatesTextField(
                                          textInputType:
                                              TextInputType.emailAddress,
                                          enable: fieldEnabled,
                                          hint: TextsSuricates.email,
                                          getText: (email) {
                                            _loginEmail = email;
                                            connectionReady();
                                          }),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      SuricatesTextField(
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        enable: fieldEnabled,
                                        hint: TextsSuricates.password,
                                        getText: (password) {
                                          _loginPassword = password;
                                          connectionReady();
                                        },
                                      ),
                                      Visibility(
                                        child: InfoBar(
                                            text: textError,
                                            textColor: ColorsSuricates.redDark,
                                            backgroundColor: ColorsSuricates.redLight),
                                        visible: showLoginError,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      TextsSuricates.forgotPassword,
                                      style: TextStyle(
                                          color: ColorsSuricates.blue),
                                    )),
                                const SizedBox(
                                  height: 12,
                                ),
                                FilledButton(
                                  text: TextsSuricates.login,
                                  onPressed: () async => login(),
                                  enabled: loginButtonEnabled,
                                  backgroundColor: ColorsSuricates.orange,
                                ),
                              ],
                            ),
                          )),
                          Column(
                            children: [
                              const Text(TextsSuricates.noAccount),
                              const SizedBox(
                                height: 12,
                              ),
                              FilledButton(
                                  text: TextsSuricates.joinSuricates,
                                  onPressed: () => setState(() => widget.hasAccount = false),
                                  enabled: true)
                            ],
                          )
                        ],
                      )),
                  Visibility(visible: loading, child: const LoadingWidget())
                ],
              )
            : Stack(
                children: [
                  Container(
                      margin: const EdgeInsets.only(
                          top: 12, right: 12, bottom: 24, left: 12),
                      child: Center(
                        child: Column(
                          children: [
                            const Text(
                              TextsSuricates.signIn,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(right: 24, left: 24),
                              child: Column(
                                children: [
                                  SuricatesTextField(
                                      textInputType: TextInputType.emailAddress,
                                      enable: fieldEnabled,
                                      hint: TextsSuricates.email,
                                      getText: (email) {
                                        _registerEmail = email;
                                        registerReady();
                                      }),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  SuricatesTextField(
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      hint: TextsSuricates.password,
                                      enable: fieldEnabled,
                                      getText: (password) {
                                        _registerPassword = password;
                                        registerReady();
                                      }),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  SuricatesTextField(
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      enable: fieldEnabled,
                                      hint: TextsSuricates.password,
                                      getText: (passwordConfirm) {
                                        _registerPasswordConfirm =
                                            passwordConfirm;
                                        registerReady();
                                      }),
                                  Visibility(
                                    child: InfoBar(
                                        text: textError,
                                        textColor: ColorsSuricates.redDark,
                                        backgroundColor: ColorsSuricates.redLight),
                                    visible: showRegisterError,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 56,
                            ),
                            FilledButton(
                              text: TextsSuricates.joinSuricates,
                              onPressed: () => register(),
                              enabled: registerButtonEnabled,
                              backgroundColor: ColorsSuricates.orange,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TransparentButton(
                                text: TextsSuricates.cancelSignIn,
                                onPressed: () => setState(() => widget.hasAccount = true),)
                          ],
                        ),
                      )),
                  Visibility(visible: loading, child: const LoadingWidget())
                ],
              ));
  }
}
