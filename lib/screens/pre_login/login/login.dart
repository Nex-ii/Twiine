<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
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
    loginWithFacebook();
//    Navigator.of(context).pushNamed('/login_facebook');
  }

  String your_client_id = "636633230532783";
  String your_redirect_url = "https://www.facebook.com/connect/login_success.html";
  loginWithFacebook() async{
    String result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CustomWebView(
              selectedUrl:
              'https://www.facebook.com/dialog/oauth?client_id=$your_client_id&redirect_uri=$your_redirect_url&response_type=token&scope=email,public_profile,',
            ),
            maintainState: true));
        if(result != null) {
      try {
        final facebookAuthCred =
        FacebookAuthProvider.getCredential(accessToken: result);
        final user = await FirebaseAuth.instance.signInWithCredential(facebookAuthCred);
      } catch (e) {}
    }
    ;}

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

class CustomWebView extends StatefulWidget {
  final String selectedUrl;

  CustomWebView({this.selectedUrl});

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (url.contains("#access_token")) {
        succeed(url);
      }

      if (url.contains(
          "https://www.facebook.com/connect/login_success.html?error=access_denied&error_code=200&error_description=Permissions+error&error_reason=user_denied")) {
        denied();
      }
    });
  }

  denied() {
    Navigator.pop(context);
  }

  succeed(String url) {
    var params = url.split("access_token=");

    var endparam = params[1].split("&");

    Navigator.pop(context, endparam[0]);
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: widget.selectedUrl,
        appBar: new AppBar(
          backgroundColor: Color.fromRGBO(66, 103, 178, 1),
          title: new Text("Facebook login"),
        ));
  }
=======
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
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                    onTap: () => { _loginWithFacebook() }
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
                    onTap: () => { _loginWithGoogle() }
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

  // TODO: this doesnt work yet
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
>>>>>>> 80182377695bcdfca17637b876c850c5bdac6b73
}