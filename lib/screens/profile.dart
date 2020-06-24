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
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.brown,
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
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                  children: ListTile.divideTiles( //          <-- ListTile.divideTiles
                  context: context,
                  tiles: [
                    ListTile(
                      title: Text("Profile Details"),
                      subtitle: Text("FIRSTNAME LASTNAME"),
                      onTap: () {
                        // TODO: Edit profile page
                      },
                    ),
                    ListTile(
                      title: Text("Button 2"),
                      subtitle: Text("Button 2"),
                      onTap: () {
                        // TODO: add button
                      },
                    ),
                    ListTile(
                      title: Text("Button 3"),
                      subtitle: Text("Button 3"),
                      onTap: () {
                        // TODO: add button
                      },
                    ),
                    ListTile(
                      title: Text("Button 4"),
                      subtitle: Text("Button 4"),
                      onTap: () {
                        // TODO: add button
                      },
                    ),
                    ListTile(
                      title: Text("Button 5"),
                      subtitle: Text("Button 5"),
                      onTap: () {
                        // TODO: add button
                      },
                    )
                  ]
                ).toList()
              )
            )
          ]
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
          )
        ]
      )
    );
  }
}