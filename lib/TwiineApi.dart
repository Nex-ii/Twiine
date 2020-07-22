import 'package:cloud_functions/cloud_functions.dart';

class TwiineApi {
  static HttpsCallable createNewUser = CloudFunctions.instance.getHttpsCallable(functionName: 'createNewUser');
  static HttpsCallable userExists = CloudFunctions.instance.getHttpsCallable(functionName: 'userExists');
}