import 'package:twiine/auth.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/screens/post_login/profile/profile_elements/saved.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  File _image;

  Image profilePic;

  ProfileState() {
    _updateProfilePicture();
    Auth.updateUserData().then((value) => {
          setState(() {
            _updateProfilePicture();
          })
        });
  }

  _updateProfilePicture() {
    profilePic = (Auth.userData.containsKey("pictureUrl"))
        ? Image.network(Auth.userData["pictureUrl"])
        : Image.asset("assets/default_profile.png");
  }

  //TODO: Ask for permission to access the gallery
  Future getImage(BuildContext context) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    uploadPic(context);
  }

  Future uploadPic(BuildContext context) async {
    final _storage = FirebaseStorage.instance;
    var snapshot = await _storage
        .ref()
        .child('ImageStorage/ProfilePicture')
        .putFile(_image)
        .onComplete;

    var downloadUrl = await snapshot.ref.getDownloadURL();

    setState(() {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      profilePic = Image.network(downloadUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    String name = "${Auth.userData["firstname"]} ${Auth.userData["lastname"]}";
    String email = Auth.userData["email"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 25, backgroundImage: profilePic.image),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name != null ? name : "",
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  email != null ? email : "",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              _labelText("ACCOUNT"),
              _createButton(Icons.account_circle, "Edit Profile", () => {_toManage()}),
              _createButton(Icons.notifications, "Notifications", () => {}),
              _createButton(
                  Icons.bookmark,
                  "Saved",
                  () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Saved()),
                        )},),
              _labelText("SUPPORT"),
              _createButton(Icons.help_outline, "Get Help", () => {}),
              _createButton(
                  Icons.question_answer, "Give us Feedback", () => {}),
              _labelText("ABOUT"),
              _createButton(Icons.content_copy, "Terms and Conditions", () => {_toTerms()}),
              _createButton(Icons.lock_open, "Privacy Policy", () => {}),
              _createButton(
                  Icons.exit_to_app, "Sign out", () => {Auth.signOut()}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _labelText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: TwiineColors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buttonText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        height: 1.5,
        color: TwiineColors.grey,
      ),
    );
  }

  Widget _createButton(IconData icon, String text, Function onTap) {
    return SizedBox(
      height: 60,
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(width: 10),
            Expanded(flex: 1, child: _buttonText(text)),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  _toManage() {
    Navigator.of(context).pushNamed('/manage');
  }

  _toTerms() {
    Navigator.of(context).pushNamed('/toc');
  }
}
