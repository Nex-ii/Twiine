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
  DateTime _eventDate = DateTime.now();
  double _borderRadius = 10;
  String _place = "";
  String _thumbnail = "";
  List<Image> _userThumbnails = [];
  Map<String, dynamic> _eventData;
  bool _ready = false;
  @override
  Widget build(BuildContext context) {
    _getEventData();
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
                      child: SizedBox(
                        height: 37,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _userThumbnails.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(3, 3, 3, 10),
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircleAvatar(
                                  backgroundImage: _userThumbnails[index].image,
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
  }

  void _getEventData() async {
    List<Image> userThumbnails = [];
    if (!_ready) {
      Map<String, dynamic> eventData = (await Firestore.instance
              .collection("Events")
              .document(widget.eventId)
              .get())
          .data;
      Map<String, dynamic> place = (await eventData["place"].get()).data;
      if (this.mounted) {
        for (DocumentReference userRef in eventData["users"]) {
          var user = (await userRef.get()).data;
          if (user.containsKey("pictureUrl")) {
            userThumbnails.add(Image.network(user["pictureUrl"]));
          } else {
            userThumbnails.add(Image.asset("assets/default_profile.png"));
          }
        }
        setState(() {
          _thumbnail = place["image_url"];
          _place = place["name"];
          _eventDate = (eventData["time"] as Timestamp).toDate();
          _eventData = eventData;
          _userThumbnails = userThumbnails;
          _ready = true;
        });
      }
    }
  }
}
