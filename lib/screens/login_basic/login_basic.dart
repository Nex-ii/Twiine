import 'package:flutter/material.dart';

class LoginBasic extends StatefulWidget{
  @override
  LoginState createState() =>LoginState();
}

class LoginState extends State<LoginBasic> {

  final username_controller = TextEditingController(),
        password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Form(
            key: GlobalKey(),
            child: getFormUI(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose(){
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  Widget getFormUI() {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Email',
              icon: Icon(
                Icons.mail,
                color: Colors.grey,
              )),
          maxLines: 1,
          maxLength: 32,
          keyboardType: TextInputType.emailAddress,
          controller: username_controller,
        ),
        new TextFormField(
          decoration: new InputDecoration(
              hintText: 'Password',
              icon: new Icon(
                Icons.lock,
                color: Colors.grey,
              )),
          obscureText: true,
          maxLines: 1,
          maxLength: 10,
          controller: password_controller,
        ),
        new SizedBox(height: 15.0),
        new Row(
          children: [
            new FlatButton(
              child: new Text('Forgot password?',
                style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300)),
                onPressed: navigate_to_forgot_password,
            ),
            new SizedBox(width: 10,),
            new FlatButton(
              child: new Text('Create Account',
                  style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300)),
              onPressed: navigate_to_create_account,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        new RaisedButton(
          onPressed: navigate_to_home,
          child: new Text('Login'),
        )
      ],
    );
  }

  /// Posts the username and password for credential validation
  bool post_credentials(){
    final String username = username_controller.text,
                 password = password_controller.text;
    throw UnimplementedError();
  }

  navigate_to_home(){
    if(post_credentials())
      Navigator.of(context).pushNamed('/home');
  }

  navigate_to_forgot_password(){
    Navigator.of(context).pushNamed('/forgot_password');
  }

  navigate_to_create_account(){
    Navigator.of(context).pushNamed('/create_account');
  }

}