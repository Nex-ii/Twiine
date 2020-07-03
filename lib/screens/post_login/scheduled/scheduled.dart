import 'package:flutter/material.dart';
import 'package:twiine/screens/post_login/scheduled/plannedDates.dart';

class Scheduled extends StatefulWidget{
  @override
  _ScheduledState createState() => _ScheduledState();
}

class _ScheduledState extends State<Scheduled> {
////  Future<String> createAlertDialog(BuildContext context) {
////    TextEditingController customController = TextEditingController();
////    return showDialog(context: context, builder:(context) {
////      return AlertDialog(
////        title: Text("Add New Event"),
////        content: TextField(
////          controller: customController,
////        ),
////        actions: <Widget>[
////          MaterialButton(
////            elevation: 5.0,
////            child: Text('Save'),
////            onPressed:(){
////              Navigator.of(context).pop(customController.text.toString());
////            },
////          )
////        ]
////      );
////    });
//  }

  List<dynamic> _selectedEvents;
  final list = new List.generate(3, (i) => "Item ${i + 1}");

  @override
  void initState(){
    super.initState();
    _selectedEvents = [];
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Scheduled Screen'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
          itemCount: _selectedEvents.length,
          itemBuilder: (context, index) =>
              ExpansionTile(
                title: Text(_selectedEvents[index]),
                children: list
                    .map((val) =>
                new ListTile(
                  title: new Text(val),
                ))
                    .toList(),
              ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
//            createAlertDialog(context).then((onValue) {
//              setState(() {
//                _selectedEvents.add(onValue);
//              });
//            });
            Navigator.of(context).pushNamed('/addEvent');
          },
     ),
    );
  }
}

