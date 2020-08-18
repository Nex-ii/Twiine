import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/screens/pre_login/login/phone_login.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  String _loginMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(''),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment(-1, -1),
                  child: Text(
                    "Welcome to Twiine",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                PhoneLogin(),
                SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Divider(thickness: 2)),
                      Text(
                        " or ",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      Expanded(child: Divider(thickness: 2))
                    ],
                  ),
                ),
                Text(
                  _loginMessage,
                  style: TextStyle(color: TwiineColors.red),
                ),
                SizedBox(height: 30),
                _createLoginButton(
                  FaIcon(FontAwesomeIcons.envelope),
                  "Continue with Email",
                  () => {Navigator.pushNamed(context, "/login_email")},
                ),
                SizedBox(height: 5),
                _createLoginButton(
                  FaIcon(FontAwesomeIcons.facebook),
                  "Continue with Facebook",
                  () async => {
                    await Auth.signInFacebook(),
                    _updateMessage("Facebook"),
                  },
                ),
                SizedBox(height: 5),
                _createLoginButton(
                  FaIcon(FontAwesomeIcons.google),
                  "Continue with Google",
                  () async => {
                    await Auth.signInGoogle(),
                    _updateMessage("Google"),
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login_email');
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateMessage(String authType) {
    setState(() {
      Auth.firebaseAuth.currentUser().then((value) => {
        if (value != null)
          Navigator.of(context).popUntil(ModalRoute.withName('/'))
        else
          _loginMessage = "Unable to authenticate with $authType"
      });
    });
  }

  Widget _createLoginButton(FaIcon icon, String text, Function onTap) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: SizedBox(
        height: 55,
        width: screenWidth * 0.9,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                SizedBox(width: 10),
                icon,
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
