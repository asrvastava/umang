import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umang/main.dart';
import 'package:umang/resources/auth_methods.dart';
import 'package:umang/screens/forget_password.dart';
import 'package:umang/screens/signup_screen.dart';
import 'package:umang/utils/colors.dart';
import 'package:umang/utils/utils.dart';
import 'package:umang/widgets/text_field_input.dart';
import 'package:umang/widgets/vector.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isloading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginuser() async {
    setState(() {
      _isloading = true;
    });

    String res = await Authmethods().loginuser(
        email: _emailController.text, password: _passwordController.text);

    if (res == 'success') {
      setState(() {
        _isloading = false;
      });
      navigatetohome();
    } else {
      setState(() {
        _isloading = false;
      });
      showSnackBar(res, context);
    }
  }

  void navigatetosignup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const signup(),
      ),
    );
  }

  void navigatetoforget() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const forget(),
      ),
    );
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
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            //svgimage
            SvgPicture.asset(
              "assets/cube.svg",
              // ignore: deprecated_member_use
              color: inputcolor,
              height: 64,
            ),
            const SizedBox(
              height: 20,
            ),
            //textfield for email
            TextFieldInput(
                textEditingController: _emailController,
                hintText: 'enter your email',
                textInputType: TextInputType.emailAddress),

            const SizedBox(
              height: 10,
            ), //textfield for password
            TextFieldInput(
              textEditingController: _passwordController,
              hintText: 'enter your password',
              textInputType: TextInputType.text,
              ispassword: true,
            ),
            //button for login
            const SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: navigatetoforget,
                  child: Text(
                    'forget password ?',
                    style: TextStyle(color: inputcolor),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: loginuser,
              child: _isloading
                  ? Center(
                      child: CircularProgressIndicator(
                          backgroundColor: inputcolor),
                    )
                  : Container(
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
            const SizedBox(
              height: 30,
            ),

            const SizedBox(
              height: 64,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    "Don't have an account ?  ",
                  ),
                ),
                GestureDetector(
                  onTap: navigatetosignup,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),

            Flexible(
              child: Container(),
              flex: 2,
            ),

            //transition to signup
          ]),
        ),
      ),
    );
  }
}
