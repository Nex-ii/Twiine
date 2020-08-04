import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twiine/TwiineApi.dart';
import 'package:twiine/auth.dart';

class SignUp extends StatefulWidget {
  @override
  // TODO: implement build
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  String _firstName;

  String _lastName;
  String _birthday;
  String _email;
  String _password;
  String _confirmPassword;

  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _selectDate(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: new DateTime.now(),
            firstDate: new DateTime(2016),
            lastDate: new DateTime(2021))
        .then((date) {
      if (date != null) setState(() => _birthday = date.toString());
    });
  }

  // Title Widget
  Widget _buildTitle() {
    return Text(
      "Join the Twiine Community",
      style: TextStyle(height: 5, fontSize: 25, fontWeight: FontWeight.bold),
    );
  }

  // TextFormField Widgets
  Widget _buildFirstName() {
    return TextFormField(
      initialValue: _firstName,
      decoration: InputDecoration(labelText: 'First Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'First Name is Required';
        }
      },
      onSaved: (String value) {
        _firstName = value;
      },
    );
  }

  Widget _buildLastName() {
    return TextFormField(
      initialValue: _lastName,
      decoration: InputDecoration(labelText: 'Last name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Last Name is Required';
        }
      },
      onSaved: (String value) {
        _lastName = value;
      },
    );
  }

  Widget _buildBirthday() {
    return TextFormField(
      initialValue: _birthday,
      decoration: InputDecoration(
          labelText: 'Birthday (MM/DD/YYYY)', hintText: "Example: 01/01/1990"),
      keyboardType: TextInputType.datetime,
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
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      initialValue: _email,
      decoration: InputDecoration(labelText: 'Email'),
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
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      initialValue: _password,
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required';
        }
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _buildConfirmPassword() {
    return TextFormField(
      initialValue: _confirmPassword,
      decoration: InputDecoration(labelText: 'Confirm Password'),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password Confirmation is Required';
        }
      },
      onSaved: (String value) {
        _confirmPassword = value;
      },
    );
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
      body: Container(
        margin: EdgeInsets.all(24),
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
                SizedBox(height: 100),
                ButtonTheme(
                  minWidth: 300.0,
                  height: 50.0,
                  buttonColor: Colors.red,
                  child: RaisedButton(
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
                            setPreference();
                            Navigator.of(context).pushNamed('/navBar');
                          }
                        });
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("hasLoggedIn", true);
  }
}
