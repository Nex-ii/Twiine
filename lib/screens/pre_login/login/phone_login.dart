import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:twiine/colors.dart';

class PhoneLogin extends StatefulWidget {
  PhoneLogin({Key key}) : super(key: key);

  @override
  PhoneLoginState createState() => PhoneLoginState();
}

class PhoneLoginState extends State<PhoneLogin> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          width: screenWidth * 0.9,
          child: InternationalPhoneNumberInput(
            countries: ['US'],
          ),
        ),
        SizedBox(height: 40),
        Text("[Terms and conditions statement]"),
        SizedBox(height: 40),
        _createSendCodeButton(() => {})
      ],
    );
  }

  Widget _createSendCodeButton(Function onTap) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Card(
        color: TwiineColors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: SizedBox(
          height: 55,
          width: screenWidth * 0.9,
          child: Container(
            child: InkWell(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Text(
                          "Continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  //   _loginWithPhone() {
  //     final PhoneVerificationCompleted verified = (AuthCredential credeitial) {
  //       Auth.firebaseAuth.signInWithCredential(credeitial).catchError((error) {
  //         updateLoginMessage("Failed to verified phone number");
  //       }).then((result) {
  //         updateLoginMessage("Successfully verified phone number");
  //         _successfulLogin(
  //             LoginMethods.phone, SigninStatus.phoneNumber, SigninStatus.SMScode);
  //       });
  //     };

  //     final PhoneVerificationFailed verificationfailed =
  //         (AuthException authException) {
  //       updateLoginMessage("Failed to verify phone number");
  //       SigninStatus.codeSent = false;
  //     };

  //     final PhoneCodeSent smsSent = (String verId, [int forceResend])         Auth.user = result.user;
  //         _successfulLogin(
  //             LoginMethods.phone, SigninStatus.phoneNumber, SigninStatus.SMScode);
  //       });
  //     };

  //     final PhoneVerificationFailed verificationfailed =
  //         (AuthException authException) {
  //       updateLoginMessage("Failed to verify phone number");
  //       SigninStatus.codeSent = false;
  //     };

  //     final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
  //       setState(() {
  //         SigninStatus.verificationId = verId;
  //         SigninStatus.codeSent = true;
  //       });
  //     };

  //     final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
  //       SigninStatus.verificationId = verId;
  //       SigninStatus.codeSent = false;
  //     };

  //     if (SigninStatus.isPhoneLogin) {
  //       if (SigninStatus.codeSent) {
  //         Auth.firebaseAuth
  //             .signInWithCredential(PhoneAuthProvider.getCredential(
  //                 verificationId: SigninStatus.verificationId,
  //                 smsCode: SigninStatus.SMScode))
  //             .catchError((error) {
  //           updateLoginMessage("Failed to verify phone number");
  //         }).then((result) {
  //           if (result != null) {
  //             updateLoginMessage("Successfully verified phone number");
  //             _successfulLogin(LoginMethods.phone, SigninStatus.phoneNumber,
  //                 SigninStatus.SMScode);
  //             Auth.user = result.user;
  //           }
  //         });
  //       } else {
  //         Auth.firebaseAuth.verifyPhoneNumber(
  //             phoneNumber: SigninStatus.phoneNumber,
  //             timeout: const Duration(seconds: 60),
  //             verificationCompleted: verified,
  //             verificationFailed: verificationfailed,
  //             codeSent: smsSent,
  //             codeAutoRetrievalTimeout: autoTimeout);
  //       }
  //     } else {
  //       setState(() {
  //         SigninStatus.isPhoneLogin = true;
  //       });
  //     }
  //   }
}
