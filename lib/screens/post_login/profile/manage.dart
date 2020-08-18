import 'package:flutter/material.dart';
import 'package:twiine/auth.dart';

class Manage extends StatefulWidget {
  @override
  _ManageState createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile Information'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text('First Name'),
            Container(
              child: MyTextFormField(
                hintText: Auth.userData["firstname"],
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Enter the Event Name';
                  }
                  return null;
                },
                onSaved: (String value) {
                  temp.name = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isEmail;

  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}