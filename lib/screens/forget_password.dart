import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:umang/screens/forget_verification.dart';
import 'package:umang/screens/login_screen.dart';
import 'package:umang/utils/utils.dart';
import 'package:umang/widgets/text_field_input.dart';

import '../utils/colors.dart';

class forget extends StatefulWidget {
  const forget({super.key});

  @override
  State<forget> createState() => _forgetState();
}

class _forgetState extends State<forget> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailcontroller = TextEditingController();
    final TextEditingController _phonecontroller = TextEditingController();
    String verify = "";
    bool _isLoading = false;

    @override
    void dispose() {
      // TODO: implement dispose

      _emailcontroller.dispose();
      _phonecontroller.dispose();
    }

    void navigatetologin() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Login_Screen(),
        ),
      );
    }

    final focusedPinTheme = PinTheme(
      width: 46,
      height: 46,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
          borderRadius: BorderRadius.circular(8)),
    );

    void sendotp() async {
      if (_emailcontroller.text.isNotEmpty) {
        setState(() {
          _isLoading = true;
        });

        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailcontroller.text);

        // await FirebaseAuth.instance.verifyPhoneNumber(
        //   phoneNumber: "+91${_phonecontroller.text}",
        //   verificationCompleted: (PhoneAuthCredential credential) {},
        //   verificationFailed: (FirebaseAuthException e) {},
        //   codeSent: (String verificationId, int? resendToken) {
        //     verify = verificationId;
        //   },
        //   codeAutoRetrievalTimeout: (String verificationId) {},
        // );

        setState(() {
          _isLoading = false;
        });
        showSnackBar("check your Email Id", context);
        navigatetologin();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar("Fill all the Details", context);
      }
    }

    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(
            flex: 2,
            child: Container(),
          ),
          Image.network(
            "https://cdni.iconscout.com/illustration/premium/thumb/forgot-password-4268397-3551744.png",
            height: 230,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          TextFieldInput(
              textEditingController: _emailcontroller,
              hintText: "enter your registered email",
              textInputType: TextInputType.emailAddress),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: sendotp,
            child: _isLoading
                ? Center(
                    child:
                        CircularProgressIndicator(backgroundColor: inputcolor),
                  )
                : Container(
                    child: const Text('Send Link'),
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
