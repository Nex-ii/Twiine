import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/common/text_form.dart';
import 'package:twiine/twiine_api.dart';

class Saved extends StatefulWidget {
  @override
  SavedState createState() => SavedState();
}

class SavedState extends State<Saved> {
  Widget getCategoryCard(String name, String imageUrl, int size,
      {double borderRadius = 10}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Saved()),
              )
            },
            child: Container(
              height: 170,
              width: 170,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.network(imageUrl).image,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              size.toString(),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget invisibleCard() {
    return Visibility(
      visible: true,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 170,
              width: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(""),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Widget>> getCategoryList() async {
    Map<String, dynamic> cats = Auth.userData["saved"];
    List<Row> rows = List();

    String demoImage;
    List<Widget> cards = List();
    int total = 0;
    return Future.forEach(cats.entries, (entry) async {
      total += entry.value.length;
      String categoryUrl;
      var doc = await TwiineApi.getDocument(
          entry.value[0].split('/')[1], entry.value[0].split('/')[2]);
      categoryUrl = doc.data()["image_url"];
      cards.add(getCategoryCard(entry.key, categoryUrl, entry.value.length));
      if (demoImage == null) demoImage = categoryUrl;
    }).then((value) {
      cards.insert(0, getCategoryCard("All Saved", demoImage, total));
      for (int i = 0; i < cards.length; i += 2) {
        Row r = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        );
        r.children.add(cards[i]);
        if (i + 1 < cards.length) {
          r.children.add(cards[i + 1]);
        } else {
          r.children.add(invisibleCard());
        }
        rows.add(r);
      }
      return rows;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextForm.backBar(context, title: "Saved"),
      body: FutureBuilder<List<Widget>>(
        future: getCategoryList(),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          List<Widget> rows;
          Widget body;
          if (snapshot.hasData) {
            rows = snapshot.data;
            body = ListView.builder(
                itemCount: rows.length,
                itemBuilder: (context, index) {
                  return rows[index];
                });
          } else if (snapshot.hasError) {
            body = SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            );
          } else {
            body = SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            );
          }
          return body;
        },
      ),
    );
  }
}
