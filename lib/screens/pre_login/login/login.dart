import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twiine/colors.dart';

//authentication
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twiine/auth.dart';

//UI forms
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  bool isPhoneLogin = false;
  bool codeSent = false;
  String phoneNumber;
  String verificationId;

  String _loginMessage = "";

  BoxShadow _dropShadow = BoxShadow(
      color: Colors.grey.withOpacity(0.9),
      spreadRadius: -2,
      blurRadius: 6,
      offset: Offset(0, 4));
  double _dividerThickness = 2;
  double _buttonHeight = 50;
  double _buttonRadius = 15;

  Widget getLoginWidget(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
      Padding(
          padding: EdgeInsets.fromLTRB(20, 120, 10, 0),
          child: Column(children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Welcome to twiine",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ))),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
                child: Text(
                  _loginMessage,
                  style: TextStyle(color: TwiineColors.red, fontSize: 12),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
                child: InkWell(
                    borderRadius: BorderRadius.circular(_buttonRadius),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: _buttonHeight,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(_buttonRadius),
                            color: Colors.white,
                            boxShadow: [_dropShadow]),
                        padding: EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              IconButton(
                                icon: FaIcon(Icons.phone),
                                padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                                onPressed: null,
                              ),
                              Text("Continue with phone",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))
                            ])),
                    onTap: () => {
                          setState(() {
                            isPhoneLogin = true;
                          })
                        })),
            Row(children: <Widget>[
              Expanded(child: Divider(thickness: _dividerThickness)),
              Text(
                " or ",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              Expanded(child: Divider(thickness: _dividerThickness))
            ]),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
                child: InkWell(
                    borderRadius: BorderRadius.circular(_buttonRadius),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: _buttonHeight,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(_buttonRadius),
                            color: Colors.white,
                            boxShadow: [_dropShadow]),
                        padding: EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.facebook),
                                padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                                onPressed: null,
                              ),
                              Text("Continue with Facebook",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))
                            ])),
                    onTap: () => {_loginWithFacebook()})),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: InkWell(
                    borderRadius: BorderRadius.circular(_buttonRadius),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: _buttonHeight,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(_buttonRadius),
                            color: Colors.white,
                            boxShadow: [_dropShadow]),
                        padding: EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.google),
                                padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                                onPressed: null,
                              ),
                              Text("Continue with Google",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))
                            ])),
                    onTap: () => {_loginWithGoogle()})),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: InkWell(
                    borderRadius: BorderRadius.circular(_buttonRadius),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: _buttonHeight,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(_buttonRadius),
                            color: Colors.white,
                            boxShadow: [_dropShadow]),
                        padding: EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.envelope),
                                padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                                onPressed: null,
                              ),
                              Text("Continue with Email",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))
                            ])),
                    onTap: () =>
                        {Navigator.of(context).pushNamed('/login_basic')})),
            Padding(
                padding: EdgeInsets.all(50),
                child: Text("[Terms and conditions statement]",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15, color: Colors.grey))),
          ]))
    ]));
  }

  Widget getPhoneLoginWidget(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          setState(() {
            isPhoneLogin = false;
          });
        },
        child: Scaffold(
            body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    phoneNumber = number.phoneNumber;
                  },
                  ignoreBlank: false,
                  autoValidate: false,
                  initialValue: PhoneNumber(isoCode: 'US'),
                  selectorTextStyle: TextStyle(color: Colors.black),
                  inputBorder: OutlineInputBorder(),
                ),
                RaisedButton(
                  onPressed: () => {_logInWithPhone(phoneNumber)},
                  child: Text('Submit'),
                ),
                Text(_loginMessage,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15, color: Colors.black))
              ]),
        )));
  }

  Widget getSMSCodeLoginWidget(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          setState(() {
            isPhoneLogin = false;
          });
        },
        child: Scaffold(
            body: ListView(children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(20, 120, 10, 0),
              child: Column(children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Welcome to twiine",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ))),
                TextField(
                  decoration:
                      new InputDecoration(labelText: "Verification Code"),
                  keyboardType: TextInputType.phone,
                  maxLength: 20,
                ),
                RaisedButton(
                  onPressed: () => {_logInWithPhone(phoneNumber)},
                  child: Text('Submit'),
                ),
              ]))
        ])));
  }

  @override
  Widget build(BuildContext context) {
    if (isPhoneLogin) if (codeSent)
      return getSMSCodeLoginWidget(context);
    else
      return getPhoneLoginWidget(context);
    else
      return getLoginWidget(context);
  }

  _logInWithPhone(String phoneNumber) async {
    if (codeSent) {
      AuthCredential authCreds = PhoneAuthProvider.getCredential(
          verificationId: verificationId, smsCode: phoneNumber);
      FirebaseAuth.instance.signInWithCredential(authCreds);
      _successfulLogin();
    }

    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      FirebaseAuth.instance.signInWithCredential(authResult);
      _successfulLogin();
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      updateLoginMessage(authException.message);
      codeSent = false;
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      setState(() {
        verificationId = verId;
        codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
      print("timeout!!!");
      codeSent = false;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);

  }

  _loginWithFacebook() async {
    // Authenticate with Facebook
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        // Authenticate with Firebase
        AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        );

        // TODO: figure out what to do with this, but for now, we're
        // authenticated with facebook
        Auth.user =
            (await Auth.firebaseAuth.signInWithCredential(credential)).user;

        if (Auth.user != null) {
          updateLoginMessage("Successfully authenticated with Facebook");
          _successfulLogin();
        } else
          updateLoginMessage("Failed to authenticate with Firebase");

        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
      default:
        updateLoginMessage("Failed to authenticate with Facebook");
        break;
    }
  }

  // refer to: https://stackoverflow.com/questions/54557479/flutter-and-google-sign-in-plugin-platformexceptionsign-in-failed-com-google
  _loginWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );
    try {
      // Authenticate with Google
      GoogleSignInAccount signIn = (await _googleSignIn.signIn().catchError(
          (error) => {
                updateLoginMessage(
                    "Failed to authenticate with Google: " + error)
              }));
      GoogleSignInAuthentication auth = await signIn.authentication;

      // Authenticate with Firebase
      AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: auth.idToken, accessToken: auth.idToken);

      Auth.user =
          (await Auth.firebaseAuth.signInWithCredential(credential)).user;
    } on PlatformException {
      updateLoginMessage("Failed to authenticate with Google: ");
    }

    updateLoginMessage("Successfully authenticated with Google");
    _successfulLogin();
  }

  _successfulLogin() {
    codeSent = false;
    Navigator.of(context).pushNamed('/navBar');
  }

  updateLoginMessage(String msg) {
    setState(() {
      _loginMessage = msg;
    });
  }
}
