import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() =>LoginState();
}

class LoginState extends State<Login>{

  BoxShadow _dropShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.9),
    spreadRadius: -2,
    blurRadius: 6,
    offset: Offset(0, 4)
  );
  double _dividerThickness = 2;
  double _buttonHeight = 50;
  double _buttonRadius = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget> [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 10, 0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome to twiine",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )
                  )
                ),
                TextField(
                  decoration: new InputDecoration(labelText: "Phone Number"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ]
                ),
                Padding(
                  padding: EdgeInsets.all(50),
                  child: Text(
                    "[Terms and conditions statement]",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey
                    )
                  )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 50),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(_buttonRadius),
                    child: Container(
                      width: MediaQuery. of(context).size.width,
                      height: _buttonHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_buttonRadius),
                        color: Colors.red,
                        boxShadow: [ _dropShadow ]
                      ),
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          )
                        )
                      )
                    ),
                    onTap: () => {
                      Navigator.of(context).pushNamed('/login')
                    }
                  )
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        thickness: _dividerThickness
                      )
                    ),       
                    Text(
                      " or ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: _dividerThickness
                      )
                    )
                  ]
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(_buttonRadius),
                    child: Container(
                      width: MediaQuery. of(context).size.width,
                      height: _buttonHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_buttonRadius),
                        color: Colors.white,
                        boxShadow: [ _dropShadow ]
                      ),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget> [
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.facebook),
                            padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                            onPressed: null,
                          ),
                          Text(
                            "Continue with Facebook",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            )
                          )
                        ]
                      )
                    ),
                    onTap: () => {}
                  )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(_buttonRadius),
                    child: Container(
                      width: MediaQuery. of(context).size.width,
                      height: _buttonHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_buttonRadius),
                        color: Colors.white,
                        boxShadow: [ _dropShadow ]
                      ),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget> [
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.google),
                            padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                            onPressed: null,
                          ),
                          Text(
                            "Continue with Google",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            )
                          )
                        ]
                      )
                    ),
                    onTap: () => {}
                  )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(_buttonRadius),
                    child: Container(
                      width: MediaQuery. of(context).size.width,
                      height: _buttonHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_buttonRadius),
                        color: Colors.white,
                        boxShadow: [ _dropShadow ]
                      ),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget> [
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.apple),
                            padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                            onPressed: null,
                          ),
                          Text(
                            "Continue with Apple",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            )
                          )
                        ]
                      )
                    ),
                    onTap: () => {}
                  )
                )
              ]
            )
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