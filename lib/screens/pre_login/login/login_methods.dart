import 'package:shared_preferences/shared_preferences.dart';

enum LoginMethods{
  phone,
  facebook,
  google,
  email,

}

class LoginMethodsUtils{
  static LoginMethods stringToEnum(String str){
    switch(str){
      case "phone":
        return LoginMethods.phone;
        break;
      case "facebook":
        return LoginMethods.facebook;
        break;
      case "google":
        return LoginMethods.google;
        break;
      case "email":
        return LoginMethods.email;
        break;
    }
  }

  static SharedPreferences prefs;
  static bool init = false;

  static bool hasLoggedIn(){
    SharedPreferences.getInstance().then((prefs) => prefs.getBool("hasLoggedIn"));
  }

  static String loginMethod(){
    SharedPreferences.getInstance().then((prefs) => prefs.getString("loginMethod"));
  }

  static String username(){
    SharedPreferences.getInstance().then((prefs) => prefs.getString("username"));
  }

  static String password(){
    SharedPreferences.getInstance().then((prefs) => prefs.getString("password"));
}

  static void setPreferences({bool hasLoggedIn, String loginMehtod, String username, String password}){
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("hasLoggedIn", hasLoggedIn);
      prefs.setString("loginMethod", loginMehtod);
      prefs.setString("username", username);
      prefs.setString("password", password);
    });

  }

}