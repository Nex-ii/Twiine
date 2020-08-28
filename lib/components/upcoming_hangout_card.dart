import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twiine/components/time_difference.dart';

class UpcomingHangoutCard extends StatefulWidget {
  final String eventId;
  UpcomingHangoutCard({Key key, this.eventId});
  @override
  _UpcomingHangoutCardState createState() => _UpcomingHangoutCardState();
}

class _UpcomingHangoutCardState extends State<UpcomingHangoutCard> {
  final double _borderRadius = 10;

  String _place = "";
  String _address = "";
  String _thumbnail = "";
  bool _ready = false;
  DateTime _eventDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _getEventData();
    return Container(
      height: 125,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: InkWell(
          onTap: () => {},
          child: Row(
            children: <Widget>[
              Container(
                height: 125,
                width: 100,
                child: CachedNetworkImage(
                  imageUrl: _thumbnail,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(_borderRadius),
                        bottomLeft: Radius.circular(_borderRadius),
                      ),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TimeDifference(eventDate: _eventDate),
                    Container(
                      width: 200,
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(
                        _place,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(
                        _address,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getEventData() async {
    if (!_ready) {
      Map<String, dynamic> eventData = (await FirebaseFirestore.instance
              .collection("Events")
              .doc(widget.eventId)
              .get())
          .data();
      Map<String, dynamic> place = (await eventData["place"].get()).data();
      if (this.mounted) {
        setState(() {
          _thumbnail = place["image_url"];
          _address = "${place["city"]}, ${place["state"]}";
          _place = place["name"];
          _eventDate = (eventData["time"] as Timestamp).toDate();
        });
      }
    }
  }
}
