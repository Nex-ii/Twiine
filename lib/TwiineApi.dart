import 'dart:collection';

import 'package:cloud_functions/cloud_functions.dart';

class TwiineApi {
  static HttpsCallable _createNewUser = CloudFunctions.instance.getHttpsCallable(functionName: 'createNewUser');
  // TODO: change this function name in the backend
  static HttpsCallable _userExists = CloudFunctions.instance.getHttpsCallable(functionName: 'userExists');

  static Future<LinkedHashMap> getUser(String authType, String data) async {
    return (await TwiineApi._userExists.call(<dynamic, dynamic> {
      'left_data_field': authType,
      'right_userdata': data
    })).data['found'];
  }
}