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

    if (firstname != "") data["firstname"] = firstname;
    if (lastname != "") data["lastname"] = lastname;
    if (birthday != "") data["birthday"] = birthday;
    if (email != "") data["email"] = email;
    if (phone != "") data["phone"] = phone;
    data["pictureUrl"] = "";

    return FirebaseFirestore.instance
        .collection("Users")
        .doc(Auth.firebaseAuth.currentUser.uid)
        .set(data)
        .then((_) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(Auth.firebaseAuth.currentUser.uid)
          .update({
        "hangouts": FieldValue.arrayUnion([]),
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
}
