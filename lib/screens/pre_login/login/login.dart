import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseUser user;

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login>{

  final phoneNumberController = TextEditingController();

  bool codeSent = false;
  String verificationId;

  String _loginMessage = "";

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
              children: <Widget>[
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
                            decoration: new InputDecoration(
                                labelText: codeSent ? "Verification Code" : "Phone Number"),
                            keyboardType: TextInputType.phone,
                            maxLength: 20,
                            inputFormatters: <TextInputFormatter>[
//                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            controller: phoneNumberController,
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
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(
                                      _buttonRadius),
                                  child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: _buttonHeight,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              _buttonRadius),
                                          color: Colors.red,
                                          boxShadow: [ _dropShadow]
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: Center(
                                          child: Text(
                                              codeSent ? "Verify" : "Continue",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold
                                              )
                                          )
                                      )
                                  ),
                                  onTap: () {

                                    if(codeSent){
                                      AuthCredential authCreds = PhoneAuthProvider.getCredential(
                                      verificationId: verificationId, smsCode: phoneNumberController.text);
                                      FirebaseAuth.instance.signInWithCredential(authCreds);
                                    }else
                                      _verifyPhone(phoneNumberController.text);
                                  }
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
                              child: Text(
                                _loginMessage,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12
                                ),
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
                                  borderRadius: BorderRadius.circular(
                                      _buttonRadius),
                                  child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: _buttonHeight,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              _buttonRadius),
                                          color: Colors.white,
                                          boxShadow: [ _dropShadow]
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            IconButton(
                                              icon: FaIcon(
                                                  FontAwesomeIcons.facebook),
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 40, 0),
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
                                  onTap: () => { _loginWithFacebook()}
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(
                                      _buttonRadius),
                                  child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: _buttonHeight,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              _buttonRadius),
                                          color: Colors.white,
                                          boxShadow: [ _dropShadow]
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            IconButton(
                                              icon: FaIcon(
                                                  FontAwesomeIcons.google),
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 40, 0),
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
                                  onTap: () => { _loginWithGoogle()}
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(
                                      _buttonRadius),
                                  child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: _buttonHeight,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              _buttonRadius),
                                          color: Colors.white,
                                          boxShadow: [ _dropShadow]
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            IconButton(
                                              icon: FaIcon(
                                                  FontAwesomeIcons.apple),
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 40, 0),
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

  _verifyPhone(String phoneNumber) async{

      final PhoneVerificationCompleted verified = (AuthCredential authResult) {
        FirebaseAuth.instance.signInWithCredential(authResult);
      };

      final PhoneVerificationFailed verificationfailed =
          (AuthException authException) {
            _loginMessage = authException.message;
            codeSent = false;
      };

      final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
        verificationId = verId;
        codeSent = true;
      };

      final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
        this.verificationId = verId;
      };

      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verified,
          verificationFailed: verificationfailed,
          codeSent: smsSent,
          codeAutoRetrievalTimeout: autoTimeout);

      FocusScopeNode focus = FocusScope.of(context);
      if (!focus.hasPrimaryFocus)
        focus.unfocus();
      phoneNumberController.clear();
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
        user = (await _auth.signInWithCredential(credential)).user;
        setState(() {
          if (user != null)
            _loginMessage = "Successfully authenticated with Facebook";
          else
            _loginMessage = "Failed to authenticate with Firebase";
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
      default:
        setState(() {
          _loginMessage = "Failed to authenticate with Facebook";
        });
        break;
    }
  }

  // refer to: https://stackoverflow.com/questions/54557479/flutter-and-google-sign-in-plugin-platformexceptionsign-in-failed-com-google
  _loginWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email'
      ],
    );
    try {
      // Authenticate with Google
      GoogleSignInAccount signIn = (await _googleSignIn.signIn()
        .catchError((error) => {
          setState(() {
            _loginMessage = "Failed to authenticate with Google: " + error;
          })
        }));
      GoogleSignInAuthentication auth = await signIn.authentication;

      // Authenticate with Firebase
      AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: auth.idToken,
        accessToken: auth.idToken
      );

      user = (await _auth.signInWithCredential(credential)).user;
    }
    on PlatformException catch (error) {
      setState(() {
        _loginMessage = "Failed to authenticate with Google: ";
      });
    }
    setState(() {
      _loginMessage = "Successfully authenticated with Google";
    });
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
