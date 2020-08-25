

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/screens/post_login/addEvent/addEvent.dart';
import 'package:twiine/screens/post_login/profile/profile.dart';

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

class SearchEvent extends StatelessWidget {

  // Icon Asset Paths
  final String restaurantsIcon = 'assets/icons/restaurant-svgrepo-com.svg';
  final String barsAndClubsIcon = 'assets/icons/cocktail-svgrepo-com.svg';
  final String amusementIcon = 'assets/icons/amusement-park-svgrepo-com.svg';
  final String photoshootsIcon = 'assets/icons/camera-svgrepo-com.svg';
  final String natureIcon = 'assets/icons/tree-svgrepo-com.svg';
  final String moreIcon = 'assets/icons/more-svgrepo-com.svg';

  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    if (search == "empty") return [];
    if (search == "error") throw Error();
    return List.generate(search.length, (int index) {
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }

  Widget _buildSearchBar() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SearchBar<Post>(
          onSearch: search,
          onItemFound: (Post post, int index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListTile(
                title: Text(post.title),
                subtitle: Text(post.description),
                onTap: () {
                  //// Description should be the page of the business information
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail()));
                },
              ),
            );
          },
          searchBarStyle: SearchBarStyle(
            borderRadius: BorderRadius.circular(100.0),
          ),
          icon: Icon(
            Icons.search,
            color: TwiineColors.red,
            size: 35,
          ),
          hintText: 'Where do you want to hangout?',
          hintStyle: TextStyle(color: Colors.grey),
          textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          loader: Text('loading...'),
          placeHolder: Text(''),
          onError: (error) {
            return Text('Error occurred: $error');
          },
          emptyWidget: Text("Empty"),
          crossAxisCount: 1,
        ),
    );
  }

  Widget _buildActivityIcon(String iconAssetPath, String activityString) {
    return Expanded(
      child: FlatButton(
          onPressed: () => {},
          padding: EdgeInsets.all(10.0),
          child: Column( // Replace with a Row for horizontal icon + text
            children: <Widget>[
              SvgPicture.asset(iconAssetPath, width: 30, height: 30, color: TwiineColors.red,),
              Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(activityString, style: TextStyle(color: Colors.black),)
              ),
            ],
          ),
      ),
    );
  }

  Widget _buildListTitle(String title){
    return Container(
      padding: EdgeInsets.only(left: 12.0, top: 13.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, color: Colors.black),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildBusinessCard(NetworkImage businessImage, String restaurantName, String restaurantLocation) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(right: 12),
            width: 156.0,
            child: Container(
              height: 180.0,
              width: 144.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: businessImage,
                  )
              ),
            ),
          ),
          Container(
            width: 156,
            padding: EdgeInsets.only(top: 10.0),
            child: Container(
              child: Text(
                restaurantName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black,),
              ),
            ),
          ),
          Text(
            restaurantLocation,
//            style: TextStyle(
//                color: Colors.grey
//            ),
          ),
        ]
    );
  }

 // Should also take in a List of information from the database to convert into business cards and not these static cards
  List<Widget> _buildRecommendationList(String title) {
    return [
      Align(
          alignment: Alignment.centerLeft,
          child: _buildListTitle(title)
      ),
      Container(
          padding: EdgeInsets.only(left: 12.0, right: 12.0),
          height: 218.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget> [
              _buildBusinessCard(
                  NetworkImage('https://s3-alpha-sig.figma.com/img/f01a/5001/99dc80250b77326c8c83740bec65261a?Expires=1598832000&Signature=FSIebYqiZurd2zCmGQObaZ75ObIf7kwOi9Y4-v1nDdpEWvZ-WCgjK-4SQKUvZGLvaVlcEJnbqXJArn4-3mxNciCdjSh~R8agdAm7GvIWCdtaJAvM1cVu~pyhmboMm9Q1rUheleKV9wIgSPLAtVxVHatUgHP6SFLXNBnzGbeADChzCZjNv0E~ffneSVxYeUoy9sFEw78Klb6jv-nGGFFFeaOYxn3LEBmzgQzlyA-T6NOwPw4W2gebeXNAZ84ZOyx9PCHFJHLyvl7MZXWp9~f49gBpZvT~-yKgnmD9kq4IorFypt5EyYEeA1t~9EZR~BGMiTwgA3-DcEg5ILu8JA4AHw__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA'),
                  'Bopomofo',
                  'San Gabriel, CA'
              ),
              _buildBusinessCard(
                  NetworkImage('https://s3-alpha-sig.figma.com/img/7e35/5b20/0755ed687ff758a80226caef118b68ae?Expires=1598832000&Signature=fZ3wymmSyfQVcX~BUnvzpN7MIJwIuQEWb45awqX5Yr40ZqKEuUIVRD~j1MQ8TRchiyrZk7fa-tTpQMjdAej3IczGnjh5mfM7yK6GWTRMXAvGowHir0PtgmgIwaoJbkaW0JpxQuzDnE~Fnsc7RbuoQ1OOy4gi7saOtJ5GyZsY79-Ur4p-kAMiuqhheoEBjTBppFgRGqHWqw67LENPNTVpccns8Iy3waZeZZwjJ8iyAoDRyyYh4NPyCdDAKWAqQ2bO4fiaJ9BBKT6etx5T9vE1D67pJ4DFRkYu~6aTsbdJFoIWc7v4RP7ZuyNtL8dYo7czBe4sudp5DtYwIPd-dG8NNg__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA'),
                  'Myungrang Hot Dogs',
                  'Rowland Heights, CA'
              ),
              _buildBusinessCard(
                  NetworkImage('https://s3-alpha-sig.figma.com/img/40d0/e0d9/4c53e0f02ee5a7baaace3514d7fc0278?Expires=1598832000&Signature=UMfAVugRv3BdUcAN0C18rhU-aoBsFYnhQeZJcPPDfPWSrRvPIqmPAx3h4Y6OTIoFPwrPYPnNHqKdci4aKeo-gDBMwgb3Unj0n3JOukLmotpy9QiZcJ7YrfIavj-BObswnmsnuInzCWyKde2NgGEltK~MawbbaAp5dVIYZiqu1T7YZx1FIf2sFWAbCkmgCkBYYEoZWyQO85JKYDAoZ4tQ2hNr-8HT~4kzarv~PaUdPlXsEqb1WH0TiS8NGrDDBHsy1L4BY~0ecKz84anF-hx8QwDXk0ax04FbSoLwhNRuL06NvCZamt93HquMnyknXEEa5DVflZbargg2Ms9TfaxJQA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA'),
                  'Hotties Fried Chicken',
                  'Chino, CA'
              ),
              _buildBusinessCard(
                  NetworkImage('https://s3-alpha-sig.figma.com/img/f01a/5001/99dc80250b77326c8c83740bec65261a?Expires=1598832000&Signature=FSIebYqiZurd2zCmGQObaZ75ObIf7kwOi9Y4-v1nDdpEWvZ-WCgjK-4SQKUvZGLvaVlcEJnbqXJArn4-3mxNciCdjSh~R8agdAm7GvIWCdtaJAvM1cVu~pyhmboMm9Q1rUheleKV9wIgSPLAtVxVHatUgHP6SFLXNBnzGbeADChzCZjNv0E~ffneSVxYeUoy9sFEw78Klb6jv-nGGFFFeaOYxn3LEBmzgQzlyA-T6NOwPw4W2gebeXNAZ84ZOyx9PCHFJHLyvl7MZXWp9~f49gBpZvT~-yKgnmD9kq4IorFypt5EyYEeA1t~9EZR~BGMiTwgA3-DcEg5ILu8JA4AHw__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA'),
                  'Bopomofo',
                  'San Gabriel, CA'
              ),
              _buildBusinessCard(
                  NetworkImage('https://s3-alpha-sig.figma.com/img/7e35/5b20/0755ed687ff758a80226caef118b68ae?Expires=1598832000&Signature=fZ3wymmSyfQVcX~BUnvzpN7MIJwIuQEWb45awqX5Yr40ZqKEuUIVRD~j1MQ8TRchiyrZk7fa-tTpQMjdAej3IczGnjh5mfM7yK6GWTRMXAvGowHir0PtgmgIwaoJbkaW0JpxQuzDnE~Fnsc7RbuoQ1OOy4gi7saOtJ5GyZsY79-Ur4p-kAMiuqhheoEBjTBppFgRGqHWqw67LENPNTVpccns8Iy3waZeZZwjJ8iyAoDRyyYh4NPyCdDAKWAqQ2bO4fiaJ9BBKT6etx5T9vE1D67pJ4DFRkYu~6aTsbdJFoIWc7v4RP7ZuyNtL8dYo7czBe4sudp5DtYwIPd-dG8NNg__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA'),
                  'Myungrang Hot Dogs',
                  'Rowland Heights, CA'
              ),
              _buildBusinessCard(
                  NetworkImage('https://s3-alpha-sig.figma.com/img/40d0/e0d9/4c53e0f02ee5a7baaace3514d7fc0278?Expires=1598832000&Signature=UMfAVugRv3BdUcAN0C18rhU-aoBsFYnhQeZJcPPDfPWSrRvPIqmPAx3h4Y6OTIoFPwrPYPnNHqKdci4aKeo-gDBMwgb3Unj0n3JOukLmotpy9QiZcJ7YrfIavj-BObswnmsnuInzCWyKde2NgGEltK~MawbbaAp5dVIYZiqu1T7YZx1FIf2sFWAbCkmgCkBYYEoZWyQO85JKYDAoZ4tQ2hNr-8HT~4kzarv~PaUdPlXsEqb1WH0TiS8NGrDDBHsy1L4BY~0ecKz84anF-hx8QwDXk0ax04FbSoLwhNRuL06NvCZamt93HquMnyknXEEa5DVflZbargg2Ms9TfaxJQA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA'),
                  'Hotties Fried Chicken',
                  'Chino, CA'
              ),
            ],
          )
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 80.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 50),
                        _buildActivityIcon(restaurantsIcon, 'Restaurants'),
                        _buildActivityIcon(barsAndClubsIcon, 'Bars & Clubs'),
                        _buildActivityIcon(amusementIcon, 'Amusement'),
                        SizedBox(width: 50),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 50),
                        _buildActivityIcon(photoshootsIcon, 'Photoshoots'),
                        _buildActivityIcon(natureIcon, 'Nature'),
                        _buildActivityIcon(moreIcon, 'More'),
                        SizedBox(width: 50),
                      ],
                    ),
                      ..._buildRecommendationList('For You'),
                      ..._buildRecommendationList('Recommended Tea Places'),
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.0),
                      )
                    ],
                ),
              ),
            ),
            _buildSearchBar(),
          ],
        ),
      )
    );
  }

}
  

