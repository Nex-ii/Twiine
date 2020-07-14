import 'package:flutter/material.dart';
import 'package:twiine/screens/post_login/scheduled/plannedDates.dart';

class Scheduled extends StatefulWidget{
  @override
  _ScheduledState createState() => _ScheduledState();
}

class _ScheduledState extends State<Scheduled> {
  List<dynamic> _selectedEvents;

  void sort(){
    for(int a=0; a<_selectedEvents.length; a++){
      int tempIntYear = _selectedEvents[a].year;
      int tempIntMonth = _selectedEvents[a].month;
      int tempIntDay = _selectedEvents[a].day;
      int tempIntHour = _selectedEvents[a].hour;
      int tempIntMinute = _selectedEvents[a].minute;

      PlannedDates swap;
      for(int i = a+1; i<_selectedEvents.length; i++){
        int tempIntYear2 = _selectedEvents[i].year;
        int tempIntMonth2 = _selectedEvents[i].month;
        int tempIntDay2 = _selectedEvents[i].day;
        int tempIntHour2 = _selectedEvents[i].hour;
        int tempIntMinute2 = _selectedEvents[i].minute;


        if(tempIntYear == tempIntYear2){
          if(tempIntMonth == tempIntMonth2){
            if(tempIntDay == tempIntDay2){
              if(tempIntHour == tempIntHour2){
                if(tempIntMinute > tempIntMinute2){
                  swap = _selectedEvents[a];
                  _selectedEvents[a] = _selectedEvents[i];
                  _selectedEvents[i] = swap;
                }
              }else if(tempIntHour > tempIntHour2){
                swap = _selectedEvents[a];
                _selectedEvents[a] = _selectedEvents[i];
                _selectedEvents[i] = swap;
              }
            }else if(tempIntDay > tempIntDay2){
              swap = _selectedEvents[a];
              _selectedEvents[a] = _selectedEvents[i];
              _selectedEvents[i] = swap;
            }
          }else if(tempIntMonth > tempIntMonth2){
            swap = _selectedEvents[a];
            _selectedEvents[a] = _selectedEvents[i];
            _selectedEvents[i] = swap;
          }
        }else if(tempIntYear > tempIntYear2){
          swap = _selectedEvents[a];
          _selectedEvents[a] = _selectedEvents[i];
          _selectedEvents[i] = swap;
        }
      }
    }
  }

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
                    _selectedEvents[index].year.toString() +
                    '      ' +
                    _selectedEvents[index].hour.toString() +
                    ':' +
                    _selectedEvents[index].minute.toString()
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
                sort();
              });
            });
          },
     ),
    );
  }
}

