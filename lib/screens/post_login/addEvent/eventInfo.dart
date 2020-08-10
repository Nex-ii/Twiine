import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:twiine/TwiineApi.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/common/app_text_field.dart';
import 'package:flutter/material.dart';

class EventInfo extends StatefulWidget {
  @override
  _EventInfoState createState() => _EventInfoState();
}

// break down into functions:
// image, title, daysUntilEvent, participants, time, date, weather, location
class _EventInfoState extends State<EventInfo> {

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

  Widget _getRowOfProfilePics() {
    final profilePics = <Widget>[];
    for(int i = 0; i < 5; i++){
      profilePics.add(_getTestImage());
    }
    return new Row(children: profilePics);
  }

  Widget EventTitle() {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 6.0,
                      bottom: 6.0,
                      left: 12.0,
                      right: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFBE000A),
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Text(
                    'in 2 days',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ),
                Container(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                  child: Text(
                    'Title',
                    style: TextStyle(fontSize: 36.0)
                  ),
                ),
                _getRowOfProfilePics(),
              ],
            ),
          )
        ],
      )
    );
  }
//
//  Widget EventSpecifications() {
//    return Row(
//
//    )
//  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.network('https://vignette.wikia.nocookie.net/kiminonawa/images/d/d9/Comet_Tiamat_by_Taki.png/revision/latest/scale-to-width-down/340?cb=20180718231515'),
          EventTitle(),
//          EventSpecifications(),
        ],
      )
    );
  }
}