import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/screens/pre_login/login/login.dart';

import 'login/login_methods.dart';

class LandingPage extends StatefulWidget {
  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {

  @override
  void initState(){
    super.initState();
    rememberLogin();
  }

  rememberLogin() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool hasLoggedIn = prefs.getBool("hasLoggedIn");
    String loginMethod = prefs.getString("loginMethod");
    String username = prefs.getString("username");
    String password = prefs.getString("password");

    if (hasLoggedIn == true) {
      switch (
      LoginMethodsUtils.stringToEnum(loginMethod)) {
        case LoginMethods.phone:
          _failedLogin(context);
          break;
        case LoginMethods.facebook:
          FacebookLogin().logIn(['email']).then((facebookResult) {
                Auth.firebaseAuth
                    .signInWithCredential(FacebookAuthProvider.getCredential(
                  accessToken: facebookResult.accessToken.token,
                )).catchError((error) {
                  _failedLogin(context);
                }).then((firebaseResult) {
                  if (firebaseResult != null) {
                    Auth.user = firebaseResult.user;
                    _successfulLogin(context);
                  }
                });
          });
          break;
        case LoginMethods.google:
          GoogleSignIn(scopes: ['email']).signIn().catchError((error) {
            _failedLogin(context);
          }).then((account) {
            account.authentication.then((authentication) {
              Auth.firebaseAuth
                  .signInWithCredential(GoogleAuthProvider.getCredential(
                  idToken: authentication.idToken,
                  accessToken: authentication.idToken))
                  .then((result) {
                if (result != null) {
                  _successfulLogin(context);
                  Auth.user = result.user;
                }
              });
            });
          });
          break;
        case LoginMethods.email:
          FirebaseAuth.instance
              .signInWithEmailAndPassword(
            email: username,
            password: password,
          ).catchError((error) {
            _failedLogin(context);
          }).then((result) {
            if (result != null) _successfulLogin(context);
            Auth.user = result.user;
          });
          break;
        default:
          break;
      }
    }
  }

  _failedLogin(BuildContext context) {
    Navigator.pushNamed(context, "/");
  }

  _successfulLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, "/navBar", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purpleAccent, Colors.cyan],
              ),
            ),
          ),
          Center(
            child: Container(
              child: Text(
                "twiine",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 50),
                  child: InkWell(
                    child: Container(
                      width: 150,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          width: 3,
                          color: Colors.white,
                        ),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "SIGN UP",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    onTap: () => {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 50),
                  child: InkWell(
                    child: Container(
                      width: 150,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          width: 3,
                          color: Colors.white,
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "LOG IN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    onTap: () => {Navigator.of(context).pushNamed('/login')},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
