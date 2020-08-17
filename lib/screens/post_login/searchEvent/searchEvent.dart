
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twiine/screens/post_login/addEvent/addEvent.dart';

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

class SearchEvent extends StatelessWidget {
  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    if (search == "empty") return [];
    if (search == "error") throw Error();
    return List.generate(search.length, (int index) {
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }


  Widget _buildSearchBar() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SearchBar<Post>(
          onSearch: search,
          onItemFound: (Post post, int index) {
            return Container(
              color: Colors.orange,
              child: ListTile(
                title: Text(post.title),
                subtitle: Text(post.description),
                onTap: () {
                  //// Detail should be the page of the business information
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail()));
                },
              ),
            );
          },
          searchBarStyle: SearchBarStyle(
            borderRadius: BorderRadius.circular(100.0),
          ),
          icon: Icon(
            Icons.search,
            color: Colors.red,
            size: 35,
          ),
          hintText: 'Where do you want to hangout?',
          hintStyle: TextStyle(color: Colors.grey),
          textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          loader: Text("loading..."),
          placeHolder: Text("Placeholder"),
          onError: (error) {
            return Text("Error occurred: $error");
          },
          emptyWidget: Text("Empty"),
          crossAxisCount: 2,
        ),
    );
  }

  Widget _buildActivityIcon(IconData activityIcon, String activityString) {
    return FlatButton(
        onPressed: () => {},
        padding: EdgeInsets.all(10.0),
        child: Column( // Replace with a Row for horizontal icon + text
          children: <Widget>[
            Icon(activityIcon, size: 50,),
            Text(activityString),
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 100.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildActivityIcon(Icons.accessibility, "Testing"),
                      _buildActivityIcon(Icons.accessibility, "Testing"),
                      _buildActivityIcon(Icons.accessibility, "Testing"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildActivityIcon(Icons.accessibility, "Testing"),
                      _buildActivityIcon(Icons.accessibility, "Testing"),
                      _buildActivityIcon(Icons.accessibility, "Testing"),
                    ],
                  ),
                ],
              ),
            ),
            _buildSearchBar(),
          ],
        ),
      )
    );
  }

}
  

