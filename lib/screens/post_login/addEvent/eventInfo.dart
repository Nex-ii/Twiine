import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:twiine/TwiineApi.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/common/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:twiine/components/time_difference.dart';

class EventInfo extends StatefulWidget {
  @override
  _EventInfoState createState() => _EventInfoState();
}

// break down into functions:
// image, title, daysUntilEvent, participants, time, date, weather, location
class _EventInfoState extends State<EventInfo> {

  Widget _buildEventImage() {
    return Image.network('https://i.pinimg.com/originals/fd/d5/e4/fdd5e418094d8d41a10c0df3807f3a23.jpg');
  }

  Widget _buildExitButton(){
    return IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.cancel,
          size: 32.0,
          color: Colors.white,
        )
    );
  }

  Widget _buildCountdown(){
    return TimeDifference();
//    return Container(
//        padding: const EdgeInsets.only(
//          top: 6.0,
//          bottom: 6.0,
//          left: 12.0,
//          right: 12.0,
//        ),
//        decoration: BoxDecoration(
//            color: Color(0xFFBE000A),
//            borderRadius: BorderRadius.circular(5.0)
//        ),
//        child: Text(
//          'in 2 days',
//          style: TextStyle(
//            fontSize: 12,
//            fontWeight: FontWeight.bold,
//            color: Colors.white,
//          ),
//        )
//    );
  }

  Widget _buildTitle(){
    return Container(
      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
      child: Text(
          'Meteor Site',
          style: TextStyle(fontSize: 36.0)
      ),
    );
  }

  // test image to simulate an image from db
  Widget _getTestImage() {
    return Container(
        width: 30.0,
        height: 30.0,
        decoration: new BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
              fit: BoxFit.fill,
            )
        )
    );
  }

  // current: gets test image 5x and adds to list
  // future update: gets profile pics from db and adds to list
  Widget _buildRowOfProfilePics() {
    final profilePics = <Widget>[];
    for(int i = 0; i < 5; i++){
      profilePics.add(_getTestImage());
    }
    return new Row(children: profilePics);
  }

  Widget _buildAdditionalProfilePicsButton() {
    return FlatButton(
        onPressed: ()
        { },
        child: Text(
            "+2 more",
            style: TextStyle(
                color: const Color(0xFFFF6E5E)
            )
        )
    );
  }

  Widget _buildTime(){
    return Container(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(Icons.alarm, size: 34.0,),
          Padding(
            padding: EdgeInsets.only(left: 11.0),
            child: Text(
              '1:00 PM',
              style: TextStyle(fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDate(){
    return Container(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(Icons.calendar_today, size: 34.0,),
          Padding(
            padding: EdgeInsets.only(left: 11.0),
            child: Text(
              'Wed, July 15',
              style: TextStyle(fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWeather() {
    return Container(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(Icons.brightness_5, size: 34.0,),
          Padding(
            padding: EdgeInsets.only(left: 11.0),
            child: Text(
              '80 °F, Sunny',
              style: TextStyle(fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }

  Widget EventImage() {
    return Stack(
      children: [
        _buildEventImage(),
        Positioned(
            top: 12.0,
            left: 16.0,
            child: _buildExitButton()
        ),
      ],
    );
  }

  Widget EventTitle() {
    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCountdown(),
                    _buildTitle(),
                    Row(
                      children: [
                        _buildRowOfProfilePics(),
                        _buildAdditionalProfilePicsButton()
                      ]
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 12.0),
                        child: Divider(color: const Color(0xFFC4C4C4),)
                    )
                  ],
                ),
              ),
            ],
          )
        ),
        Positioned(
          top: 12.0,
          right: 16.0,
          child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.info, size: 30.0)
          ),
        )
      ]

    );
  }

  Widget EventSpecifications() {
    return Container(
      padding: EdgeInsets.only(left: 32.0, right: 32.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTime(),
                _buildDate(),
                _buildWeather(),
                Divider(color: const Color(0xFFC4C4C4),)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 24.0),
          child: Column(
            children: [
              EventImage(),
              EventTitle(),
              EventSpecifications(),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Image.network('https://firebasestorage.googleapis.com/v0/b/twiine.appspot.com/o/Test%20Location.PNG?alt=media&token=0b8d6236-2a08-47cb-9023-9be21b47ba8f'),
              )
            ],
          ),
        ),
      )
    );
  }
}