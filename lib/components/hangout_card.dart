import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twiine/components/time_difference.dart';

class HangoutCard extends StatefulWidget {
  final String eventId;
  HangoutCard({Key key, this.eventId});

  @override
  _HangoutCardState createState() => _HangoutCardState();
}

class _HangoutCardState extends State<HangoutCard> {
  double _borderRadius = 10;
  String _place = "";
  String _thumbnail = "";
  DateTime _eventDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _getEventData();
    return Container(
      height: 330,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 219,
              child: CachedNetworkImage(
                imageUrl: _thumbnail,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_borderRadius),
                      topRight: Radius.circular(_borderRadius),
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 11, 3, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TimeDifference(eventDate: _eventDate),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          _place,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(3, 3, 3, 10),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://avatars0.githubusercontent.com/u/8981287?s=460&u=4bf37a144d65af7f4d6aa1616fd734f83b566fac&v=4"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(3, 3, 3, 10),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://avatars0.githubusercontent.com/u/8981287?s=460&u=4bf37a144d65af7f4d6aa1616fd734f83b566fac&v=4"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _getEventData() async {
    Map<String, dynamic> eventData = (await Firestore.instance
            .collection("Events")
            .document(widget.eventId)
            .get())
        .data;
    Map<String, dynamic> place = (await eventData["place"].get()).data;
    if (this.mounted) {
      setState(() {
        _thumbnail = place["image_url"];
        _place = place["name"];
        _eventDate = (eventData["time"] as Timestamp).toDate();
      });
    }
  }
}
