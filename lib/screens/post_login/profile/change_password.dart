import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/colors.dart';

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
  Color inputBoxColor = Colors.grey;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Title Widget
  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Text(
        "Change Password",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildOldPassword() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Old Password',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(25.0))),
        obscureText: true,
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Old Password is Required';
          }
        },
        onChanged: (String value) {
          _oldPassword = value;
        },
      ),
    );
  }

  Widget _buildNewPassword() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'New Password',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(25.0))),
        obscureText: true,
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'New Password is Required';
          }
        },
        onChanged: (String value) {
          _newPassword = value;
        },
      ),
    );
  }

  Widget _buildConfirmPassword() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Confirm New Password',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(25.0))),
        obscureText: true,
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Password New Confirmation is Required';
          }
          if (value != _newPassword) {
            return 'Passwords Do Not Match';
          }
        },
        onChanged: (String value) {
          _confirmPassword = value;
        },
      ),
    );
  }

  bool isValidEmail(String input) {
    if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(input)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(''),
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () => Navigator.of(context).pop())),
      body: Container(
        margin: EdgeInsets.only(left: 24, right: 24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTitle(),
                _buildOldPassword(),
                _buildNewPassword(),
                _buildConfirmPassword(),
                ButtonTheme(
                  minWidth: 300.0,
                  height: 50.0,
                  buttonColor: Colors.red,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 1.0,
                            offset: Offset(4.0, 2.0),
                          )
                        ]),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        _formKey.currentState.save();

                        Auth.user
                            .reauthenticateWithCredential(
                                EmailAuthProvider.getCredential(
                                    email: Auth.user.email,
                                    password: _oldPassword))
                            .catchError((error) {
                          setState(() {
                            _changePasswordMessage =
                                "Unable to change password";
                          });
                        }).then((result) {
                          if (result != null) {
                            Auth.user.updatePassword(_confirmPassword);
                            setState(() {
                              _changePasswordMessage =
                              "Successfully changed password";
                            });
                          }
                        });
                      },
                    ),
                  ),
                ),
                Text(
                  _changePasswordMessage,
                  style: TextStyle(color: TwiineColors.red, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
