import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:twiine/login_checker.dart';
import 'package:provider/provider.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/screens/pre_login/landing_page.dart';
import 'package:twiine/screens/pre_login/login/login.dart';
import 'package:twiine/components/navbar.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/screens/pre_login/register/create_account.dart';


void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return FutureBuilder<Object>(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<User>.value(
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
                '/signup': (context) => CreateAccount(),
                '/navBar': (context) => Navbar(),
              },
            ),
          );
        }
        else
          return Container();
      }
    );
  }
}
