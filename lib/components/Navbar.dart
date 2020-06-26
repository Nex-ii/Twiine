import 'package:flutter/material.dart';
import 'package:twiine/screens/home/home.dart';
import 'package:twiine/screens/profile/profile.dart';

class Navbar extends StatefulWidget{
  @override
  NavbarState createState() => NavbarState();
}

class NavbarState extends State<Navbar>{
  int _currentIndex = 3;
  final List<Widget> _children = [
    //Scheduled(),
    Home(), //Temp
    Profile(),
    //Requests(),
    Home(),
    Profile(),//Temp
  ];

  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTappedBar,
          currentIndex: _currentIndex,

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
          ],
      ),
    );
  }
}

