import 'package:flutter/material.dart';
import 'package:twiine/screens/create_account/create_account.dart';
import 'package:twiine/screens/forgot_password/forgot_password.dart';
import 'package:twiine/screens/login/login.dart';
import 'package:twiine/screens/home/home.dart';

void main() => runApp(App());

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twiine',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => Login(),
        '/home' : (context) => Home(),
        '/forgot_password' : (context) => ForgotPassword(),
        '/create_account' : (context) => CreateAccount(),
      },
    );
  }
}