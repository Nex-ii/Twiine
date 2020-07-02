import 'package:flutter/material.dart';

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final list = new List.generate(10, (i) => "Item ${i + 1}");
  List<String> trackerAccept = [];
  List<String> trackerCancel = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requests Screen'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(list[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              IconButton(
                  icon: Icon(Icons.check_circle),
                  color: trackerAccept.contains(list[index]) ? Colors.green : null,
                  onPressed: () {
                    setState(() {
                      if(trackerAccept.contains(list[index])) {
                        trackerAccept.remove(list[index]);
                      }else{
                        trackerAccept.add(list[index]);
                        trackerCancel.remove(list[index]);
                      }
                    });
                  }
              ),
              IconButton(
                  icon: Icon(Icons.cancel),
                  color: trackerCancel.contains(list[index]) ? Colors.red : null,
                  onPressed: () {
                    setState(() {
                      if(trackerCancel.contains(list[index])) {
                        trackerCancel.remove(list[index]);
                      }else{
                        trackerCancel.add(list[index]);
                        trackerAccept.remove(list[index]);
                      }
                    });
                  }
              ),
            ]),
          );
        }
      )
    );
  }
}
