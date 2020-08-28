import 'package:firebase_auth/firebase_auth.dart';
import 'package:twiine/auth.dart';
import 'package:flutter/material.dart';
import 'package:twiine/components/navbar.dart';
import 'package:twiine/screens/pre_login/landing_page.dart';

class LoginChecker extends StatefulWidget {
  @override
  LoginCheckerState createState() => LoginCheckerState();
}

class LoginCheckerState extends State<LoginChecker> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth.firebaseAuth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            if (snapshot.data == null) {
              return LandingPage();
            } else {
              Auth.updateUserData();
              return Navbar();
            }
            break;
          default:
            return Expanded(child: Container(color: Colors.white));
            break;
        }
      },
    );
  }
}
