import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/screens/post_login/plans/components/hangout_card.dart';
import 'package:twiine/screens/post_login/plans/components/upcoming_hangout_card.dart';

class MyHangouts extends StatefulWidget {
  @override
  _MyHangoutsState createState() => _MyHangoutsState();
}

class _MyHangoutsState extends State<MyHangouts> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
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
          case ConnectionState.active:
            Map<String, dynamic> userData = snapshot.data.data();
            var eventList = userData["events"];
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
            } else {
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
                          (eventList.length > 1) ? "Upcoming Hangouts" : "",
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
            break;
          default:
            return Container();
        }
      },
    );
  }
}
