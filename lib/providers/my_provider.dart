import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c8_str/models/user_model.dart';
import 'package:todo_c8_str/shared/network/firebase/firebase_functions.dart';

class MyProvider extends ChangeNotifier {
  UserModel? myUser;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      initUser();
    }
  }

  Future initUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    myUser = await FirebaseFunctions.readUser(firebaseUser!.uid);
    notifyListeners();
  }

  void logout() {
    FirebaseAuth.instance.signOut();

    notifyListeners();
  }
}
