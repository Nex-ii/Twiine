import 'package:flutter/material.dart';
import 'package:twiine/auth.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  double _cardRadius = 20.0;
  double _cardHeight = 290.0;
  double _cardWidth = 190.0;

  // TODO: we probably don't want to leave this as a url
  // Returns a card with the name of the place and the image url as the background
  Container createPlaceCard(String name, String url) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 7),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: -2,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this._cardRadius),
          ),
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            width: this._cardWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(this._cardRadius),
                  bottomLeft: Radius.circular(this._cardRadius),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purpleAccent, Colors.cyan],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: IconButton(
                        icon: Icon(Icons.settings),
                        color: Colors.white,
                        onPressed: () {
                          // TODO: settings page
                        },
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://avatars0.githubusercontent.com/u/8981287?s=460&u=4bf37a144d65af7f4d6aa1616fd734f83b566fac&v=4"),
                    radius: 60,
                    backgroundColor: Colors.brown,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: TextFormField(
                      initialValue: Auth.user.email,
                      decoration: InputDecoration(border: InputBorder.none),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
            child: Text(
              "Recent Places",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: this._cardRadius),
            height: this._cardHeight,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                createPlaceCard("7 Leaves",
                    "https://cdn.vox-cdn.com/thumbor/31J1fxcgvG5a_kT4pMnVhwP9bxM=/0x0:1402x1752/1200x800/filters:focal(522x1001:746x1225)/cdn.vox-cdn.com/uploads/chorus_image/image/64736820/7_leaves_teahouse.0.jpg"),
                createPlaceCard("Ding Tea",
                    "https://d1725r39asqzt3.cloudfront.net/aaa7aca1-a5ba-4740-a656-4ef0e5c3e52c/orig.jpg"),
                createPlaceCard("7 Leaves",
                    "https://cdn.vox-cdn.com/thumbor/31J1fxcgvG5a_kT4pMnVhwP9bxM=/0x0:1402x1752/1200x800/filters:focal(522x1001:746x1225)/cdn.vox-cdn.com/uploads/chorus_image/image/64736820/7_leaves_teahouse.0.jpg"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text(
              "Placeholder section",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: this._cardRadius),
            height: this._cardHeight,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                createPlaceCard("Ding Tea",
                    "https://d1725r39asqzt3.cloudfront.net/aaa7aca1-a5ba-4740-a656-4ef0e5c3e52c/orig.jpg"),
                createPlaceCard("7 Leaves",
                    "https://cdn.vox-cdn.com/thumbor/31J1fxcgvG5a_kT4pMnVhwP9bxM=/0x0:1402x1752/1200x800/filters:focal(522x1001:746x1225)/cdn.vox-cdn.com/uploads/chorus_image/image/64736820/7_leaves_teahouse.0.jpg"),
                createPlaceCard("7 Leaves",
                    "https://cdn.vox-cdn.com/thumbor/31J1fxcgvG5a_kT4pMnVhwP9bxM=/0x0:1402x1752/1200x800/filters:focal(522x1001:746x1225)/cdn.vox-cdn.com/uploads/chorus_image/image/64736820/7_leaves_teahouse.0.jpg"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
