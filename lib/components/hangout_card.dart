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
  List<Image> _userThumbnails = [];
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
                _eventData["users"].forEach((name, pictureUrl) {
                  if (pictureUrl != "")
                    _userThumbnails.add(Image.network(pictureUrl));
                  else
                    _userThumbnails
                        .add(Image.asset("assets/default_profile.png"));
                });
                return Container(
                  height: 330,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_borderRadius),
                    ),
                    child: InkWell(
                      onTap: () => {},
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 219,
                            child: CachedNetworkImage(
                              imageUrl: place["image_url"],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
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
                                    TimeDifference(
                                      eventDate: _eventData["time"].toDate(),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                        place["name"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
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
                                  child: SizedBox(
                                    height: 37,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: _userThumbnails.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(3, 3, 3, 10),
                                          child: SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircleAvatar(
                                              backgroundImage:
                                                  _userThumbnails[index].image,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
            height: 330,
            child: Card(),
          );
        }
      },
    );
  }
}
