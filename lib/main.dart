import 'package:flutter/material.dart';
import 'package:twiine/screens/post_login/profile/change_password.dart';
import 'package:twiine/screens/post_login/profile/settings.dart';
import 'file:///D:/CS/Flutter/twiine/lib/screens/pre_login/login/login_checker.dart';
import 'package:twiine/screens/pre_login/landing_page.dart';
import 'package:twiine/screens/pre_login/login/login.dart';
import 'package:twiine/components/navbar.dart';
import 'package:twiine/screens/post_login/profile/profile.dart';
import 'package:twiine/screens/post_login/home/home.dart';
import 'package:twiine/screens/post_login/addEvent/AddEvent.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/screens/pre_login/register/create_account/create_account.dart';
import 'package:twiine/screens/pre_login/register/forgot_password/forgot_password.dart';


void main() =>  runApp(App());

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
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
        '/signup': (context) => CreateAccount(),

        '/changePassword': (context) => ChangePassowrd(),

        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/forgotPassword' : (context) => ForgotPassword(),
        '/navBar': (context) => Navbar(),
        '/addEvent': (context) => AddEvent(),
        '/settings': (context) => Settings(),
      },
    );
  }
}
