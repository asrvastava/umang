import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:umang/screens/login_screen.dart';
import 'package:umang/utils/utils.dart';
import 'package:umang/widgets/text_field_input.dart';

import '../utils/colors.dart';

class new_password extends StatefulWidget {
  final String code;
  const new_password({Key? key, required this.code}) : super(key: key);

  @override
  State<new_password> createState() => _new_passwordState();
}

class _new_passwordState extends State<new_password> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final TextEditingController _password = TextEditingController();
    final TextEditingController _confirmpassword = TextEditingController();

    void navigatetologin() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Login_Screen(),
        ),
      );
    }

    void changepassword() {
      if (_password.text == _confirmpassword.text) {
        String res = "success";
        try {
          FirebaseAuth.instance.confirmPasswordReset(
              code: widget.code, newPassword: _confirmpassword.text);
        } catch (e) {
          res = e.toString();
        }

        if (res == "success") {
          navigatetologin();
        } else {
          showSnackBar(res, context);
        }
      } else {
        showSnackBar(
            "New password and confirm password should be same", context);
      }
    }

    @override
    void dispose() {
      _password.dispose();
      _confirmpassword.dispose();
    }

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
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4mKQ60nHMdhADBAJa1afaCyi3pd5S5fgDyw&usqp=CAU",
            height: 200,
            width: double.infinity,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldInput(
              textEditingController: _password,
              hintText: "enter your new password",
              textInputType: TextInputType.visiblePassword),
          const SizedBox(
            height: 10,
          ),
          TextFieldInput(
            textEditingController: _confirmpassword,
            hintText: "Re enter your new password",
            textInputType: TextInputType.text,
            ispassword: true,
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: changepassword,
            child: Container(
              child: const Text('Log In'),
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
