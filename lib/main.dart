import 'package:flutter/material.dart';
import 'package:twiine/screens/create_account/create_account.dart';
import 'package:twiine/screens/forgot_password/forgot_password.dart';
import 'package:twiine/screens/login/landing_page.dart';
import 'package:twiine/screens/login/login.dart';
import 'package:twiine/screens/home/home.dart';
import 'package:twiine/screens/login_basic/login_basic.dart';
import 'package:twiine/screens/login_facebook/login_facebook.dart';
import 'package:twiine/screens/register_email/register_email.dart';
import 'package:twiine/screens/register_phone/register_phone.dart';
import 'package:twiine/screens/profile/profile.dart';
import 'package:twiine/components/Navbar.dart';

void main() => runApp(App());

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twiine',
      theme: ThemeData(fontFamily: 'Acumin Pro'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => LandingPage(),
        '/login' : (context) => Login(),
        '/login_basic' : (context) => LoginBasic(),
        '/login_facebook' : (context) => LoginFacebook(),
        '/register_email' : (context) => RegisterEmail(),
        '/register_phone' : (context) => RegisterPhone(),
        '/forgot_password' : (context) => ForgotPassword(),
        '/create_account' : (context) => CreateAccount(),
        '/home' : (context) => Home(),
        '/profile' : (context) => Profile(),
        '/navBar' : (context) => Navbar(),
      },
    );
  }
}