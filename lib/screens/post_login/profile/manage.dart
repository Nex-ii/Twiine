import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twiine/auth.dart';

class Manage extends StatefulWidget {
  @override
  _ManageState createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile Information'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "First Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            Container(
              child: MyTextFormField(
                hintText: Auth.currentUser.data["firstname"],
                validator: (String value) {
                  return;
                },
                onSaved: (String value) async {
                  if (value.isEmpty) {
                    return null;
                  }
                  var firebaseUser = await FirebaseAuth.instance.currentUser;
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(firebaseUser.uid)
                      .update({"firstname": value});
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "Last Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            Container(
              child: MyTextFormField(
                hintText: Auth.currentUser.data["lastname"],
                validator: (String value) {
                  return;
                },
                onSaved: (String value) async {
                  if (value.isEmpty) {
                    return null;
                  }
                  var firebaseUser = await FirebaseAuth.instance.currentUser;
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(firebaseUser.uid)
                      .update({"lastname": value});
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            Container(
              child: MyTextFormField(
                hintText: Auth.currentUser.data["email"],
                validator: (String value) {
                  return;
                },
                onSaved: (String value) async {
                  if (value.isEmpty) {
                    return null;
                  }
                  var firebaseUser = await FirebaseAuth.instance.currentUser;
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(firebaseUser.uid)
                      .update({"email": value});
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "Birthday",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            Container(
              child: MyTextFormField(
                hintText: Auth.currentUser.data["birthday"],
                validator: (String value) {
                  return;
                },
                onSaved: (String value) async {
                  if (value.isEmpty) {
                    return null;
                  }
                  var firebaseUser = await FirebaseAuth.instance.currentUser;
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(firebaseUser.uid)
                      .update({"birthday": value});
                },
              ),
            ),
            RaisedButton(
              color: Colors.blueAccent,
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  Auth.updateUserData();
                  print("saved");
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isEmail;

  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
