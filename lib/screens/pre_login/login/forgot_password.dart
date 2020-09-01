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
    ], _formKey, appBar: TextForm.backBar(context), title: "Recover Password");
  }

  _recoverPassword() {
    Auth.firebaseAuth.sendPasswordResetEmail(email: _emailController.text);
    TextForm.popUp(context, "An email has been sent to the provided address!");
  }
}
