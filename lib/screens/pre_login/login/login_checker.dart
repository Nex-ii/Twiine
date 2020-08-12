import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:twiine/auth.dart';
import 'package:flutter/material.dart';
import 'package:twiine/components/navbar.dart';
import 'package:twiine/screens/pre_login/landing_page.dart';
import 'package:twiine/screens/pre_login/register/signup/create_account.dart';

class LoginChecker extends StatefulWidget {
  @override
  LoginCheckerState createState() => LoginCheckerState();
}

class LoginCheckerState extends State<LoginChecker> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    if (user == null) {
      return LandingPage();
    }else
      return Navbar();

//    return FutureBuilder<DocumentSnapshot>(
//        future: Firestore.instance.collection("Users").document(user.uid).get(),
//        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//          if (snapshot.hasData) {
//            if(snapshot.data.data == null)
//              return CreateAccount();
//            else
//              return Navbar();
//          } else {
//            return Scaffold();
//          }
//        }
//    );
  }

}
