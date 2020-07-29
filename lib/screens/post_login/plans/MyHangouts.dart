import 'package:flutter/material.dart';
import 'package:twiine/components/HangoutCard.dart';
import 'package:twiine/components/UpcomingHangoutCard.dart';

class MyHangouts extends StatefulWidget {
  @override
  _MyHangoutsState createState() => _MyHangoutsState();
}

class _MyHangoutsState extends State<MyHangouts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.fromLTRB(4, 0, 0, 8),
              child: Text(
                "Current Hangout",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          HangoutCard(),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.fromLTRB(4, 20, 0, 20),
              child: Text(
                "Upcoming Hangouts",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          UpcomingHangoutCard(),
          UpcomingHangoutCard(),
          UpcomingHangoutCard(),
          UpcomingHangoutCard(),
          UpcomingHangoutCard(),
          UpcomingHangoutCard(),
        ],
      ),
    );
  }
}
