import 'package:flutter/material.dart';
import 'package:twiine/colors.dart';

class TimeDifference extends StatefulWidget {
  final DateTime _eventDate = DateTime(2050, 8, 31);

  @override
  _TimeDifferenceState createState() => _TimeDifferenceState();
}

class _TimeDifferenceState extends State<TimeDifference> {
  int difference = DateTime.now().difference(DateTime.now()).inDays;
  @override
  Widget build(BuildContext context) {
    _updateDate();
    return Container(
      width: 73,
      height: 21,
      decoration: BoxDecoration(
        color: TwiineColors.red,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          "in $difference day${(difference != 1) ? 's' : ''}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 9,
          ),
        ),
      ),
    );
  }
  void _updateDate() {
    Future.delayed(Duration(seconds: 1)).then((value) => {
      setState(() {
        difference = widget._eventDate.difference(DateTime.now()).inDays;
      })
    });
  }
}
