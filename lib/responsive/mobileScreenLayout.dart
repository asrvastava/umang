import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:umang/main.dart';
import 'package:umang/resources/auth_methods.dart';
import 'package:umang/models/user.dart' as model;
import 'package:umang/screens/outputcreen.dart';

import '../utils/colors.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    void navigtortooutput() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const output(),
        ),
      );
    }

    final FirebaseAuth _auth = FirebaseAuth.instance;
    void signout() {
      FirebaseAuth.instance.signOut();
    }

    return Scaffold(
      appBar: AppBar(title: Text('emotion detection')),
      body: Column(
        children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          InkWell(
            onTap: navigtortooutput,
            child: Container(
              child: const Text('open camera'),
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                color: buttoncolor,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: signout,
            child: Container(
              child: const Text('signout'),
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                color: buttoncolor,
              ),
            ),
          ),
          Flexible(
            child: Container(),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
