import 'package:flutter/material.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/colors.dart';
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              TwiineColors.red,
            ),
          ),
          SizedBox(height: 10),
          Text("Loading"),
        ],
      );
    } else {
      var eventList = Auth.currentUser.data["events"];
      if (eventList == null || eventList.length == 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You currently have no hangouts planned",
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
          ],
        );
      }
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
