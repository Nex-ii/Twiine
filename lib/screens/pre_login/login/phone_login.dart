import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:twiine/colors.dart';
import 'package:twiine/screens/pre_login/login/verification_code.dart';

class PhoneLogin extends StatefulWidget {
  PhoneLogin({Key key}) : super(key: key);

  @override
  PhoneLoginState createState() => PhoneLoginState();
}

class PhoneLoginState extends State<PhoneLogin> {

  @override
  Widget build(BuildContext context) {
    String phone;
    bool valid = false;
    return Column(
      children: [
        SizedBox(
          child: InternationalPhoneNumberInput(
            countries: ['US'],
            initialValue: PhoneNumber(),
            autoValidate: true,
            onInputValidated: (bool) {
              valid = bool;
            },
            onInputChanged: (number){
              phone = number.phoneNumber;
            },
          ),
        ),
        SizedBox(height: 40),
        Text(
          "[Terms and conditions statement]",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(height: 40),
        _createSendCodeButton(() {
          if (valid)
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      VerificationCode(phone: phone)),
            );
        })
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
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }
}
