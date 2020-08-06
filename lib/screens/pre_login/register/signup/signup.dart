import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:twiine/TwiineApi.dart';
import 'package:twiine/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twiine/screens/pre_login/register/signup/date_picker.dart';

class SignUp extends StatefulWidget {
  @override
  // TODO: implement build
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      controller: _firstNameController,
      decoration: InputDecoration(labelText: 'First Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'First Name is Required';
        } else
          return null;
      },
    );
  }

  Widget _buildLastName() {
    return TextFormField(
      controller: _lastNameController,
      decoration: InputDecoration(labelText: 'Last name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Last Name is Required';
        } else
          return null;
      },
    );
  }

  Widget _buildBirthday() {
    return DatePickerField(controller: _birthdayController);
  }

  Widget _buildEmail() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Valid Email is Required';
        }
        if (!isValidEmail(value)) {
          return 'Valid Email Address Required';
        } else
          return null;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required';
        } else
          return null;
      },
    );
  }

  Widget _buildConfirmPassword() {
    return TextFormField(
      controller: _confirmPasswordController,
      decoration: InputDecoration(labelText: 'Confirm Password'),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password Confirmation is Required';
        }
        if (_confirmPasswordController.text != _passwordController.text) {
          return 'Passwords have to match';
        } else
          return null;
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
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(input);
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
                        'firstname': _firstNameController.text,
                        'lastname': _lastNameController.text,
                        'birthday': _birthdayController.text,
                        'email': _emailController.text,
                      };
                      _registerUser(data).then(
                        (value) => {
                          if (Auth.user != null)
                            {
                              setEmailLoginPreferences(
                                true,
                                "email",
                                _emailController.text,
                                _passwordController.text
                              ),
                              Navigator.of(context).pushNamed('/navBar')
                            }
                        },
                      );
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

  Future<void> _registerUser(Map<String, String> data) async {
    try {
      var credential = await Auth.firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Auth.user = credential.user;
    } catch (error) {
      print("Unable to create account: ${error.toString()}");
    }
    try {
      return TwiineApi.createNewUser(data);
    } catch (error) {
      print("API call error: ${error.toString()}");
    }
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
