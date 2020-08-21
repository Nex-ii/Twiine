import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/common/text_form.dart';

class LoginEmail extends StatefulWidget {
  @override
  LoginEmail({Key key}) : super(key: key);

  LoginEmailState createState() => LoginEmailState();
}

class LoginEmailState extends State<LoginEmail> {
  String _loginMessage = "";
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  static Function passwordValidator;
  static Function onContinueTap;

  @override
  void initState() {
    // subscribe to auth changes
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
    passwordValidator = (String value) {
      if (value.isEmpty) {
        return 'Password is Required';
      }
      if (value.length < 6) {
        return 'Password must be at least 6 characters long';
      }
      return null;
    };

    AppBar bar = AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Text(''),
      toolbarHeight: 30,
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back_ios),
        color: Colors.black,
        onPressed: () => Navigator.pop(context),
      ),
    );

    return TextForm.textForm([
      FormElement("Email", FormTypes.EMAILFIELD, controller: _emailController),
      FormElement("Password", FormTypes.PASSWORDFIELD,
          validator: passwordValidator, controller: _passwordController),
      FormElement("Forgot Password?", FormTypes.INKWELL,
          onTap: () => Navigator.pushNamed(context, '/forgotPassword')),
    ], [
      ButtonElement("Continue", _signInWithEmail),
    ], GlobalKey(),
        appBar: bar, title: "Sign in to twiine", trailingSpacing: 0);
  }

  _signInWithEmail() async {
    try {
      await Auth.signInEmail(_emailController.text, _passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
