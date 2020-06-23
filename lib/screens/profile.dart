import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Information"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // TODO: add a settings page?
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(height: 20),
            // Padding(padding: 10),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.brown.shade800,
              child: Text('test'),
            ),
            Container(height: 30),
            Text(
              "FIRSTNAME LASTNAME",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            )
          ],
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        currentIndex: 2,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list, color: Colors.black),
            title: Text("Feed", style: TextStyle(color: Colors.black))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event, color: Colors.black),
            title: Text("Scheduled", style: TextStyle(color: Colors.black))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            title: Text("Profile", style: TextStyle(color: Colors.black))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.black),
            title: Text("Requests", style: TextStyle(color: Colors.black))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.black),
            title: Text("Plan", style: TextStyle(color: Colors.black))
          ),
        ],
      )
    );
  }
}