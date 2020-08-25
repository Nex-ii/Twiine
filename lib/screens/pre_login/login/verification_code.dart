import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:twiine/auth.dart';
import 'package:twiine/common/text_form.dart';
import 'package:twiine/twiine_api.dart';

class VerificationCode extends StatefulWidget {
  VerificationCode({Key key, @required this.phone}) : super(key: key);
  final String phone;

  @override
  VerificationCodeState createState() => VerificationCodeState(phone);
}

class VerificationCodeState extends State<VerificationCode> {
  String _phone;
  String verificationID;
  TextEditingController smsCodeController = TextEditingController();

  VerificationCodeState(String phone) {
    _phone = phone;
  }

  @override
  void initState() {
    super.initState();
    _sendSMSCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextForm.backBar(context),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  "Enter 6-digit code",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  "Your code was sent to $_phone",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 30),
                PinCodeTextField(
                  length: 6,
                  appContext: context,
                  obsecureText: false,
                  onChanged: (str) {},
                  animationType: AnimationType.fade,
                  backgroundColor: Colors.transparent,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeColor: Colors.green,
                    selectedColor: Colors.blue,
                    inactiveColor: Colors.black,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  autoDismissKeyboard: true,
                  controller: smsCodeController,
                  onCompleted: _signInWithSMSCode,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive a text?",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        _sendSMSCode();
                        TextForm.popUp(context,
                            "A new code has been sent. It will time out in 60 seconds");
                      },
                      child: Text(
                        "Send Again",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _sendSMSCode() {
    final PhoneVerificationCompleted verified = (AuthCredential credeitial) {
      FirebaseAuth.instance
          .signInWithCredential(credeitial)
          .catchError((error) {
        TextForm.popUp(context, "Failed to verify phone number");
      }).then((result) {
        Navigator.of(context).pushNamed('/navbar');
      });
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      TextForm.popUp(context, "Failed to verify phone number");
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      verificationID = verId;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      verificationID = verId;
    };

    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  _signInWithSMSCode(String smsCode) {
    FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: verificationID, smsCode: smsCodeController.text))
        .catchError((error) {
      TextForm.popUp(context,
          "The code you have entered is incorrect. Please re-enter the code.");
    }).then((result) {
      if (result != null) {
        Navigator.of(context).pushNamed('/signup');
        FirebaseFirestore.instance
            .collection("Users")
            .doc(result.user.uid)
            .get()
            .then((doc) {
          if (doc.data == null) {
            TwiineApi.createNewUser(phone: result.user.phoneNumber);
          }
        });
        Auth.updateUserData();
      }
    });
  }
}
