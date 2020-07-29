import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:twiine/screens/post_login/addEvent/addEvent.dart';

class CreateAccount extends StatefulWidget {
  @override
  // TODO: implement build
  State<StatefulWidget> createState() {
    return CreateAccountState();
  }
}

class CreateAccountState extends State<CreateAccount>{

  String _firstName;
  String _lastName;
  String _birthday;
  String _email;
  String _password;
  String _confirmPassword;

  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(context: context, initialDate: new DateTime.now(), firstDate: new DateTime(2016), lastDate: new DateTime(2021));
    if (picked != null) setState(() => _birthday = picked.toString());
  }

  // Title Widget
  Widget _buildTitle(){
    return Text(
      "Join the Twiine Community",
      style: TextStyle(height: 5, fontSize: 25, fontWeight: FontWeight.bold),
    );
  }

  // TextFormField Widgets
  Widget _buildFirstName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'First Name'),
      validator: (String value){
        if(value.isEmpty){
          return 'First Name is Required';
        }
      },
      onSaved: (String value){
        _firstName = value;
      },
    );
  }

  Widget _buildLastName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Last name'),
      validator: (String value){
        if(value.isEmpty){
          return 'Last Name is Required';
        }
      },
      onSaved: (String value){
        _lastName = value;
      },
    );
  }

  Widget _buildBirthday() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Birthday (MM/DD/YYYY)', hintText: "Example: 01/01/1990"),
      keyboardType: TextInputType.datetime,
      validator: (String value){
        if(value.isEmpty){
          return 'Birthday is Required';
        }

        if(!isValidDate(value)){
          return 'Valid Input is Required';
        }
      },
      onSaved: (String value){
        _lastName = value;
      },
    );

  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String value){
        if(value.isEmpty){
          return 'Valid Email is Required';
        }
        if(!isValidEmail(value)){
          return 'Valid Email Address Required';
        }
      },
      onSaved: (String value){
        _lastName = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator: (String value){
        if(value.isEmpty){
          return 'Password is Required';
        }
      },
      onSaved: (String value){
        _password = value;
      },
    );
  }

  Widget _buildConfirmPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Confirm Password'),
      obscureText: true,
      validator: (String value){
        if(value.isEmpty){
          return 'Password Confirmation is Required';
        }
      },
      onSaved: (String value){
        _confirmPassword = value;
      },
    );
  }

  // validation functions
  bool isValidDate(String input) {
    try {
      List<String> partitionedBirthday = input.split("/");
      String reformattedBirthday = partitionedBirthday[2] + partitionedBirthday[0] + partitionedBirthday [1];
      final date = DateTime.parse(reformattedBirthday);
      final originalFormatString = toOriginalFormatString(date);
      return reformattedBirthday == originalFormatString;
    } catch (e) {
      return false;
    }
  }

  String toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    return "$y$m$d";
  }

  bool isValidEmail(String input) {
    if(RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(input)){
      return true;
    }
    else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
            margin: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildTitle(),
                        _buildFirstName(),
                        _buildLastName(),
                        _buildBirthday(),
                        _buildEmail(),
                        _buildPassword(),
                        _buildConfirmPassword(),

                        SizedBox(height: 100),
                        ButtonTheme(
                          minWidth: 300.0,
                          height: 50.0,
                          buttonColor: Colors.red,
                          child: RaisedButton(
                            child: Text('Continue', style: TextStyle(color: Colors.white, fontSize: 16),),
                            onPressed: () {
                              if(!_formKey.currentState.validate()){
                                return;
                              }

                              _formKey.currentState.save();
                              print(_firstName);
                              print(_lastName);
                              print(_birthday);
                              print(_email);
                              print(_password);
                              print(_confirmPassword);

                            },
                          ),
                        )
                      ]
                  )),
            )
        )
    );
  }
}