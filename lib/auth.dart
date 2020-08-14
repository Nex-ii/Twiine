import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twiine/twiine_api.dart';

class Auth {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static Map<String, dynamic> userData;

  Stream<FirebaseUser> get user {
    return firebaseAuth.onAuthStateChanged;
  }

  static Future<FirebaseUser> signInEmail(String email, String password) async {
    try {
      AuthResult result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      updateUserData();
      return result.user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  static Future<FirebaseUser> signInFacebook() async {
    try {
      var result = await FacebookLogin().logIn(["email"]);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          var firebaseResult = await firebaseAuth.signInWithCredential(
            FacebookAuthProvider.getCredential(
              accessToken: result.accessToken.token,
            ),
          );
          var name = firebaseResult.user.displayName.split(' ');
          Firestore.instance.collection("Users").document(firebaseResult.user.uid).get().then((doc) {
            if (doc.data == null) {
              TwiineApi.createNewUser(
                  firstname: name[0],
                  lastname: name[name.length-1],
                  email: firebaseResult.user.email);
            }
            updateUserData();
          });
          return firebaseResult.user;
          break;
        default:
          return null;
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  static Future<FirebaseUser> signInGoogle() async {
    try {
      var result = await GoogleSignIn(scopes: ['email']).signIn();
      var auth = await result.authentication;
      var firebaseResult = await firebaseAuth.signInWithCredential(
        GoogleAuthProvider.getCredential(
          idToken: auth.idToken,
          accessToken: auth.idToken,
        ),
      );
      var name = firebaseResult.user.displayName.split(' ');
      Firestore.instance.collection("Users").document(firebaseResult.user.uid).get().then((doc) {
        if (doc.data == null) {
          TwiineApi.createNewUser(
              firstname: name[0],
              lastname: name[name.length-1],
              email: firebaseResult.user.email);
        }
        updateUserData();
      });
      return firebaseResult.user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  static void updateUserData() async {
    DocumentSnapshot userData =
        await TwiineApi.getUserData((await firebaseAuth.currentUser()).uid);
    Auth.userData = userData.data;
  }

  static void signOut() async {
    firebaseAuth.signOut();
  }
}
