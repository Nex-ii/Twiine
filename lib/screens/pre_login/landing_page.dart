import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget> [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purpleAccent, Colors.cyan]
              )
            )
          ),
          Center(
            child: Container(
              child: Text(
                "twiine",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                )
              )
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 50),
                  child: InkWell(
                    child: Container(
                      width: 150,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          width: 3,
                          color: Colors.white
                        ),
                        color: Colors.white
                      ),
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "SIGN UP",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black
                          )
                        )
                      )
                    ),
                    onTap: () => {},
                  )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 50),
                  child: InkWell(
                    child: Container(
                      width: 150,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          width: 3,
                          color: Colors.white
                        )
                      ),
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "LOG IN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white
                          )
                        )
                      )
                    ),
                    onTap: () => {
                      Navigator.of(context).pushNamed('/login')
                    }
                  )
                ),
              ],
            ),
          )
        ]
      )
    );
  }
}