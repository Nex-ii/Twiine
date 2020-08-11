import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/common/TextForm.dart';

class ChangePassowrd extends StatefulWidget {
  @override
  // TODO: implement build
  State<StatefulWidget> createState() {
    return ChangePassowrdState();
  }
}

class ChangePassowrdState extends State<ChangePassowrd> {
  String _oldPassword;
  String _newPassword;
  String _confirmPassword;

  String _changePasswordMessage = "";

  // styling design variables
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

      Auth.firebaseAuth.currentUser().then((user) {
        user
            .reauthenticateWithCredential(EmailAuthProvider.getCredential(
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
      });
    };

    return TextForm.textForm([
      FormElement("Old Password", FormTypes.PASSWORDFIELD,
          validator: oldPasswordValidator, controller: _oldPasswordController),
      FormElement("New Password", FormTypes.PASSWORDFIELD,
          validator: newPasswordValidator, controller: _newPasswordController),
      FormElement("Confirm New Password", FormTypes.PASSWORDFIELD,
          validator: confirmNewPasswordValidator,
          controller: _confirmNewPasswordController),
    ], [
      ButtonElement("Continue", onContinueTap)
    ], _formKey, title: "Change Password", trailingSpacing: 30);
  }
}
