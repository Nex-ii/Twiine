import 'package:flutter/material.dart';
import 'package:twiine/components/TimeDifference.dart';

class UpcomingHangoutCard extends StatelessWidget {
  final double _borderRadius = 10;
  final String _place = "Crater Disaster Site";
  final String _address = "Itomori, Gifu";
  final String _thumbnail =
      "https://resi.ze-robot.com/dl/ki/kimi-no-na-wa-3-1280%C3%971024.jpg";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 125,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.network(_thumbnail).image,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TimeDifference(),
                  Padding(
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
    );
  }
}
