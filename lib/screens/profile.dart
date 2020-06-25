import 'package:flutter/material.dart';
import 'package:twiine/components/Navbar.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  double cardRadius = 20.0;

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
              offset: Offset(0, 4), // changes position of shadow
            )
          ]
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this.cardRadius),
          ),
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            width: 220,
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
                      // fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white
                    )
                  ),
                ),
              ],
            )
          ),
        ),
      )
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(this.cardRadius),
                      bottomLeft: Radius.circular(this.cardRadius)
                    ),
                    color: Colors.redAccent[200],
                    boxShadow:  [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                      )
                    ]
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(height: 60),
                      CircleAvatar(
                        backgroundImage: NetworkImage("https://avatars0.githubusercontent.com/u/8981287?s=460&u=4bf37a144d65af7f4d6aa1616fd734f83b566fac&v=4"),
                        radius: 60,
                        backgroundColor: Colors.brown,
                        child: Text('test'),
                      ),
                      Container(height: 10),
                      Text(
                        "@realwayson",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white
                        )
                      ),
                      Container(height: 30),
                    ],
                  ),
                ),
              ),
              // Container(height: 20),
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Text(
                  "Recent Places",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: this.cardRadius),
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    createPlaceCard("7 Leaves", "https://cdn.vox-cdn.com/thumbor/31J1fxcgvG5a_kT4pMnVhwP9bxM=/0x0:1402x1752/1200x800/filters:focal(522x1001:746x1225)/cdn.vox-cdn.com/uploads/chorus_image/image/64736820/7_leaves_teahouse.0.jpg"),
                    createPlaceCard("Ding Tea", "https://d1725r39asqzt3.cloudfront.net/aaa7aca1-a5ba-4740-a656-4ef0e5c3e52c/orig.jpg"),
                    createPlaceCard("7 Leaves", "https://cdn.vox-cdn.com/thumbor/31J1fxcgvG5a_kT4pMnVhwP9bxM=/0x0:1402x1752/1200x800/filters:focal(522x1001:746x1225)/cdn.vox-cdn.com/uploads/chorus_image/image/64736820/7_leaves_teahouse.0.jpg"),
                  ],
                ),
              )
            ],
          ),
        ), 
      ),
      bottomNavigationBar: Navbar(1),
    );
  }
}