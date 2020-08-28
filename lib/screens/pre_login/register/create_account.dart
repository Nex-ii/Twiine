import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:twiine/common/text_form.dart';
import 'package:twiine/twiine_api.dart';
import 'package:twiine/auth.dart';

class CreateAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateAccountState();
  }
}

class CreateAccountState extends State<CreateAccount> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static TextEditingController _firstNameController = TextEditingController();
  static TextEditingController _lastNameController = TextEditingController();
  static TextEditingController _birthdayController = TextEditingController();
  static TextEditingController _emailController = TextEditingController();
  static TextEditingController _passwordController = TextEditingController();
  static TextEditingController _confirmPasswordController =
      TextEditingController();

  static Function passwordValidator;
  static Function confirmPasswordValidator;
  static Function onContinueTap;

  @override
  Widget build(BuildContext context) {
    passwordValidator = (String value) {
      if (value.isEmpty) {
        return 'Password is Required';
      }
      if (value.length < 6) {
        return 'Password must be at least 6 characters long';
      }
      return null;
    };

    confirmPasswordValidator = (String value) {
      if (value.isEmpty) {
        return 'Password Confirmation is Required';
      }
      if (_confirmPasswordController.text != _passwordController.text) {
        return 'Passwords have to match';
      }
      return null;
    };

    onContinueTap = () {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();
      var data = {
        'firstname': _firstNameController.text,
        'lastname': _lastNameController.text,
        'birthday': _birthdayController.text,
        'email': _emailController.text,
      };
      _registerUser(data).then(
        (value) => {if (Auth().user != null) navigate(context)},
      );
    };

    AppBar bar = AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Text(''),
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back_ios),
        color: Colors.black,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );

    Widget w = TextForm.textForm([
      FormElement("First Name", FormTypes.TEXTFIELD,
          controller: _firstNameController),
      FormElement("Last Name", FormTypes.TEXTFIELD,
          controller: _lastNameController),
      FormElement("Birthday", FormTypes.DATEFIELD,
          controller: _birthdayController),
      FormElement("Email", FormTypes.EMAILFIELD, controller: _emailController),
      FormElement("Password", FormTypes.PASSWORDFIELD,
          controller: _passwordController, validator: passwordValidator),
      FormElement("Confirm Password", FormTypes.PASSWORDFIELD,
          controller: _confirmPasswordController,
          validator: confirmPasswordValidator),
      FormElement("Terms of Service", FormTypes.INKWELL, onTap: () {}),
    ], [
      ButtonElement("Continue", onContinueTap)
    ], _formKey,
        appBar: TextForm.backBar(context, onTap: () {
          Navigator.pushNamed(context, '/landing');
        }),
        title: "Join the Twiine Community",
        headingSpacing: 0,
        trailingSpacing: 0);

    return w;
  }

  static Future<void> _registerUser(Map<String, String> data) async {
    try {
      await Auth.firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      await Auth.signInEmail(_emailController.text, _passwordController.text);
    } catch (error) {
      print("Unable to create account: ${error.toString()}");
    }
    try {
      return TwiineApi.createNewUser(data: data);
    } catch (error) {
      print("API call error: ${error.toString()}");
    }
  }

  static navigate(BuildContext context){
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }
}
