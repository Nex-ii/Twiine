import 'dart:io';
import 'package:flutter/material.dart';
import 'package:twiine/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:twiine/colors.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  double _cardRadius = 20.0;
  double _cardHeight = 290.0;
  double _cardWidth = 190.0;
  File _image;
  var _imageURL =
      'https://firebasestorage.googleapis.com/v0/b/twiine.appspot.com/o/ImageStorage%2FProfilePicture?alt=media&token=9958176c-3b7f-457f-935c-04ff166ffe15';

  //TODO: Ask for permission to access the gallery
  Future getImage(BuildContext context) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState((){
        _image=image;
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


	  setState((){
	    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      _imageURL = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage:
                  Image.network("https://i.imgur.com/mNNGyWx.png").image,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${Auth.userData["firstname"]} ${Auth.userData["lastname"]}",
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  Auth.userData["email"],
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
                Icons.account_circle,
                "Manage Account Information",
                () => {},
              ),
              _createButton(Icons.notifications, "Notifications", () => {}),
              _createButton(Icons.bookmark, "Saved", () => {}),
              _labelText("SUPPORT"),
              _createButton(Icons.help_outline, "Get Help", () => {}),
              _createButton(
                  Icons.question_answer, "Give us Feedback", () => {}),
              _labelText("ABOUT"),
              _createButton(Icons.content_copy, "Terms of Use", () => {}),
              _createButton(Icons.lock_open, "Privacy Policy", () => {}),
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
}
