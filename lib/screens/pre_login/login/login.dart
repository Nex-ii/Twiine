import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twiine/colors.dart';

//authentication
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twiine/auth.dart';

//UI forms
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:twiine/screens/pre_login/login/login_methods.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  ///switches for build() to rebuild form

  BoxShadow _dropShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.9),
    spreadRadius: -2,
    blurRadius: 6,
    offset: Offset(0, 4),
  );

  double _dividerThickness = 2;
  double _buttonHeight = 50;
  double _buttonRadius = 15;

  ///create a button within a padding for authProvider
  Widget createLoginButton(AuthProvider authProvider) {
    return Padding(
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
                icon: authProvider.icon,
                padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                onPressed: null,
              ),
              Text("Continue with " + authProvider.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
            ],
          ),
        ),
        onTap: () => {authProvider.onTap()},
      ),
    );
  }

  ///create the column of buttons
  Widget createLoginButtonColumn(List<AuthProvider> primaryAuthProviders,
      List<AuthProvider> secondaryAuthProviders) {
    Column container = new Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Welcome to twiine",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
          child: Text(
            SigninStatus.loginMessage,
            style: TextStyle(color: TwiineColors.red, fontSize: 12),
          ),
        ),
      ],
    );

    primaryAuthProviders.forEach((element) {
      container.children.add(createLoginButton(element));
    });

    container.children.add(
      Row(
        children: <Widget>[
          Expanded(child: Divider(thickness: _dividerThickness)),
          Text(
            " or ",
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          Expanded(child: Divider(thickness: _dividerThickness))
        ],
      ),
    );
    container.children.add(
      Padding(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
      ),
    );

    secondaryAuthProviders.forEach((element) {
      container.children.add(createLoginButton(element));
    });

    container.children.add(
      Padding(
        padding: EdgeInsets.all(50),
        child: Text(
          "[Terms and conditions statement]",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ),
    );

    return container;
  }

  ///create the login page, define AuthProviders in this function
  Widget getLoginWidget() {
    AuthProvider phoneAuth =
        new AuthProvider("phone", FaIcon(Icons.phone), _loginWithPhone);
    AuthProvider facebookAuth = new AuthProvider(
        "Facebook", FaIcon(FontAwesomeIcons.facebook), _loginWithFacebook);
    AuthProvider googleAuth = new AuthProvider(
        "Google", FaIcon(FontAwesomeIcons.google), _loginWithGoogle);
    AuthProvider emailAuth = new AuthProvider(
        "Email", FaIcon(FontAwesomeIcons.envelope), _loginWithEmail);

    List<AuthProvider> primaryAuth = [phoneAuth];
    List<AuthProvider> secondaryAuth = [facebookAuth, googleAuth, emailAuth];

    return Scaffold(
        body: ListView(children: <Widget>[
      Padding(
          padding: EdgeInsets.fromLTRB(20, 120, 10, 0),
          child: createLoginButtonColumn(primaryAuth, secondaryAuth))
    ]));
  }

  ///ui form for phone number input
  Widget getPhoneLoginWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          SigninStatus.isPhoneLogin = false;
        });
      },
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  SigninStatus.phoneNumber = number.phoneNumber;
                },
                ignoreBlank: false,
                autoValidate: false,
                initialValue: PhoneNumber(isoCode: 'US'),
                selectorTextStyle: TextStyle(color: Colors.black),
                inputBorder: OutlineInputBorder(),
              ),
              RaisedButton(
                onPressed: _loginWithPhone,
                child: Text('Submit'),
              ),
              Text(SigninStatus.loginMessage,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15, color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }

  ///ui form for SMS code input
  Widget getSMSCodeLoginWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          SigninStatus.isPhoneLogin = false;
        });
      },
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 120, 10, 0),
              child: Column(
                children: <Widget>[
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
                    onChanged: (t) => {SigninStatus.SMScode = t},
                  ),
                  RaisedButton(
                    onPressed: _loginWithPhone,
                    child: Text('Submit'),
                  ),
                  Text(SigninStatus.loginMessage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getEmailLoginWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          SigninStatus.isEmailLogin = false;
        });
      },
      child: Scaffold(
        body: ListView(
          children: <Widget>[
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
                      ),
                    ),
                  ),
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
                              onChanged: (t) => SigninStatus.email = t,
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                            child: TextFormField(
                              obscureText: true,
                              decoration: new InputDecoration(
                                labelText: "Password",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (t) => SigninStatus.emailPassword = t,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      SigninStatus.loginMessage,
                      style: TextStyle(
                        color: TwiineColors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 10, 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(_buttonRadius),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: _buttonHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(_buttonRadius),
                          color: TwiineColors.red,
                          boxShadow: [_dropShadow],
                        ),
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      onTap: _loginWithEmail,
                    ),
                  ),
                  FlatButton(
                    child: Text('Forgot password?',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w300)),
                    onPressed: _forgotPasword,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (SigninStatus.isPhoneLogin) {
      if (SigninStatus.codeSent)
        return getSMSCodeLoginWidget(context);
      else
        return getPhoneLoginWidget(context);
    }

    if (SigninStatus.isEmailLogin) return getEmailLoginWidget(context);

    return getLoginWidget();
  }

  _loginWithPhone() {
    final PhoneVerificationCompleted verified = (AuthCredential credeitial) {
      Auth.firebaseAuth.signInWithCredential(credeitial).catchError((error) {
        updateLoginMessage("Failed to verified phone number");
      }).then((result) {
        updateLoginMessage("Successfully verified phone number");
        Auth.user = result.user;
        _successfulLogin(
            LoginMethods.phone, SigninStatus.phoneNumber, SigninStatus.SMScode);
      });
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      updateLoginMessage("Failed to verify phone number");
      SigninStatus.codeSent = false;
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      setState(() {
        SigninStatus.verificationId = verId;
        SigninStatus.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      SigninStatus.verificationId = verId;
      SigninStatus.codeSent = false;
    };

    if (SigninStatus.isPhoneLogin) {
      if (SigninStatus.codeSent) {
        Auth.firebaseAuth
            .signInWithCredential(PhoneAuthProvider.getCredential(
                verificationId: SigninStatus.verificationId,
                smsCode: SigninStatus.SMScode))
            .catchError((error) {
          updateLoginMessage("Failed to verify phone number");
        }).then((result) {
          if (result != null) {
            updateLoginMessage("Successfully verified phone number");
            _successfulLogin(LoginMethods.phone, SigninStatus.phoneNumber,
                SigninStatus.SMScode);
            Auth.user = result.user;
          }
        });
      } else {
        Auth.firebaseAuth.verifyPhoneNumber(
            phoneNumber: SigninStatus.phoneNumber,
            timeout: const Duration(seconds: 60),
            verificationCompleted: verified,
            verificationFailed: verificationfailed,
            codeSent: smsSent,
            codeAutoRetrievalTimeout: autoTimeout);
      }
    } else {
      setState(() {
        SigninStatus.isPhoneLogin = true;
      });
    }
  }

  _loginWithFacebook() {
    // Authenticate with Facebook
    FacebookLogin().logIn(['email']).then((facebookResult) {
      switch (facebookResult.status) {
        case FacebookLoginStatus.loggedIn:
          Auth.firebaseAuth
              .signInWithCredential(FacebookAuthProvider.getCredential(
            accessToken: facebookResult.accessToken.token,
          ))
              .catchError((error) {
            updateLoginMessage("Failed to authenticate with Firebase");
          }).then((firebaseResult) {
            if (firebaseResult != null) {
              updateLoginMessage("Successfully authenticated with Facebook");
              Auth.user = firebaseResult.user;
              _successfulLogin(LoginMethods.facebook, null, null);
            }
          });
          break;
        default:
          updateLoginMessage("Failed to authenticate with Firebase");
          break;
      }
    });
  }

  _loginWithGoogle() {
    try {
      // Authenticate with Google
      GoogleSignIn(scopes: ['email']).signIn().catchError((error) {
        updateLoginMessage("Failed to authenticate with Google");
      }).then((account) {
        account.authentication.then((authentication) {
          Auth.firebaseAuth
              .signInWithCredential(GoogleAuthProvider.getCredential(
                  idToken: authentication.idToken,
                  accessToken: authentication.idToken))
              .then((result) {
            if (result != null) {
              updateLoginMessage("Successfully authenticated with Google");
              _successfulLogin(LoginMethods.google, null, null);
              Auth.user = result.user;
            }
          });
        });
      });
    } on PlatformException {
      updateLoginMessage("Failed to authenticate with Google: ");
    }
  }

  _loginWithEmail() {
    if (SigninStatus.isEmailLogin) {
      Auth.firebaseAuth
          .signInWithEmailAndPassword(
        email: SigninStatus.email,
        password: SigninStatus.emailPassword,
      )
          .catchError((error) {
        updateLoginMessage("Unable to authenticate with email");
      }).then((result) {
        if (result != null) {
          updateLoginMessage("Successfully authenticated with email");
          Auth.user = result.user;
          _successfulLogin(LoginMethods.email, SigninStatus.email,
              SigninStatus.emailPassword);
        }
      });
    } else {
      setState(() {
        SigninStatus.isEmailLogin = true;
      });
    }
  }

  _forgotPasword() {
    Navigator.of(context).pushNamed('/forgotPassword');
  }

  _successfulLogin(
      LoginMethods loginMethod, String username, String password) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("hasLoggedIn", true);

    SigninStatus.isPhoneLogin = false;
    SigninStatus.codeSent = false;
    SigninStatus.isEmailLogin = false;

    SigninStatus.phoneNumber = null;
    SigninStatus.verificationId = null;
    SigninStatus.SMScode = null;
    SigninStatus.email = null;
    SigninStatus.emailPassword = null;

    Navigator.pushNamedAndRemoveUntil(context, "/navBar", (r) => false);
  }

  updateLoginMessage(String msg) {
    setState(() {
      SigninStatus.loginMessage = msg;
    });
  }
}

/// bundles provider name, icon, and onTap function
class AuthProvider {
  String name;
  Widget icon;
  Function onTap;

  AuthProvider(String name, Widget icon, Function onTap) {
    this.name = name;
    this.icon = icon;
    this.onTap = onTap;
  }
}

class SigninStatus {
  static bool isPhoneLogin = false;
  static bool codeSent = false;
  static bool isEmailLogin = false;
  static String phoneNumber;
  static String SMScode;
  static String verificationId;
  static String email;
  static String emailPassword;
  static String loginMessage = "";
}
