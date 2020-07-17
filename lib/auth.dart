import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseUser user;
}