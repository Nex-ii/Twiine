import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twiine/colors.dart';
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

  final String searchIcon = "assets/icons/searchIcon.svg";
  final String mapIcon = "assets/icons/mapIcon.svg";
  final String addIcon = "assets/icons/addIcon.svg";
  final String calendarIcon = "assets/icons/calendarIcon.svg";
  final String personIcon = "assets/icons/personIcon.svg";
  final String gearIcon = "assets/icons/settings.svg";

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
    return WillPopScope(
        onWillPop: () async {
          return showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(
                    title: Text("Do you really wish to quit?"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("No"),
                        onPressed: () => Navigator.pop(context, false),
                      ),
                      FlatButton(
                        child: Text("Yes"),
                        onPressed: (){
                          Navigator.pop(context, true);
                          SystemNavigator.pop();
                        },
                      )
                    ],
                  ));
        },
        child: new Scaffold(
          body: _children[_currentIndex],
          appBar: AppBar(
            title: Text("twiine"),
            actions: <Widget>[PopupMenuButton(
                onSelected: (r) => r(),
                initialValue: null,
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<Function>>[
                  PopupMenuItem<Function>(
                    value: _settings,
                    child: Text("Settings"),
                  ),
                  PopupMenuItem<Function>(
                    value: _logout,
                    child: Text("Log out"),
                  ),
                ]
            )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: TwiineColors.red,
            type: BottomNavigationBarType.fixed,
            onTap: onTappedBar,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: _currentIndex == 0
                    ? SvgPicture.asset(searchIcon, color: TwiineColors.red)
                    : SvgPicture.asset(searchIcon),
                title: Text(""),
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 1
                    ? SvgPicture.asset(mapIcon, color: TwiineColors.red)
                    : SvgPicture.asset(mapIcon),
                title: Text(""),
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 2
                    ? SvgPicture.asset(addIcon, color: TwiineColors.red)
                    : SvgPicture.asset(addIcon),
                title: Text(""),
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 3
                    ? SvgPicture.asset(calendarIcon, color: TwiineColors.red)
                    : SvgPicture.asset(calendarIcon),
                title: Text(""),
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 4
                    ? SvgPicture.asset(personIcon, color: TwiineColors.red)
                    : SvgPicture.asset(personIcon),
                title: Text(""),
              ),
            ],
          ),
        ));
  }

  _logout() async{
    Navigator.pushNamedAndRemoveUntil(context, '/landing', (route) => false);
  }

  _settings(){
  }

}
