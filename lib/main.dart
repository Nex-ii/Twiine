import 'package:flutter/material.dart';
import 'package:twiine/screens/pre_login/landing_page.dart';
import 'package:twiine/screens/pre_login/login/login.dart';
import 'package:twiine/components/Navbar.dart';
import 'package:twiine/screens/post_login/profile/profile.dart';
import 'package:twiine/screens/post_login/home/home.dart';
import 'package:twiine/screens/post_login/addEvent/AddEvent.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/screens/pre_login/login/login_basic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twiine/screens/post_login/profile/settings.dart';

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
        '/': (context) => LandingPage(),
        '/login': (context) => Login(),
        '/login_basic': (context) => LoginBasic(),
        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/navBar': (context) => Navbar(),
        '/addEvent': (context) => AddEvent(),
        '/settings': (context) => Settings(),
        '/' : (context) => LandingPage(),
      },
    );
  }
}
