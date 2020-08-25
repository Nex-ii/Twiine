import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/common/text_form.dart';

class Saved extends StatefulWidget {
  @override
  SavedState createState() => SavedState();
}

class SavedState extends State<Saved> {

  Widget getCategoryCard(String name, int size, String image_url, {double borderRadius = 10}){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 125,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.network(image_url).image,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                bottomLeft: Radius.circular(borderRadius),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Row> getCategoryList(){
    List<Row> rows = List();
    Map<String, List<String>> cats = Auth.userData["categories"];

    Row firstRow = Row(children: [],);
    cats.forEach((key, value) { })
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextForm.backBar(context, title: "Saved"),
      body: ListView.builder(
        padding: EdgeInsets.all(5),
        itemCount: (cats.length + 1) ~/ 2,
        itemBuilder: (context, index){
          return Row()
        },
      ),
    );
  }
}
