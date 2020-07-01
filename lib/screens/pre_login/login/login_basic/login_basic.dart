import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginBasic extends StatefulWidget{
  @override
  LoginBasic({Key key}) : super(key: key);
  LoginBasicState createState() => LoginBasicState();
}

class LoginBasicState extends State<LoginBasic> {

  String _loginMessage = "";

  final formKey = new GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final email_controller = TextEditingController(),
        password_controller = TextEditingController();

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
                    "Sign in to twiine",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )
                  )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 10, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 2
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: TextFormField(
                            decoration: new InputDecoration(
                              labelText: "Email",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              border: InputBorder.none
                            ),
                            keyboardType: TextInputType.text,
                            controller: email_controller,
                          )
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: _dividerThickness,
                                color: Colors.grey,
                              )
                            )
                          ]
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                          child: TextFormField(
                            obscureText: true,
                            decoration: new InputDecoration(
                              labelText: "Password",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              border: InputBorder.none
                            ),
                            controller: password_controller,
                          )
                        )
                      ]
                    )
                  )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    _loginMessage,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 10, 10),
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
                      _signInWithEmail()
                    }
                  )
                )
              ]
            )
          )
        ]
      )
    );
  }

  _signInWithEmail() async {
    FirebaseUser user = null;
    try {
      user = (await _auth.signInWithEmailAndPassword(
        email: email_controller.text,
        password: password_controller.text,
      )).user;
    }
    catch(error) {
      
    }
    setState(() {
      if (user != null) {
        _loginMessage = "Successfully authenticated with email";
      }
      else {
        _loginMessage = "Unable to authenticate with email";
      }
    });
  }
}