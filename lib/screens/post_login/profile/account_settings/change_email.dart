import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/screens/post_login/profile/account_settings/change_password.dart';

class ChangeEmail extends StatefulWidget {
  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SafeArea(
          child: Text(
            "Change Email",
            style: TextStyle(color: Colors.black),
            ),
          ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 60,
        leading: SafeArea(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
       ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: RichText(
                  text: new TextSpan(
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      new TextSpan(text: "Current Email Address:\n"),
                      new TextSpan(text: Auth.currentUser.data['email'], style: TextStyle(color: Colors.red),)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "What would you like to change it to?",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 5.0),
                ),
                hintText: "Email",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
