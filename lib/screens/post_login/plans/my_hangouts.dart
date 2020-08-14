import 'package:flutter/material.dart';
import 'package:twiine/components/hangout_card.dart';
import 'package:twiine/components/upcoming_hangout_card.dart';

class MyHangouts extends StatefulWidget {
  @override
  _MyHangoutsState createState() => _MyHangoutsState();
}

class _MyHangoutsState extends State<MyHangouts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
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
          HangoutCard(eventId: "tDcccXrWrq3bPSrnJE83"),
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
          UpcomingHangoutCard(eventId: "U3gzviOvGKWp3pMcQnCV"),
          UpcomingHangoutCard(eventId: "TkfQchqpGZpbBw7C0BCb"),
          UpcomingHangoutCard(eventId: "ZDOIWVuN2lIToMRLcLNr"),
          UpcomingHangoutCard(eventId: "Fe37gd76S2esqR5BB0DY"),
        ],
      ),
    );
  }
}
