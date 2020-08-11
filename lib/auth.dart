import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static Map<String, dynamic> userRecord;

  Stream<FirebaseUser> get user {
    return firebaseAuth.onAuthStateChanged;
  }

  static Future<FirebaseUser> signInEmail(String email, String password) async {
    try {
      AuthResult result = await Auth.firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
