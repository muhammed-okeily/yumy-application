// ignore_for_file: await_only_futures


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/constants/constants.dart';

import '../models/UserModel.dart';



class Auth {
  final auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<UserCredential> signUp(String email, String password) async {
    final authResult = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return authResult;
  }

  addUser(Users users) {
    firestore.collection(UserDataFood).add({
      uName : users.uName,
      uEmail: users.uEmail,
      uPhone: users.uPhone,
      uPassword: users.uPassword,
      
    });
  }

  Future<UserCredential> signIn(String email, String password) async {
    final authResult =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return authResult;
  }

  Future getUser() async {
    return auth.currentUser;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
