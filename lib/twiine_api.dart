import 'dart:collection';
import 'package:twiine/auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TwiineApi {
  static HttpsCallable _createNewUser =
      CloudFunctions.instance.getHttpsCallable(functionName: 'createNewUser');
  static HttpsCallable _userExists =
      CloudFunctions.instance.getHttpsCallable(functionName: 'getUser');

  static Future<LinkedHashMap> getUser(
      String authType, String authField) async {
    return (await TwiineApi._userExists.call(
      <dynamic, dynamic>{
        "collection": "Users",
        "authType": authType,
        "authField": authField,
      },
    ))
        .data['found'];
  }

  static Future<void> createNewUser({
    Map<String, dynamic> data,
    String firstname = "",
    String lastname = "",
    String birthday = "",
    String email = "",
    String phone = "",
  }) async {
    if (data == null) data = {};

    if(data["firstname"] == null || data["firstname"] == "")
      data["firstname"] = firstname;
    if(data["lastname"] == null || data["lastname"] == "")
      data["lastname"] = lastname;
    if(data["birthday"] == null || data["birthday"] == "")
      data["birthday"] = birthday;
    if(data["email"] == null || data["email"] == "")
      data["email"] = email;
    if(data["phone"] == null || data["phone"] == "")
      data["phone"] = phone;

    if (firstname != "") data["firstname"] = firstname;
    if (lastname != "") data["lastname"] = lastname;
    if (birthday != "") data["birthday"] = birthday;
    if (email != "") data["email"] = email;
    if (phone != "") data["phone"] = phone;
    //default picture url
    data["pictureUrl"] = "gs://twiine.appspot.com/ProfilePictures/default_profile.png";

    return FirebaseFirestore.instance
        .collection("Users")
        .doc(Auth.firebaseAuth.currentUser.uid)
        .set(data)
        .then((_) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(Auth.firebaseAuth.currentUser.uid)
          .update({
        "events": FieldValue.arrayUnion([]),
        "saved": {},
        "requests": FieldValue.arrayUnion([]),
      });
    });
  }

  static Future<DocumentSnapshot> getUserData(String uid) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(Auth.firebaseAuth.currentUser.uid)
        .get();
  }

  static Future<DocumentSnapshot> getDocument(String collection, String document) async {
    return await FirebaseFirestore.instance
        .collection(collection)
        .doc(document)
        .get();
  }
}
