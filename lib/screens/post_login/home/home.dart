import 'package:flutter/material.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/components/HangoutCard.dart';
import 'package:twiine/components/UpcomingHangoutCard.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // Styling
    TextStyle headerStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: TwiineColors.red,
      fontSize: 18,
    );
    TextStyle headerStyleInactive = TextStyle(
      fontWeight: FontWeight.bold,
      color: TwiineColors.grey,
      fontSize: 18,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 39, 15, 0),
                  child: Center(
                    child: Text(
                      "My Hangouts",
                      style: headerStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 39, 15, 0),
                  child: Center(
                    child: Text(
                      "Requests",
                      style: headerStyleInactive,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.fromLTRB(40, 26, 0, 0),
                child: Text(
                  "Current Hangout",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: HangoutCard(),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.fromLTRB(40, 26, 0, 0),
                child: Text(
                  "Upcoming Hangouts",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: UpcomingHangoutCard(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: UpcomingHangoutCard(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: UpcomingHangoutCard(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: UpcomingHangoutCard(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: UpcomingHangoutCard(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: UpcomingHangoutCard(),
            ),
          ],
        ),
      ),
    );
  }
}
