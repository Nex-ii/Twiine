
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

  String elipsesClipping(String str){
    if (str.length > 22) {
      str = str.substring(0, 19);
      str += '...';
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 100.0),
              child: SingleChildScrollView(
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
                    Container(
                      padding: EdgeInsets.only(left: 40.0),
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 218.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                          children: <Widget> [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(right: 12),
                                  width: 156.0,
                                  child: Container(
                                    height: 180.0,
                                    width: 144.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage('https://s3-alpha-sig.figma.com/img/f01a/5001/99dc80250b77326c8c83740bec65261a?Expires=1598832000&Signature=FSIebYqiZurd2zCmGQObaZ75ObIf7kwOi9Y4-v1nDdpEWvZ-WCgjK-4SQKUvZGLvaVlcEJnbqXJArn4-3mxNciCdjSh~R8agdAm7GvIWCdtaJAvM1cVu~pyhmboMm9Q1rUheleKV9wIgSPLAtVxVHatUgHP6SFLXNBnzGbeADChzCZjNv0E~ffneSVxYeUoy9sFEw78Klb6jv-nGGFFFeaOYxn3LEBmzgQzlyA-T6NOwPw4W2gebeXNAZ84ZOyx9PCHFJHLyvl7MZXWp9~f49gBpZvT~-yKgnmD9kq4IorFypt5EyYEeA1t~9EZR~BGMiTwgA3-DcEg5ILu8JA4AHw__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA'),
                                      )
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 156,
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    child: Text(
                                      "Polly's Pies Restaurant & Bakery", //'Bopomofo',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Text(
                                  'San Gabriel, CA',
                                  style: TextStyle(
                                    color: Colors.grey
                                  ),
                                ),
                              ]
                            ),
                            Container(
                              width: 156.0,
                              color: Colors.blue,
                            ),
                            Container(
                              width: 156.0,
                              color: Colors.green,
                            ),
                          ],
                      )
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 40.0),
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 200.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget> [
                            Container(
                              width: 160.0,
                              color: Colors.red,
                            ),
                            Container(
                              width: 160.0,
                              color: Colors.blue,
                            ),
                            Container(
                              width: 160.0,
                              color: Colors.green,
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),
            _buildSearchBar(),
          ],
        ),
      )
    );
  }

}
  

