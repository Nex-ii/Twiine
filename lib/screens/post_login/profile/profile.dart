import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twiine/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/screens/post_login/profile/account_settings.dart';
import 'package:twiine/screens/post_login/profile/profile_elements/saved.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  File _image;
  Image profilePic;

  ProfileState() {
    profilePic = Auth.currentUser.profilePicture;
    Auth.updateUserData().then((value) => {
          setState(() {
            profilePic = Auth.currentUser.profilePicture;
          })
        });
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

  final String settingsIcon = "assets/icons/settings_icon.svg";
  final String friendsIcon = "assets/icons/friends_icon.svg";
  final String savedIcon = "assets/icons/bookmark_icon.svg";
  final String helpIcon = "assets/icons/help_icon.svg";
  final String feedbackIcon = "assets/icons/feedback_icon.svg";
  final String termsIcon = "assets/icons/copy_icon.svg";
  final String privacyIcon = "assets/icons/no_lock_icon.svg";
  final double iconSize = 30;

  @override
  Widget build(BuildContext context) {
    String name =
        "${Auth.currentUser.data["firstname"]} ${Auth.currentUser.data["lastname"]}";
    String email = Auth.currentUser.data["email"];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
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
              _createButton(
                SvgPicture.asset(settingsIcon),
                "Account Settings",
                () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountSettings()),
                  )
                },
              ),
              _createButton(SvgPicture.asset(friendsIcon), "Friends", () => {}),
              _createButton(
                SvgPicture.asset(savedIcon),
                "Saved",
                () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Saved(),
                    ),
                  ),
                },
              ),
              SizedBox(height: 30),
              _labelText("SUPPORT"),
              _createButton(SvgPicture.asset(helpIcon), "Get Help", () => {}),
              _createButton(
                  SvgPicture.asset(feedbackIcon), "Give us Feedback", () => {}),
              SizedBox(height: 30),
              _labelText("ABOUT"),
              _createButton(
                  SvgPicture.asset(termsIcon), "Terms of Use", () => {}),
              _createButton(
                  SvgPicture.asset(privacyIcon), "Privacy Policy", () => {}),
              _createButton(
                  Icon(
                    Icons.exit_to_app,
                    size: iconSize,
                  ),
                  "Sign out",
                  () => {Auth.signOut()}),
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

  Widget _createButton(Widget icon, String text, Function onTap) {
    return SizedBox(
      height: 60,
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment(0.0, 0.0),
              child: SizedBox(
                height: iconSize,
                width: iconSize,
                child: icon,
              ),
            ),
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
}
