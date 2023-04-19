import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umang/resources/auth_methods.dart';
import 'package:umang/screens/login_screen.dart';
import 'package:umang/screens/otp_verification.dart';
import 'package:umang/utils/colors.dart';
import 'package:umang/widgets/text_field_input.dart';
import 'package:umang/utils/utils.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  Uint8List? _image;
  static String verify = "";
  bool _isLoading = false;

  void navigatetologin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Login_Screen(),
      ),
    );
  }

  void navigatetootp() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => otp(
        emailcontroller: _emailcontroller.text,
        passwordcontroller: _passwordcontroller.text,
        phonecontroller: _phonecontroller.text,
        image: _image,
        verify: verify,
        usernamecontroller: _usernamecontroller.text,
      ),
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phonecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _usernamecontroller.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUsers() async {
    setState(() {
      _isLoading = true;
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${_phonecontroller.text}",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        verify = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    String res = "otp send";
    if (res != "otp send") {
      setState(() {
        _isLoading = false;
      });
      showSnackBar('something went wrong', context);
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(res, context);
      navigatetootp();
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 45, backgroundImage: MemoryImage(_image!))
                    : CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(
                            'https://images.thequint.com/thequint/2021-04/15d4fcf5-7c0e-481e-9dc6-37e444c58fef/IPL21M8_55.JPG?auto=format,compress&fmt=webp&format=webp&w=1200&h=900&dpr=1.0'),
                      ),
                Positioned(
                    bottom: -10,
                    left: 50,
                    child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo))),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldInput(
                textEditingController: _usernamecontroller,
                hintText: "enter your full name",
                textInputType: TextInputType.text),
            const SizedBox(
              height: 10,
            ),
            TextFieldInput(
                textEditingController: _emailcontroller,
                hintText: "enter your email",
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 10,
            ),
            TextFieldInput(
                textEditingController: _phonecontroller,
                hintText: "enter your phone no",
                textInputType: TextInputType.phone),
            const SizedBox(
              height: 10,
            ),
            TextFieldInput(
                textEditingController: _passwordcontroller,
                hintText: "enter password",
                ispassword: true,
                textInputType: TextInputType.text),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: signUpUsers,
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: inputcolor,
                      ),
                    )
                  : Container(
                      child: const Text("Send otp"),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        color: buttoncolor,
                      ),
                    ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('Do you have an account ?  '),
                ),
                GestureDetector(
                  onTap: navigatetologin,
                  child: Text(
                    'Log In',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
          ],
        ),
      )),
    );
  }
}
