import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:twiine/TwiineApi.dart';
import 'package:twiine/auth.dart';
import 'package:flutter/material.dart';
import 'package:twiine/components/Navbar.dart';
import 'package:twiine/screens/pre_login/landing_page.dart';

class LoginChecker extends StatefulWidget {
  @override
  LoginCheckerState createState() => LoginCheckerState();
}

class LoginCheckerState extends State<LoginChecker> {
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    if (user == null) {
      return LandingPage();
    } else {
      _updateUserData();
      return Navbar();
    }
  }

  void _updateUserData() async {
    var userData = await TwiineApi.getUserData(
        (await Auth.firebaseAuth.currentUser()).uid);
    Auth.userRecord = userData.data;
  }
}
