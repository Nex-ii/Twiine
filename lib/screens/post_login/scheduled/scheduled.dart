import 'package:twiine/auth.dart';
import 'package:flutter/material.dart';
import 'package:twiine/screens/post_login/scheduled/plannedDates.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Scheduled extends StatefulWidget {
  @override
  _ScheduledState createState() => _ScheduledState();
}

class _ScheduledState extends State<Scheduled> {
  List<dynamic> _selectedEvents;
  List<dynamic> _pastEvents;
  String userID;

  int partitionSelected(int low, int high) {
    PlannedDates pivot = _selectedEvents[high];
    int i = (low - 1); // index of smaller element
    for (int j = low; j < high; j++) {
      // If current element is smaller than the pivot
      if (pivot.dateInfo.isAfter(_selectedEvents[j].dateInfo)) {
        i++;

        // swap arr[i] and arr[j]
        PlannedDates temp = _selectedEvents[i];
        _selectedEvents[i] = _selectedEvents[j];
        _selectedEvents[j] = temp;
      }
    }

    // swap arr[i+1] and arr[high] (or pivot)
    PlannedDates temp = _selectedEvents[i + 1];
    _selectedEvents[i + 1] = _selectedEvents[high];
    _selectedEvents[high] = temp;

    return i + 1;
  }

  /* The main function that implements QuickSort()
    arr[] --> Array to be sorted,
    low  --> Starting index,
    high  --> Ending index */

  void sortSelected(int low, int high) {
    if (low < high) {
      /* pi is partitioning index, arr[pi] is
            now at right place */
      int pi = partitionSelected(low, high);

      // Recursively sort elements before
      // partition and after partition
      sortSelected(low, pi - 1);
      sortSelected(pi + 1, high);
    }
  }

  int partitionPast(int low, int high) {
    PlannedDates pivot = _pastEvents[high];
    int i = (low - 1); // index of smaller element
    for (int j = low; j < high; j++) {
      // If current element is smaller than the pivot
      if (pivot.dateInfo.isAfter(_pastEvents[j].dateInfo)) {
        i++;

        // swap arr[i] and arr[j]
        PlannedDates temp = _pastEvents[i];
        _pastEvents[i] = _pastEvents[j];
        _pastEvents[j] = temp;
      }
    }

    // swap arr[i+1] and arr[high] (or pivot)
    PlannedDates temp = _pastEvents[i + 1];
    _pastEvents[i + 1] = _pastEvents[high];
    _pastEvents[high] = temp;

    return i + 1;
  }

  /* The main function that implements QuickSort()
    arr[] --> Array to be sorted,
    low  --> Starting index,
    high  --> Ending index */

  void sortPast(int low, int high) {
    if (low < high) {
      /* pi is partitioning index, arr[pi] is
            now at right place */
      int pi = partitionPast(low, high);

      // Recursively sort elements before
      // partition and after partition
      sortPast(low, pi - 1);
      sortPast(pi + 1, high);
    }
  }


  @override
  void initState() {
    super.initState();
    _selectedEvents = [];
    _pastEvents = [];
    getEvents();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scheduled Screen'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
            child: Text(
              "Upcoming Events",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedEvents.length,
              itemBuilder: (context, index) => ExpansionTile(
                title: Text(_selectedEvents[index].month.toString() +
                    '/' +
                    _selectedEvents[index].day.toString() +
                    '/' +
                    _selectedEvents[index].year.toString() +
                    '      ' +
                    _selectedEvents[index].hour.toString() +
                    ':' +
                    _selectedEvents[index].minute.toString()),
                children: <Widget>[
                  new ListTile(
                    title: Text(_selectedEvents[index].name),
                  ),
                  new ListTile(
                    title: Text(_selectedEvents[index].location),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
            child: Text(
              "Previous Events",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _pastEvents.length,
              itemBuilder: (context, index) => ExpansionTile(
                title: Text(
                  _pastEvents[index].month.toString() +
                      '/' +
                      _pastEvents[index].day.toString() +
                      '/' +
                      _pastEvents[index].year.toString() +
                      '      ' +
                      _pastEvents[index].hour.toString() +
                      ':' +
                      _pastEvents[index].minute.toString(),
                ),
                children: <Widget>[
                  new ListTile(
                    title: Text(_pastEvents[index].name),
                  ),
                  new ListTile(
                    title: Text(_pastEvents[index].location),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.of(context).pushNamed('/addEvent').then(
            (onValue) {
              //TODO: Debug database issues
              PlannedDates temp = onValue;
              FirebaseFirestore.instance.collection('Events').add({
                "location": temp.location,
                "time" : Timestamp.fromDate(temp.dateInfo),
                "title" : temp.name,
                "userID" : userID,
              }).then((value){
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(userID)
                    .update({"events": FieldValue.arrayUnion([value.id])});
              });
              getEvents();
            },
          );
        },
      ),
    );
  }

  void getEvents() async{
    List<dynamic> temp = Auth.userData['events'];
      for(int i=0; i<temp.length; i++){
        String documentID = temp[i].documentID;
        FirebaseFirestore.instance
            .collection('Events')
            .doc(documentID)
            .get()
            .then((value2) {
            PlannedDates newDate = PlannedDates();
            newDate.name = value2.get('title');
            newDate.location = value2.get('location');
            newDate.dateInfo = value2.get('time').toDate();
            newDate.day = newDate.dateInfo.day;
            newDate.month = newDate.dateInfo.month;
            newDate.year = newDate.dateInfo.year;
            newDate.hour = newDate.dateInfo.hour;
            newDate.minute = newDate.dateInfo.minute;

            setState(() {
              if(newDate.dateInfo.isAfter(DateTime.now())){
                _selectedEvents.add(newDate);
                sortSelected(0, _selectedEvents.length - 1);
              }else{
                _pastEvents.add(newDate);
                sortPast(0, _pastEvents.length - 1);
              }
            });
        });
        }
      }
    }
