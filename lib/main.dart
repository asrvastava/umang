import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:umang/screens/forget_verification.dart';
import 'package:umang/screens/login_screen.dart';
import 'package:umang/responsive/responsive_layout_screen.dart';
import 'package:umang/responsive/mobileScreenLayout.dart';
import 'package:umang/responsive/webScreenLayout.dart';
import 'package:umang/screens/newpassword.dart';
import 'package:umang/screens/otp_verification.dart';
import 'package:umang/screens/signup_screen.dart';
import 'package:umang/utils/colors.dart';

List<CameraDescription>? camera;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAEvEijdP7aXaD8FJI8vYQYTtGZnF5Gc3M',
          appId: "1:1067622979640:web:acbedcb661b6f89899aecd",
          messagingSenderId: "1067622979640",
          projectId: "1067622979640",
          storageBucket: "umang-e7816.appspot.com"),
    );
  } else {
    await Firebase.initializeApp();
  }

  camera = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UMANG',
      theme: ThemeData.light(),
      // home: new_password(code: verify),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(
                  mobileCreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout());
            }
            if (snapshot.hasError) {
              return Text('some error occurred');
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: inputcolor,
              ),
            );
          }

          return const Login_Screen();
        },
      ),
    );
  }
}
