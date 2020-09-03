import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twiine/screens/twiine_user.dart';
import 'package:twiine/twiine_api.dart';

class Auth {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static TwiineUser currentUser;

  Stream<User> get user {
    return firebaseAuth.authStateChanges();
  }

  static Future<User> signInEmail(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await updateUserData();
      return result.user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  static Future<User> signInFacebook() async {
    try {
      var result = await FacebookLogin().logIn(["email"]);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          var firebaseResult = await firebaseAuth.signInWithCredential(
            FacebookAuthProvider.credential(result.accessToken.token),
          );
          var name = firebaseResult.user.displayName.split(' ');
          DocumentSnapshot doc = await FirebaseFirestore.instance
              .collection("Users")
              .doc(firebaseResult.user.uid)
              .get();
          if (doc.data == null) {
            await TwiineApi.createNewUser(
              firstname: name[0],
              lastname: name[name.length - 1],
              email: firebaseResult.user.email,
            );
          }
          await updateUserData();
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

  static Future<User> signInGoogle() async {
    try {
      var result = await GoogleSignIn(scopes: ['email']).signIn();
      var auth = await result.authentication;
      var firebaseResult = await firebaseAuth.signInWithCredential(
        GoogleAuthProvider.credential(
          idToken: auth.idToken,
          accessToken: auth.idToken,
        ),
      );
      var name = firebaseResult.user.displayName.split(' ');
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(firebaseResult.user.uid)
          .get();
      if (doc.data == null) {
        await TwiineApi.createNewUser(
          firstname: name[0],
          lastname: name[name.length - 1],
          email: firebaseResult.user.email,
        );
      }
      await updateUserData();
      return firebaseResult.user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  static Future updateUserData() async {
    DocumentSnapshot userData =
        await TwiineApi.getUserData(firebaseAuth.currentUser.uid);
    Image profilePicture = (userData.data().containsKey("pictureUrl") &&
            userData.data()["pictureUrl"] != "")
        ? Image.network(userData.data()["pictureUrl"])
        : Image.asset("assets/default_profile.png");
    currentUser = TwiineUser(
      data: userData.data(),
      profilePicture: profilePicture,
    );
  }

  static void signOut() async {
    firebaseAuth.signOut();
  }
}
