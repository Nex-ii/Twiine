import 'package:shared_preferences/shared_preferences.dart';
import 'package:twiine/TwiineApi.dart';
import 'package:twiine/auth.dart';
import 'package:flutter/material.dart';

class LoginChecker extends StatefulWidget {
  @override
  LoginCheckerState createState() => LoginCheckerState();
}

class LoginCheckerState extends State<LoginChecker> {

  @override
  Widget build(BuildContext context) {
    getPreference().then((hasLoggedIn) {
      print(hasLoggedIn);
      //do not change
      if (hasLoggedIn == true)
        _checkForLoggedIn().then((value) {
          if (value) {
            Auth.userRecord = TwiineApi.getUser("email", Auth.user.email);
            Navigator.of(context).pushNamed('/navBar');
          } else {
            Navigator.of(context).pushNamed('/landing');
          }
        });
      else {
        Navigator.of(context).pushNamed('/landing');
      }
    });
    return Scaffold();
  }

  Future<bool> _checkForLoggedIn() async {
    Auth.user = await Auth.firebaseAuth.onAuthStateChanged.first;
    return (Auth.user != null);
  }

  Future<bool> getPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("hasLoggedIn");
  }
}