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
  final double _height = 125;
  final double _thumbnailwidth = 100;
  final double _cardwidth = 200;
  Map<String, dynamic> _eventData;

  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot> eventFuture = FirebaseFirestore.instance
        .collection("Events")
        .doc(widget.eventId)
        .get();
    return FutureBuilder(
      future: eventFuture,
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _eventData = snapshot.data.data();
          return FutureBuilder(
            future: snapshot.data.data()["place"].get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> place = snapshot.data.data();
                return Container(
                  height: _height,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_borderRadius),
                    ),
                    child: InkWell(
                      onTap: () => {},
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: _height,
                            width: _thumbnailwidth,
                            child: CachedNetworkImage(
                              imageUrl: place["image_url"],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                                TimeDifference(
                                  eventDate: _eventData["time"].toDate(),
                                ),
                                Container(
                                  width: _cardwidth,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    place["name"],
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    "${place["city"]}, ${place["state"]}",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
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
              } else {
                return Container();
              }
            },
          );
        } else {
          return Container(
            height: _height,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_borderRadius),
              ),
            ),
          );
        }
      },
    );
  }
}
