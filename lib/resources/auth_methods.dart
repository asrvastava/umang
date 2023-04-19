import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:umang/models/user.dart' as model;
import 'package:flutter/material.dart';
import 'package:umang/resources/storage_methods.dart';

class Authmethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('users');

  Future<model.User> getuserdetails() async {
    User currentuser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.doc(currentuser.uid).get();

    return model.User.fromSnap(snap);
  }

  //signup

  Future<String> SignupUser({
    required String email,
    required String password,
    required String username,
    required String phone,
    required Uint8List file,
  }) async {
    String res = "some error occurred";

    try {
      if (file != null ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          phone.isNotEmpty) {
        //register the user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photourl =
            await Storagemethods().uploadImageTOstorage('profilePics', file);

        print(cred.user!.uid);

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          photourl: photourl,
          phone: phone,
        );

        //add user to our databse
        await _firestore.doc(cred.user!.uid).set(
              user.toJson(),
            );

        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  //login user

  Future<String> loginuser(
      {required String email, required String password}) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "succes";
      } else {
        res = "please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<void> signout() async {
    await _auth.signOut();
  }
}
