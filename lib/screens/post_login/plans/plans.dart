import 'package:flutter/material.dart';
import 'package:twiine/components/PlansRequestsIndicator.dart';
import 'package:twiine/screens/post_login/plans/MyHangouts.dart';

class PlansPage extends StatefulWidget {
  @override
  PlansPageState createState() => PlansPageState();
}

class PlansPageState extends State<PlansPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double sideSpacing = screenWidth * 0.03;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(sideSpacing, 60, sideSpacing, 0),
          child: Column(
            children: <Widget>[
              PlansRequestsIndicator(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: MyHangouts(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
