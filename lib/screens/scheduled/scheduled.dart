import 'package:flutter/material.dart';
import 'package:twiine/screens/scheduled/plannedDates.dart';

class Scheduled extends StatefulWidget{
  @override
  _ScheduledState createState() => _ScheduledState();
}

class _ScheduledState extends State<Scheduled> {
  createAlertDialog(BuildContext context) {

    TextEditingController customController = TextEditingController();
    return showDialog(context: context, builder:(context) {
      return AlertDialog(
        title: Text("Your Name"),
        content: TextField(
          controller: customController,
        ),
        actions: <Widget>[
          
        ]
      );
    });
  }

  List<PlannedDates> calendar = [
    PlannedDates(day: 1, month: 5, year: 1983, name: 'Dinner'),
    PlannedDates(day: 20, month: 9, year: 2018, name: 'Something cool'),
    PlannedDates(day: 4, month: 11, year: 2020, name: 'Party')
  ];

  final list = new List.generate(3, (i) => "Item ${i + 1}");
  TextEditingController _eventController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Scheduled Screen'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
          itemCount: calendar.length,
          itemBuilder: (context, index) =>
              ExpansionTile(
                title: Text(calendar[index].month.toString() + '/' +
                    calendar[index].day.toString() + '/' +
                    calendar[index].year.toString() + '   ' +
                    calendar[index].name),
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
          onPressed: (){},
     ),
    );
  }
}

