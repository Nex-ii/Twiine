import 'package:flutter/material.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/colors.dart';

class EditProfile extends StatefulWidget {
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  double _fontSize = 15;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SafeArea(
          child: Text(
            "Account settings",
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
            SizedBox(height: 30),
            CircleAvatar(
              radius: 50,
              backgroundImage: Auth.currentUser.profilePicture.image,
            ),
            SizedBox(height: 20),
            _createButton(
              "Name",
              "${Auth.currentUser.data["firstname"]} ${Auth.currentUser.data["lastname"]}",
              () {},
            ),
            Divider(height: 3, thickness: 1, indent: 10, endIndent: 10),
            _createButton("Email", "${Auth.currentUser.data["email"]}", () {}),
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
