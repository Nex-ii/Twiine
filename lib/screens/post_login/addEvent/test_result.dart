import 'package:flutter/material.dart';
import 'package:twiine/screens/post_login/addEvent/add_event.dart';
import 'package:twiine/screens/post_login/scheduled/planned_dates.dart';

class TestResult extends StatelessWidget {
  PlannedDates temp;

  TestResult({this.temp});

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
          ],
        ),
      ),
    );
  }
}
