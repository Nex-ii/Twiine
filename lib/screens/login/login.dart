import 'package:flutter/material.dart';
import 'package:twiine/fonts/custom_icons.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() =>LoginState();
}

class LoginState extends State<Login>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget> [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purpleAccent, Colors.cyan]
              )
            )
          ),
          Center(
            child: Container(
              child: Text(
                "twiine",
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 50),
                  child: Container(
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 3,
                        color: Colors.white
                      ),
                      color: Colors.white
                    ),
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        "SIGN UP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black
                        ),
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 50),
                  child: Container(
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 3,
                        color: Colors.white
                      )
                    ),
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        "LOG IN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white
                        ),
                      ),
                    )
                  ),
                ),
              ],
            ),
          )
        ]
      )
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