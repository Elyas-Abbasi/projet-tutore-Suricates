import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../messaging/notification_service.dart';
import 'package:suricates_app/main.dart';
import 'package:flutter/material.dart';
import '/model/current_user.dart';
import '/globals.dart' as globals;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference usersInfo =
      FirebaseFirestore.instance.collection('usersInfo');

  void saveToken(CurrentUser? user) async {
    if (user == null) return;
    NotificationService.getToken().then(
      (value) async {
        await usersInfo.doc(user.uid).update({'token': value});
      },
    );
  }

  getUser() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        globals.currentUser = null;
        runApp(
          const MyApp(currentUser: null),
        );
      } else {
        CurrentUser? currentUser = CurrentUser(user.uid, "", user.email!);
        saveToken(currentUser);
        globals.currentUser = currentUser;
        usersInfo.doc(currentUser.uid).get().then((DocumentSnapshot document) {
          currentUser.pseudo = document["pseudo"];
          runApp(
            MyApp(currentUser: currentUser),
          );
        }).catchError((error) {
          runApp(
            MyApp(
              currentUser: currentUser,
              hasFinishRegister: false,
            ),
          );
        });
      }
    });
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      CurrentUser currentUser = CurrentUser(
        user!.uid,
        user.email!,
        "",
      );
      saveToken(currentUser);
      return currentUser;
    } catch (e) {
      return e;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      return CurrentUser(
        user!.uid,
        user.email!,
        "",
      );
    } catch (e) {
      return e;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
