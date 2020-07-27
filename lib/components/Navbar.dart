import 'package:flutter/material.dart';
import 'package:twiine/screens/post_login/home/home.dart';

import 'package:twiine/screens/post_login/profile/profile.dart';
import 'package:twiine/screens/post_login/requests/requests.dart';
import 'package:twiine/screens/post_login/scheduled/scheduled.dart';
import 'package:twiine/screens/post_login/favorites/favorites.dart';

class Navbar extends StatefulWidget {
  @override
  NavbarState createState() => NavbarState();
}

class NavbarState extends State<Navbar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Scheduled(),
    Profile(),
    Requests(),
    Home(),
    Favorites(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.event, color: Colors.black),
            title: Text("Scheduled", style: TextStyle(color: Colors.black)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            title: Text("Profile", style: TextStyle(color: Colors.black)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.black),
            title: Text("Requests", style: TextStyle(color: Colors.black)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.black),
            title: Text("Plan", style: TextStyle(color: Colors.black)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star, color: Colors.black),
            title: Text("Favorites", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
