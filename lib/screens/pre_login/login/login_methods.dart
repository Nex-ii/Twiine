enum LoginMethods{
  phone,
  facebook,
  google,
  email,

}

extension LoginMethodsUtils on LoginMethods{
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
}