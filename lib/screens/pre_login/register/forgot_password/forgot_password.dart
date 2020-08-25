import 'package:flutter/material.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/common/text_form.dart';

class ForgotPassword extends StatefulWidget {
  @override
  ForgotPassword({Key key}) : super(key: key);

  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    AppBar bar = AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Text(''),
      toolbarHeight: 30,
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back_ios),
        color: Colors.black,
        onPressed: () => Navigator.pop(context),
      ),
    );

    return TextForm.textForm([
      FormElement("Email", FormTypes.EMAILFIELD, controller: _emailController),
    ], [
      ButtonElement("Recover Password", _recoverPassword),
    ], _formKey, appBar: bar, title: "Recover Password");
  }

  _recoverPassword() {
    Auth.firebaseAuth.sendPasswordResetEmail(email: _emailController.text);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("An email has been sent to the provided address!"),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
