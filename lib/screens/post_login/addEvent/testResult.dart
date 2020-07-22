import 'package:flutter/material.dart';
import 'package:twiine/screens/post_login/addEvent/addEvent.dart';
import 'package:twiine/screens/post_login/scheduled/plannedDates.dart';

class testResult extends StatelessWidget {
  PlannedDates temp;

  testResult({this.temp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Successful')),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              temp.day.toString(),
              style: TextStyle(fontSize: 22),
            ),
            Text(
              temp.month.toString(),
              style: TextStyle(fontSize: 22),
            ),
            Text(
              temp.year.toString(),
              style: TextStyle(fontSize: 22),
            ),
            Text(
              temp.location,
              style: TextStyle(fontSize: 22),
            ),
            Text(
              temp.name,
              style: TextStyle(fontSize: 22),
            ),
          ]
        )
      ),
    );
  }
}
