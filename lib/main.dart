import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/screens/post_login/profile/settings.dart';
import 'package:twiine/screens/pre_login/LoginChecker.dart';
import 'package:twiine/screens/pre_login/landing_page.dart';
import 'package:twiine/screens/pre_login/login/login.dart';
import 'package:twiine/components/Navbar.dart';
import 'package:twiine/screens/post_login/profile/profile.dart';
import 'package:twiine/screens/post_login/plans/plans.dart';
import 'package:twiine/screens/post_login/addEvent/AddEvent.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/screens/pre_login/login/login_email.dart';
import 'package:twiine/screens/pre_login/register/forgot_password/forgot_password.dart';
import 'package:twiine/screens/pre_login/register/signup/create_account.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: Auth().user,
      child: new MaterialApp(
        title: 'Twiine',
        theme: ThemeData(
          fontFamily: 'Acumin Pro',
          primaryColor: TwiineColors.red,
          accentColor: TwiineColors.orange,
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
            headline2: TextStyle(
              fontSize: 24,
              color: Colors.black
            ),
            headline3: TextStyle(
              fontSize: 16,
              color: Colors.black
            ),
            bodyText1: TextStyle(
              fontSize: 12,
              color: Colors.black
            ),
            bodyText2: TextStyle(
              fontSize: 12,
              color: TwiineColors.lightGrey2
            ),
          )
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginChecker(),
          '/landing': (context) => LandingPage(),
          '/login': (context) => Login(),
          '/login_email': (context) => LoginEmail(),
          '/signup': (context) => CreateAccount(),
          '/plans': (context) => PlansPage(),
          '/profile': (context) => Profile(),
          '/forgotPassword': (context) => ForgotPassword(),
          '/navBar': (context) => Navbar(),
          '/addEvent': (context) => AddEvent(),
          '/settings': (context) => Settings(),
        },
      ),
<<<<<<< HEAD
=======
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginChecker(),
        '/landing': (context) => LandingPage(),
        '/login': (context) => Login(),
        '/signup': (context) => CreateAccount(),
        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/forgotPassword': (context) => ForgotPassword(),
        '/navBar': (context) => Navbar(),
        '/addEvent': (context) => AddEvent(),
        '/settings': (context) => Settings(),
      },
>>>>>>> edit_hangout
    );
  }
}
