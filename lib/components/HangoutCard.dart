import 'package:flutter/material.dart';
import 'package:twiine/colors.dart';

class HangoutCard extends StatefulWidget {
  String _place = "";
  String _location = "";
  String _thumbnail = "";
  @override
  _HangoutCardState createState() => _HangoutCardState();
}

class _HangoutCardState extends State<HangoutCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 195,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.network("https://resi.ze-robot.com/dl/ki/kimi-no-na-wa-3-1280%C3%971024.jpg").image,
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
                )
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 11, 3, 0),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Crater Disaster Site",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        "Itomori, Gifu",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  Container(
                    width: 73,
                    height: 21,
                    decoration: BoxDecoration(
                      color: TwiineColors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "in 2 days",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 9
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  // padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: SizedBox(
                            width: 28,
                            height: 28,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage("https://avatars0.githubusercontent.com/u/8981287?s=460&u=4bf37a144d65af7f4d6aa1616fd734f83b566fac&v=4"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: SizedBox(
                            width: 28,
                            height: 28,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage("https://avatars0.githubusercontent.com/u/8981287?s=460&u=4bf37a144d65af7f4d6aa1616fd734f83b566fac&v=4"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                )
              ],
            )
          ]
        ),
      ),
    );
  }
}