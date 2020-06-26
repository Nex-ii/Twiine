import 'package:flutter/material.dart';

class Navbar extends BottomNavigationBar {
  Navbar(int index) : super(
    showUnselectedLabels: true,
    currentIndex: index,
    items: [
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
  );
}