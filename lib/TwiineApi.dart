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

  static Future<void> createNewUser(Map<String, String> data) async {
    return Firestore.instance
        .collection("Users")
        .document(Auth.user.uid)
        .setData(data);
  }
}
