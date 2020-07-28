import 'package:flutter/material.dart';
import 'package:twiine/colors.dart';

class TimeDifference extends StatefulWidget {
  final DateTime _eventDate = DateTime(2020, 10, 31);

  @override
  _TimeDifferenceState createState() => _TimeDifferenceState();
}

class _TimeDifferenceState extends State<TimeDifference> {
  int difference = 0;
  @override
  Widget build(BuildContext context) {
    _updateDate();
    _updateDateTimer();
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
  void _updateDateTimer() {
    Future.delayed(Duration(seconds: 10)).then((value) => {
      _updateDate()
    });
  }
  void _updateDate() {
    setState(() {
      difference = widget._eventDate.difference(DateTime.now()).inDays;
    });
  }
}
