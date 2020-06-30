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
}