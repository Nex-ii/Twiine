import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/common/text_form.dart';

class ChangePassword extends StatefulWidget {
  @override
  // TODO: implement build
  State<StatefulWidget> createState() {
    return ChangePasswordState();
  }
}

class ChangePasswordState extends State<ChangePassword> {
  String _oldPassword;
  String _newPassword;
  String _confirmPassword;
  Stream _authStream = Auth.firebaseAuth.authStateChanges();

  // styling design variables
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _changePasswordMessage = "";

  static TextEditingController _oldPasswordController = TextEditingController();
  static TextEditingController _newPasswordController = TextEditingController();
  static TextEditingController _confirmNewPasswordController =
      TextEditingController();

  static Function oldPasswordValidator;
  static Function newPasswordValidator;
  static Function confirmNewPasswordValidator;
  static Function onContinueTap;

  @override
  Widget build(BuildContext context) {
    oldPasswordValidator = (String value) {
      if (value.isEmpty) {
        return 'Old Password is Required';
      }
    };

    newPasswordValidator = (String value) {
      if (value.isEmpty) {
        return 'New Password is Required';
      }
    };

    confirmNewPasswordValidator = (String value) {
      if (value.isEmpty) {
        return 'Password New Confirmation is Required';
      }
      if (value != _newPassword) {
        return 'Passwords Do Not Match';
      }
    };

    onContinueTap = () {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();

      StreamSubscription<User> subscription;
      subscription = _authStream.listen((user) {
        user
            .reauthenticateWithCredential(EmailAuthProvider.credential(
                email: user.email, password: _oldPassword))
            .catchError((error) {
          setState(() {
            _changePasswordMessage = "Unable to change password";
          });
        }).then((result) {
          if (result != null) {
            user.updatePassword(_confirmPassword);
            setState(() {
              _changePasswordMessage = "Successfully changed password";
            });
          }
        });
        // we only need to listen for this once
        subscription.cancel();
      });
    };

    return Scaffold(
        appBar: AppBar(
          title: SafeArea(
            child: Text(
              "Change Password",
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
        body: TextForm.textForm([
          FormElement("Old Password", FormTypes.PASSWORDFIELD,
              validator: oldPasswordValidator, controller: _oldPasswordController),
          FormElement("New Password", FormTypes.PASSWORDFIELD,
              validator: newPasswordValidator, controller: _newPasswordController),
          FormElement("Confirm New Password", FormTypes.PASSWORDFIELD,
              validator: confirmNewPasswordValidator,
              controller: _confirmNewPasswordController),
        ], [
          ButtonElement("Continue", onContinueTap)
        ], _formKey,));
    }
}
