import 'package:flutter/material.dart';
import 'package:twiine/fonts/custom_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() =>LoginState();
}

class LoginState extends State<Login>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Text(
              'Welcome to Twiine',
              style: TextStyle(height: 10, fontSize: 20),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 250.0,
                    child: OutlineButton(
                        onPressed: _navigate_to_facebook_login,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            Icon(
                              MyFlutterApp.facebook_squared,
                            ),
                            Text(' Login with Facebook'),
                          ],
                        )
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 250.0,
                    child: OutlineButton(
                      onPressed: _navigate_to_phone_register,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Icon(Icons.phone),
                          Text(' Register by phone number'),
                        ],
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 250.0,
                    child: OutlineButton(
                      onPressed: _navigate_to_email_register,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Icon(Icons.email),
                          Text(' Register with email'),
                        ],
                      ),
                    ),
                  ),
                  FlatButton(
                    child: Text('Already have an account? login here',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w300)),
                    onPressed: _navigate_to_basic_login,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _navigate_to_facebook_login(){
    Navigator.of(context).pushNamed('/login_facebook');
  }

  _navigate_to_phone_register(){
    Navigator.of(context).pushNamed('/register_phone');
  }

  _navigate_to_email_register(){
    Navigator.of(context).pushNamed('/register_email');
  }

  _navigate_to_basic_login(){
    Navigator.of(context).pushNamed('/login_basic');
  }

}