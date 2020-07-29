import 'package:flutter/material.dart';
import 'package:twiine/colors.dart';

class PlansRequestsIndicator extends StatefulWidget {
  final int startingPage = 0;
  @override
  _PlansRequestsIndicatorState createState() => _PlansRequestsIndicatorState();
}

class _PlansRequestsIndicatorState extends State<PlansRequestsIndicator> {
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    // Styling
    TextStyle headerStyle = TextStyle(
      color: TwiineColors.red,
      fontSize: 18,
    );
    TextStyle headerStyleInactive = TextStyle(
      color: TwiineColors.grey,
      fontSize: 18,
    );
    return SizedBox(
      width: 282,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Center(
            child: Text(
              "My Hangouts",
              style: (_currentPage == 0) ? headerStyle : headerStyleInactive,
            ),
          ),
          Center(
            child: Text(
              "Requests",
              style: (_currentPage == 1) ? headerStyle : headerStyleInactive,
            ),
          ),
        ],
      ),
    );
  }
}
