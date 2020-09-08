import 'package:flutter/material.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/screens/post_login/profile/edit_profile.dart';

class EditPrivacy extends StatefulWidget {
  @override
  _EditPrivacyState createState() => _EditPrivacyState();
}

class _EditPrivacyState extends State<EditPrivacy> {
  final double _fontSize = 15;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SafeArea(
          child: Text(
            "Security & Privacy",
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
          children: [
            _createButton("Email", Auth.currentUser.data["email"], () {}),
            Divider(height: 3, thickness: 1, indent: 10, endIndent: 10),
            _createButton("Birthdate", Auth.currentUser.data["birthday"], () {}),
            Divider(height: 3, thickness: 1, indent: 10, endIndent: 10),
            _createButton("Phone Number", "", () {}),
            Divider(height: 3, thickness: 1, indent: 10, endIndent: 10),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: InkWell(
                  child: Text(
                    "Reset Password",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  onTap: (){}
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createButton(String text, String subText, Function onTap) {
    return SizedBox(
      height: 50,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: _fontSize,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    subText,
                    style: TextStyle(
                      fontSize: (subText != "") ? _fontSize : 0,
                      color: TwiineColors.grey,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: _fontSize,
              ),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
