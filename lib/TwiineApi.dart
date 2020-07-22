import 'dart:collection';
import 'package:cloud_functions/cloud_functions.dart';

class TwiineApi {
  static HttpsCallable _createNewUser = CloudFunctions.instance.getHttpsCallable(functionName: 'createNewUser');
  static HttpsCallable _userExists = CloudFunctions.instance.getHttpsCallable(functionName: 'getUser');

  static Future<LinkedHashMap> getUser(String authType, String authField) async {
    return (await TwiineApi._userExists.call(<dynamic, dynamic> {
      'authType': authType,
      'authField': authField
    })).data['found'];
  }
}