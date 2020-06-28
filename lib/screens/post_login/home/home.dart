import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  HomeState createState() =>HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Map Screen"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed:() {
            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String>{
  final searchResults = [
    "this",
    "is",
    "a",
    "temporary",
    "list",
    "for",
    "testing"
  ];

  final recentSearch = [
    "temporary",
    "list"
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
      ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Card(
      //Put something here if you want something to happen upon clicking result
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentSearch
        : searchResults.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index)=>ListTile(
        onTap: (){
          showResults(context);
        },
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey))
            ]),
          ),
        ),
      itemCount: suggestionList.length,
    );
  }
}