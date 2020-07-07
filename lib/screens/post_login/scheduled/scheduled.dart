import 'package:flutter/material.dart';
import 'package:twiine/screens/post_login/scheduled/plannedDates.dart';

class Scheduled extends StatefulWidget{
  @override
  _ScheduledState createState() => _ScheduledState();
}

class _ScheduledState extends State<Scheduled> {
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
                title: Text(
                    _selectedEvents[index].month.toString() +
                    '/' +
                    _selectedEvents[index].day.toString() +
                    '/' +
                    _selectedEvents[index].year.toString()
                ),
                children: <Widget>[
                  new ListTile(
                    title: Text(_selectedEvents[index].name),
                  ),
                  new ListTile(
                    title: Text(_selectedEvents[index].location),
                  )
                ]
              ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.of(context).pushNamed('/addEvent').then((onValue){
              setState((){
                _selectedEvents.add(onValue);
              });
            });
          },
     ),
    );
  }
}

