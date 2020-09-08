import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:twiine/main.dart';

// get search bar for 7 leaves working
// possibly make search bar a common widget

class GMap extends StatefulWidget {
  GMap({Key key}) : super(key:key);

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
 Set<Marker> _markers = HashSet<Marker>();
 GoogleMapController _mapController;
 LatLng currentLocation;
 String searchAddr;

 String _businessName;
 String _address = "d";



 void _getEventData() async {
//   Map<String, dynamic> eventData = (await FirebaseFirestore.instance
//       .collection("Businesses_Debug")
//       .doc("7-leaves-cafe-alhambra-2")
//       .get())
//       .data();


//   Map<String, dynamic> eventData;
//   FirebaseFirestore.instance
//       .collection("Businesses_Debug")
//       .where('name', isEqualTo: searchAddr)
//       .get()
//       .then((event) {
//         if(event.docs.isNotEmpty) {
//           eventData = event.docs.single.data();
//         }
//   }).catchError((e) => print("error fetching data: $e"));
//   setState(() {
//     _address = "${eventData["address"][0]}, ${eventData["address"][1]}";
//   });
//   Geolocator().placemarkFromAddress(_address).then((result){
//     currentLocation = LatLng(result[0].position.latitude, result[0].position.longitude);
//     _markers.clear();
//     _markers.add(
//         Marker(
//           markerId: MarkerId(currentLocation.toString(),),
//           position: currentLocation,
//         )
//     );
//     _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//     target: currentLocation,
//     zoom: 20.0,
//     )));
//   });

 }

 void _onMapCreated(GoogleMapController controller) {
   setState(() {
     _mapController = controller;
   });
 }

 searchAndNavigate() {
//     _getEventData();

   Geolocator().placemarkFromAddress(searchAddr).then((result) {
     currentLocation =
         LatLng(result[0].position.latitude, result[0].position.longitude);
     _markers.clear();
     _markers.add(
         Marker(
           markerId: MarkerId(currentLocation.toString(),),
           position: currentLocation,
         )
     );
     _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
       target: currentLocation,
       zoom: 12.0,
     )));
   });
 }


  @override
  Widget build(BuildContext) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng (37.77483, -122.41942),
                zoom: 12,
              ),
              markers: Set.from(_markers),
          ),
          Positioned(
            top: 30.0,
            right: 15.0,
            left: 15.0,
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Address',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      searchAndNavigate();
                    },
                    iconSize: 30.0,
                  )
                ),
                onChanged: (val) {
                  setState(() {
                    searchAddr = val;
                  });
                },
              ),
            ),
          ),
        ]
      ),
    );
  }
}