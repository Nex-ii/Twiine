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
    double screenWidth = MediaQuery.of(context).size.width;

    // Styling
    TextStyle headerStyle = TextStyle(
      color: TwiineColors.red,
      fontSize: 18,
    );
    TextStyle headerStyleInactive = TextStyle(
      color: TwiineColors.grey,
      fontSize: 18,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            screenWidth * 0.03,
            60,
            screenWidth * 0.03,
            0,
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 282,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "My Hangouts",
                        style: headerStyle,
                      ),
                    ),
                    Center(
                      child: Text(
                        "Requests",
                        style: headerStyleInactive,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
