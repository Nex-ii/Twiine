import 'package:flutter/material.dart';
import 'package:twiine/components/TimeDifference.dart';

class HangoutCard extends StatelessWidget {
  double _borderRadius = 10;
  String _place = "Crater Disaster Site";
  String _thumbnail = "https://i.imgur.com/oRt7Kcm.png";
  @override
  Widget build(BuildContext context) {
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.network(_thumbnail).image,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                ),
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
                      TimeDifference(),
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
}