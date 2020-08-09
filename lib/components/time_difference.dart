import 'package:flutter/material.dart';
import 'package:twiine/colors.dart';

class TimeDifference extends StatefulWidget {
  final DateTime _eventDate = DateTime(2020, 7, 26);

  @override
  _TimeDifferenceState createState() => _TimeDifferenceState();
}

class _TimeDifferenceState extends State<TimeDifference> {
  int timeDiff = 0;
  @override
  Widget build(BuildContext context) {
    _updateDate();
    _updateDateTimer();

    String message = "";
    if (timeDiff == 0)
      message = "Today";
    else if (timeDiff < 0)
      message = "${timeDiff.abs()} day${(timeDiff.abs() != 1) ? 's' : ''} ago";
    else
      message = "in $timeDiff day${(timeDiff != 1) ? 's' : ''}";

    return Container(
      width: 73,
      height: 21,
      decoration: BoxDecoration(
        color: TwiineColors.red,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          message,
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
    Future.delayed(Duration(seconds: 10)).then(
      (value) => {
        if (this.mounted) _updateDate(),
      },
    );
  }

  void _updateDate() {
    setState(() {
      timeDiff = widget._eventDate.difference(DateTime.now()).inDays;
    });
  }
}
