import 'package:flutter/material.dart';
import 'package:twiine/screens/post_login/scheduled/plannedDates.dart';

class Scheduled extends StatefulWidget {
  @override
  _ScheduledState createState() => _ScheduledState();
}

class _ScheduledState extends State<Scheduled> {
  List<dynamic> _selectedEvents;
  List<dynamic> _pastEvents;

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
        onPressed: () {
          Navigator.of(context).pushNamed('/addEvent').then(
            (onValue) {
              setState(
                () {
                  PlannedDates testing = onValue;
                  if (testing.dateInfo.isAfter(DateTime.now())) {
                    _selectedEvents.add(onValue);
                    sortSelected(0, _selectedEvents.length - 1);
                  } else {
                    _pastEvents.add(onValue);
                    sortPast(0, _pastEvents.length - 1);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
