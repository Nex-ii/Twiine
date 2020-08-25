import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/common/text_form.dart';
import 'file:///D:/CS/Flutter/twiine/lib/screens/pre_login/login/forgot_password.dart';

class LoginEmail extends StatefulWidget {
  @override
  LoginEmail({Key key}) : super(key: key);

  LoginEmailState createState() => LoginEmailState();
}

class LoginEmailState extends State<LoginEmail> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _loginMessage = "";

  static Function passwordValidator;
  static Function onContinueTap;

  @override
  void initState() {
    super.initState();
    Auth.firebaseAuth.authStateChanges().listen((user) {
      print("logged in: " + user.toString());
      if (user != null) {
        print("logged in");
        Navigator.of(context).popUntil(ModalRoute.withName('/'));
      } else
        setState(() {
          _loginMessage = "Unable to authenticate with email";
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    // subscribe to auth changes
    passwordValidator = (String value) {
      if (value.isEmpty) {
        return 'Password is Required';
      }
      if (value.length < 6) {
        return 'Password must be at least 6 characters long';
      }
      return null;
    };

    return TextForm.textForm([
      FormElement("Email", FormTypes.EMAILFIELD, controller: _emailController),
      FormElement("Password", FormTypes.PASSWORDFIELD,
          validator: passwordValidator, controller: _passwordController),
      FormElement("Forgot Password?", FormTypes.INKWELL,
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => ForgotPassword()))),
    ], [
      ButtonElement("Continue", _signInWithEmail),
    ], GlobalKey(),
        appBar: TextForm.backBar(context),
        title: "Sign in to twiine",
        trailingSpacing: 0);
  }

  _signInWithEmail() async {
    try {
      Auth.signInEmail(_emailController.text, _passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
