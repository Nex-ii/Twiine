import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:twiine/TwiineApi.dart';
import 'package:twiine/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/screens/pre_login/register/signup/date_picker.dart';

class CreateAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateAccountState();
  }
}

class CreateAccountState extends State<CreateAccount> {
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

  var _border = OutlineInputBorder(borderRadius: BorderRadius.circular(15.0));
  var _focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: TwiineColors.red),
    borderRadius: BorderRadius.circular(25.0),
  );

  // TextFormField Widgets
  Widget _buildFirstName() {
    return TextFormField(
      controller: _firstNameController,
      decoration: InputDecoration(
        labelText: 'First Name',
        border: _border,
        focusedBorder: _focusedBorder,
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'First Name is Required';
        }
        return null;
      },
    );
  }

  Widget _buildLastName() {
    return TextFormField(
      controller: _lastNameController,
      decoration: InputDecoration(
        labelText: 'Last name',
        border: _border,
        focusedBorder: _focusedBorder,
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Last Name is Required';
        }
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
      decoration: InputDecoration(
        labelText: 'Email',
        border: _border,
        focusedBorder: _focusedBorder,
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Valid Email is Required';
        }
        if (!isValidEmail(value)) {
          return 'Valid Email Address Required';
        }
        return null;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        border: _border,
        focusedBorder: _focusedBorder,
      ),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPassword() {
    return TextFormField(
      controller: _confirmPasswordController,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        border: _border,
        focusedBorder: _focusedBorder,
      ),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password Confirmation is Required';
        }
        if (_confirmPasswordController.text != _passwordController.text) {
          return 'Passwords have to match';
        }
        return null;
      },
    );
  }

  // validation functions
  bool isValidEmail(String input) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildTitle(),
                    _buildFirstName(),
                    _buildLastName(),
                    _buildBirthday(),
                    _buildEmail(),
                    _buildPassword(),
                    _buildConfirmPassword(),
                    SizedBox(height: 70),
                    ButtonTheme(
                      minWidth: 300.0,
                      height: 50.0,
                      buttonColor: Colors.red,
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
                                    _passwordController.text,
                                  ),
                                  Navigator.of(context).pushNamed('/navBar'),
                                },
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
