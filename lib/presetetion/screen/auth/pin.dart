import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taks_app/presetetion/data/servises/networkcaller.dart';
import 'package:taks_app/presetetion/data/utils/urls.dart';
import 'package:taks_app/presetetion/screen/auth/setpassword.dart';
import 'package:taks_app/presetetion/screen/auth/sign_in_screen.dart';

import 'package:taks_app/presetetion/widget/bacround_widget.dart';
import 'package:taks_app/presetetion/widget/snakbar.dart';

class pincode extends StatefulWidget {
  pincode({super.key, required this.email});
  String email;

  @override
  State<pincode> createState() => _pincodeState();
}

class _pincodeState extends State<pincode> {
  TextEditingController _emailTEDcontroller = TextEditingController();
  GlobalKey<FormState> _fromkey = GlobalKey<FormState>();
  bool prosees = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: backroundwidget(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _fromkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text('pin verification code',
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'A 6 digit verification pin will send to your email address ',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    _emailTEDcontroller.text = value;
                    print(value);
                    setState(() {});
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: prosees == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                        onPressed: () {
                          emailerecoverapi(
                              widget.email, _emailTEDcontroller.text);
                        },
                        child: Text('verifi')),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'have a account ?',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => sign_in_screen(),
                            ));
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> emailerecoverapi(String email, String otp) async {
    prosees = true;
    setState(() {});
    final respons =
        await NetworkCaller.getRequist(Urls.RecoverVerifyOTP(email, otp));
    prosees = false;
    if (respons.issucsees) {
      if (!mounted) {
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => setpassword(
            email: email,
            otp: otp,
          ),
        ),
      );
    } else {
      setState(() {});
      if (mounted) {
        sncakbarmameg(context, respons.errormsg.toString());
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTEDcontroller.dispose();

    super.dispose();
  }
}
