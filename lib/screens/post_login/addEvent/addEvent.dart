import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;
import 'package:twiine/screens/post_login/scheduled/plannedDates.dart';
import 'package:twiine/screens/post_login/addEvent/testResult.dart';

class addEvent extends StatefulWidget {
  @override
  _addEventState createState() => _addEventState();
}

class _addEventState extends State<addEvent> {
  final _formKey = GlobalKey<FormState>();
  PlannedDates temp = PlannedDates();

  @override
  Widget build(BuildContext context) {
    final thirdMediaWidth = MediaQuery.of(context).size.width / 3.0;
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Event'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              child: MyTextFormField(
                hintText: 'Event Name',
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
            Container(
              child: MyTextFormField(
                hintText: 'Location',
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Enter the Location Name';
                  }
                  return null;
                },
                onSaved: (String value) {
                  temp.location = value;
                },
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: thirdMediaWidth,
                  child: MyTextFormField(
                    hintText: 'Day',
                    validator: (String value) {
                      if (value.isEmpty ||
                          int.parse(value) < 1 ||
                          int.parse(value) > 31 ||
                          int.parse(value) is! int) {
                        return '1-31';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      temp.day = int.parse(value);
                    },
                  ),
                ),
                Container(
                  width: thirdMediaWidth,
                  child: MyTextFormField(
                    hintText: 'Month',
                    validator: (String value) {
                      if (value.isEmpty ||
                          int.parse(value) > 12 ||
                          int.parse(value) < 1 ||
                          int.parse(value) is! int) {
                        return '1-12';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      temp.month = int.parse(value);
                    },
                  ),
                ),
                Container(
                  width: thirdMediaWidth,
                  child: MyTextFormField(
                    hintText: 'Year',
                    validator: (String value) {
                      if (value.isEmpty || int.parse(value) is! int) {
                        return 'Enter Year';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      temp.year = int.parse(value);
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  width: thirdMediaWidth,
                  child: Text(
                    'Time: ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  width: thirdMediaWidth / 1.15,
                  child: MyTextFormField(
                    hintText: '0-23',
                    validator: (String value) {
                      if (value.isEmpty ||
                          int.parse(value) < 0 ||
                          int.parse(value) > 23 ||
                          int.parse(value) is! int) {
                        return '0-23';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      temp.hour = int.parse(value);
                    },
                  ),
                ),
                Container(
                  width: halfMediaWidth / 16.0,
                  child: Text(' : '),
                ),
                Container(
                  width: thirdMediaWidth / 1.15,
                  child: MyTextFormField(
                    hintText: '0-59',
                    validator: (String value) {
                      if (value.isEmpty ||
                          int.parse(value) < 0 ||
                          int.parse(value) > 59 ||
                          int.parse(value) is! int) {
                        return '0-59';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      temp.minute = int.parse(value);
                    },
                  ),
                ),
              ],
            ),
            RaisedButton(
              color: Colors.blueAccent,
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  var returnVar = new DateTime(
                      temp.year, temp.month, temp.day, temp.hour, temp.minute);
                  temp.dateInfo = returnVar;
                  Navigator.of(context).pop(temp);
                }
              },
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
  final bool isPassword;
  final bool isEmail;

  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
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
