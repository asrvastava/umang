import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:umang/screens/signup_screen.dart';

import '../main.dart';
import '../resources/auth_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class otp extends StatefulWidget {
  final String usernamecontroller;
  final String emailcontroller;
  final String passwordcontroller;
  final String phonecontroller;
  final String verify;
  final Uint8List? image;

  const otp({
    Key? key,
    required this.usernamecontroller,
    required this.emailcontroller,
    required this.passwordcontroller,
    required this.phonecontroller,
    required this.verify,
    this.image,
  }) : super(key: key);

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(19, 70, 111, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  final focusedPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
        borderRadius: BorderRadius.circular(8)),
  );

  final TextEditingController pincontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pincontroller.dispose();
  }

  void signUpUsers() async {
    if (pincontroller.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      String res = "all";
      try {
        res = await Authmethods().SignupUser(
          email: widget.emailcontroller,
          password: widget.passwordcontroller,
          phone: widget.phonecontroller,
          file: widget.image!,
          username: widget.usernamecontroller,
        );

        PhoneAuthProvider.credential(
            verificationId: widget.verify, smsCode: pincontroller.text);
      } catch (e) {
        res = e.toString();
      }

      if (res == "success") {
        setState(() {
          _isLoading = false;
        });

        showSnackBar(res, context);
        navigatetohome();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } else {
      showSnackBar("enter the otp", context);
    }
  }

  void navigatetohome() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MyApp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Image.network(
            'https://st4.depositphotos.com/25453930/40688/v/600/depositphotos_406885434-stock-illustration-step-authentication-illustration-web-page.jpg',
            height: 230,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            child: Text(
              "Enter 6 digits otp send on your phone number",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Pinput(
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: defaultPinTheme,
            showCursor: true,
            androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
            controller: pincontroller,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: signUpUsers,
            child: Container(
              child: const Text('Verify'),
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
            height: 20,
          ),
          Flexible(
            child: Container(),
            flex: 2,
          ),
        ]),
      )),
    );
  }
}
