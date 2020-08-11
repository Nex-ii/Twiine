import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:twiine/common/TextForm.dart';
import 'package:twiine/twiine_api.dart';
import 'package:twiine/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateAccountState();
  }
}

class CreateAccountState extends State<CreateAccount> {

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static TextEditingController _firstNameController = TextEditingController();
  static TextEditingController _lastNameController = TextEditingController();
  static TextEditingController _birthdayController = TextEditingController();
  static TextEditingController _emailController = TextEditingController();
  static TextEditingController _passwordController = TextEditingController();
  static TextEditingController _confirmPasswordController = TextEditingController();

  static Function passwordValidator;
  static Function confirmPasswordValidator;
  static Function onContinueTap;

  @override
  Widget build(BuildContext context) {
    passwordValidator = (String value) {
      if (value.isEmpty) {
        return 'Password is Required';
      }
      if (value.length < 6) {
        return 'Password must be at least 6 characters long';
      }
      return null;
    };

    confirmPasswordValidator = (String value) {
      if (value.isEmpty) {
        return 'Password Confirmation is Required';
      }
      if (_confirmPasswordController.text != _passwordController.text) {
        return 'Passwords have to match';
      }
      return null;
    };

    onContinueTap = () {
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
          if (Auth().user != null)
            {
              setEmailLoginPreferences(
                true,
                "email",
                _emailController.text,
                _passwordController.text,
              ),
              navigate(context),
            },
        },
      );
    };

    Widget w = TextForm.textForm([
      FormElement("First Name", FormTypes.TEXTFIELD,
          controller: _firstNameController),
      FormElement("Last Name", FormTypes.TEXTFIELD,
          controller: _lastNameController),
      FormElement("Birthday", FormTypes.DATEFIELD,
          controller: _birthdayController),
      FormElement("Email", FormTypes.EMAILFIELD, controller: _emailController),
      FormElement("Password", FormTypes.PASSWORDFIELD,
          controller: _passwordController, validator: passwordValidator),
      FormElement("Confirm Password", FormTypes.PASSWORDFIELD,
          controller: _confirmPasswordController, validator: confirmPasswordValidator),
    ],
        [ButtonElement("Continue", onContinueTap)], _formKey, title: "Join the Twiine Community", trailingSpacing: 30);

    return w;
  }

  static Future<void> _registerUser(Map<String, String> data) async {
    try {
      var credential = await Auth.firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Auth.user = credential.user;
    } catch (error) {
      print("Unable to create account: ${error.toString()}");
    }
    try {
      return TwiineApi.createNewUser(data);
    } catch (error) {
      print("API call error: ${error.toString()}");
    }
  }

  static setEmailLoginPreferences(bool hasLoggedIn, String loginMethod,
      String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("hasLoggedIn", hasLoggedIn);
    prefs.setString("loginMethod", loginMethod);
    prefs.setString("username", username);
    prefs.setString("password", password);
  }

  static navigate(BuildContext context){
    Navigator.of(context).pushNamed('/navBar');
  }
}
