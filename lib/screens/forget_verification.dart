import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pinput/pinput.dart';
import 'package:umang/screens/newpassword.dart';

import '../utils/colors.dart';
import '../utils/utils.dart';
import 'login_screen.dart';

class forgetv extends StatefulWidget {
  final String verify;
  const forgetv({Key? key, required this.verify}) : super(key: key);

  @override
  State<forgetv> createState() => _forgetvState();
}

class _forgetvState extends State<forgetv> {
  bool _isLoading = false;
  final TextEditingController pinphonecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();

  void navigatetonew() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => new_password(code: emailcontroller.text),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    pinphonecontroller.dispose();
    emailcontroller.dispose();
  }

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

  void verifyotp() {
    if (pinphonecontroller.text.isNotEmpty &&
        pinphonecontroller.text.length == 6 &&
        emailcontroller.text.isNotEmpty &&
        emailcontroller.text.length == 6) {
      setState(() {
        _isLoading = true;
      });
      String res = "success";
      try {
        FirebaseAuth.instance.verifyPasswordResetCode(emailcontroller.text);
        PhoneAuthProvider.credential(
            verificationId: widget.verify, smsCode: pinphonecontroller.text);
      } catch (e) {
        res = e.toString();
      }

      if (res == "success") {
        showSnackBar(res, context);
        navigatetonew();
      } else {
        showSnackBar("wrong otp", context);
      }
    } else {
      showSnackBar('fill the otp', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Image.network(
            "https://cdni.iconscout.com/illustration/premium/thumb/forgot-password-4268397-3551744.png",
            height: 230,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Enter phone otp",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Pinput(
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            controller: pinphonecontroller,
            submittedPinTheme: defaultPinTheme,
            showCursor: true,
            androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Enter email otp",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Pinput(
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            controller: emailcontroller,
            submittedPinTheme: defaultPinTheme,
            showCursor: true,
            androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: verifyotp,
            child: _isLoading
                ? Center(
                    child:
                        CircularProgressIndicator(backgroundColor: inputcolor),
                  )
                : Container(
                    child: const Text('verify otp'),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
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
        ]),
      )),
    );
  }
}
