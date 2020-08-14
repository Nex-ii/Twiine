import 'package:flutter/material.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/components/hangout_card.dart';
import 'package:twiine/components/upcoming_hangout_card.dart';

class MyHangouts extends StatefulWidget {
  @override
  _MyHangoutsState createState() => _MyHangoutsState();
}

class _MyHangoutsState extends State<MyHangouts> {
  bool _ready = false;
  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      Auth.updateUserData().then(
        (value) => (setState(
          () {
            _ready = true;
          },
        )),
      );
      return Text("Loading");
    }
    else {
      var eventList = Auth.userData["events"];
      return Container(
        child: ListView(
          children: [
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
            HangoutCard(eventId: eventList[0].documentID),
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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: eventList.length - 1,
              itemBuilder: (BuildContext context, int index) {
                return UpcomingHangoutCard(
                    eventId: eventList[index + 1].documentID);
              },
            ),
          ],
        ),
      );
    }
  }
}
