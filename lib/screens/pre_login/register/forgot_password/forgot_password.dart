import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/colors.dart';

class ForgotPassword extends StatelessWidget {

  BoxShadow _dropShadow = BoxShadow(
      color: Colors.grey.withOpacity(0.9),
      spreadRadius: -2,
      blurRadius: 6,
      offset: Offset(0, 4));

  double _dividerThickness = 2;
  double _buttonHeight = 50;
  double _buttonRadius = 15;

  String recoveryEmail;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Email",
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.transparent),
                            ),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (t) => recoveryEmail = t,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: _dividerThickness,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 10, 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(_buttonRadius),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: _buttonHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_buttonRadius),
                      color: TwiineColors.red,
                      boxShadow: [_dropShadow],
                    ),
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        "Recover Password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  onTap: _recoverPassword,
                )
                ,
              )
              ,
            ]
        )
    );
  }

  _recoverPassword() {
    print("email sent to $recoveryEmail");
    Auth.firebaseAuth.sendPasswordResetEmail(email: recoveryEmail);
  }
}