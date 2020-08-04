import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:twiine/TwiineApi.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/screens/pre_login/login/login_methods.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CreateAccount extends StatefulWidget {
  @override
  // TODO: implement build
  State<StatefulWidget> createState() {
    return CreateAccountState();
  }
}

class CreateAccountState extends State<CreateAccount> {
  // sign up form inputs
  String _firstName;
  String _lastName;
  String _birthday;
  String _email;
  String _password;
  String _confirmPassword;

  // styling design variables
  Color inputBoxColor = Colors.grey;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Title Widget
  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Text(
        "Join the Twiine Community",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }

  // TextFormField Widgets
  Widget _buildFirstName() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'First Name',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(25.0))),

        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'First Name is Required';
          }
        },
        onSaved: (String value) {
          _firstName = value;
        },
      ),
    );
  }

  Widget _buildLastName() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Last Name',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(25.0))),
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Last Name is Required';
          }
        },
        onSaved: (String value) {
          _lastName = value;
        },
      ),
    );
  }

  Widget _buildBirthday() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Birthday (MM/DD/YYYY)',
            hintText: "Example: 01/01/1990",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(25.0))),
        keyboardType: TextInputType.datetime,
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Birthday is Required';
          }
          if (!isValidDate(value)) {
            return 'Valid Input is Required';
          }
        },
        onSaved: (String value) {
          _birthday = value;
        },
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Email',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(25.0))),
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Valid Email is Required';
          }
          if (!isValidEmail(value)) {
            return 'Valid Email Address Required';
          }
        },
        onSaved: (String value) {
          _email = value;
        },
      ),
    );
  }

  Widget _buildPassword() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Password',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(25.0))),
        obscureText: true,
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Password is Required';
          }
        },
        onSaved: (String value) {
          _password = value;
        },
      ),
    );
  }

  Widget _buildConfirmPassword() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: 'Confirm Password',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(25.0))),
        obscureText: true,
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Password Confirmation is Required';
          }
          if (value != _password) {
            return 'Passwords Do Not Match';
          }
        },
        onSaved: (String value) {
          _confirmPassword = value;
        },
      ),
    );
  }

  Widget _buildTermsAndServices() {
    return InkWell(
        child: Text('[terms and conditions statement]',
            style: TextStyle(color: inputBoxColor)),
        onTap: () {
          // add terms and services page here
        });
  }

  // validation functions
  bool isValidDate(String input) {
    try {
      List<String> partitionedBirthday = input.split("/");
      String reformattedBirthday = partitionedBirthday[2] +
          partitionedBirthday[0] +
          partitionedBirthday[1];
      final date = DateTime.parse(reformattedBirthday);
      final originalFormatString = toOriginalFormatString(date);
      return reformattedBirthday == originalFormatString;
    } catch (e) {
      return false;
    }
  }

  String toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    return "$y$m$d";
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
              onPressed: () => Navigator.of(context).pop()
          )
      ),
        body: Container(
              margin: EdgeInsets.only(left: 24, right: 24),
              child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildTitle(),
                          _buildFirstName(),
                          _buildLastName(),
                          _buildBirthday(),
                          _buildEmail(),
                          _buildPassword(),
                          _buildConfirmPassword(),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                                child: _buildTermsAndServices()),
                          ),
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
                                ]
                              ),
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

                                  var data = {
                                    'firstname': _firstName,
                                    'lastname': _lastName,
                                    'birthday': _birthday,
                                    'email': "$_email",
                                    'collection': "Users",
                                  };

                                  TwiineApi.createNewUser(data).catchError((error) {
                                    print("API call error " + error.toString());
                                  }).then((value) {
                                    Auth.firebaseAuth
                                        .createUserWithEmailAndPassword(
                                      email: _email,
                                      password: _password,
                                    )
                                        .catchError((error) {
                                      print("Unable to create account with email" +
                                          error.toString());
                                    }).then((credential) {
                                      if (credential != null) {
                                        Auth.user = credential.user;
                                        setEmailLoginPreferences(
                                            true, "email", _email, _password);
                                        Navigator.of(context).pushNamed('/navBar');
                                      }
                                    });
                                  });
                                },
                              ),
                            ),
                          )
              ]),
              )),
        ));
  }

  setEmailLoginPreferences(bool hasLoggedIn, String loginMethod,
      String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("hasLoggedIn", hasLoggedIn);
    prefs.setString("loginMethod", loginMethod);
    prefs.setString("username", username);
    prefs.setString("password", password);
  }
}
