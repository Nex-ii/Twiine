import 'package:flutter/material.dart';
import 'package:twiine/screens/pre_login/LoginChecker.dart';
import 'package:twiine/screens/pre_login/register/create_account/create_account.dart';
import 'package:twiine/screens/pre_login/register/forgot_password/forgot_password.dart';
import 'package:twiine/screens/pre_login/landing_page.dart';
import 'package:twiine/screens/pre_login/login/login.dart';
import 'package:twiine/screens/pre_login/login/login_basic/login_basic.dart';
import 'package:twiine/screens/pre_login/login/login_facebook/login_facebook.dart';
import 'package:twiine/screens/pre_login/register/register_email/register_email.dart';
import 'package:twiine/screens/pre_login/register/register_phone/register_phone.dart';
import 'package:twiine/components/Navbar.dart';
import 'package:twiine/screens/post_login/profile/profile.dart';
import 'package:twiine/screens/post_login/home/home.dart';
import 'package:twiine/screens/post_login/addEvent/AddEvent.dart';
import 'package:twiine/colors.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twiine',
      theme: ThemeData(
        fontFamily: 'Acumin Pro',
        primaryColor: TwiineColors.red,
        accentColor: TwiineColors.orange,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginChecker(),
        '/landing': (context) => LandingPage(),
        '/login': (context) => Login(),
        '/login_basic': (context) => LoginBasic(),
        '/login_facebook': (context) => LoginFacebook(),
        '/register_email': (context) => RegisterEmail(),
        '/register_phone': (context) => RegisterPhone(),
        '/forgot_password': (context) => ForgotPassword(),
        '/create_account': (context) => CreateAccount(),
        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/navBar': (context) => Navbar(),
        '/addEvent': (context) => AddEvent(),
      },
    );
  }
}
