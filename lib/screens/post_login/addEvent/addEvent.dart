import 'package:flutter/material.dart';

class addEvent extends StatefulWidget {
  @override
  _addEventState createState() => _addEventState();
}

class _addEventState extends State<addEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Event'),
      )
    );
  }
}
