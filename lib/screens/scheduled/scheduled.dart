import 'package:flutter/material.dart';
import 'package:twiine/screens/scheduled/plannedDates.dart';


class Scheduled extends StatefulWidget{
  @override
  _ScheduledState createState() => _ScheduledState();
}

class _ScheduledState extends State<Scheduled> {
  List<PlannedDates> calendar = [
    PlannedDates(day: 1, month: 5, year: 1983, name: 'Dinner'),
    PlannedDates(day: 20, month: 9, year: 2018, name: 'SOmething cool'),
    PlannedDates(day: 4, month: 11, year: 2020, name: 'Party')
  ];

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
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Text(calendar[index].month.toString() + '/' +
                          calendar[index].day.toString() + '/' +
                          calendar[index].year.toString() + '   ' +
                          calendar[index].name),
            ),
          );
        }
      )
    );
  }
}


