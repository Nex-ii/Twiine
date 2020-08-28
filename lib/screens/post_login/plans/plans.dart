import 'package:flutter/material.dart';
import 'package:twiine/screens/post_login/plans/my_hangouts.dart';
import 'package:twiine/colors.dart';

class PlansPage extends StatefulWidget {
  @override
  PlansPageState createState() => PlansPageState();
}

class PlansPageState extends State<PlansPage> with TickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double sideSpacing = screenWidth * 0.03;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: false,
              backgroundColor: Colors.transparent,
              bottom: TabBar(
                indicatorColor: TwiineColors.red,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: TwiineColors.red,
                unselectedLabelColor: TwiineColors.grey,
                labelStyle: TextStyle(fontSize: 18),
                tabs: [
                  Tab(text: "My Hangouts"),
                  Tab(text: "Requests"),
                ],
                controller: controller,
              ),
            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.fromLTRB(sideSpacing, 0, sideSpacing, 0),
          child: TabBarView(
            controller: controller,
            children: <Widget>[
              MyHangouts(),
              MyHangouts(),
            ],
          ),
        ),
      ),
    );
  }
}
