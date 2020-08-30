import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/screens/post_login/plans/components/request_card.dart';

class RequestsPage extends StatefulWidget {
  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
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
            var eventList = userData["requests"];
            if (eventList == null || eventList.length == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You currently have no pending requests",
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
                      alignment: Alignment.center,
                      child: Container(
                        child: Text(
                          "Pending Requests",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: eventList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RequestCard(
                            eventId: eventList[index].documentID);
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
