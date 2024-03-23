import 'package:flutter/material.dart';
import 'package:taks_app/presetetion/data/servises/networkcaller.dart';
import 'package:taks_app/presetetion/data/utils/urls.dart';

import 'package:taks_app/presetetion/screen/auth/sign_in_screen.dart';

import 'package:taks_app/presetetion/widget/bacround_widget.dart';
import 'package:taks_app/presetetion/widget/snakbar.dart';

class setpassword extends StatefulWidget {
  setpassword({super.key, required this.email, required this.otp});
  String email;
  String otp;

  @override
  State<setpassword> createState() => _setpasswordState();
}

class _setpasswordState extends State<setpassword> {
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
                Text('set password',
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'minimum password leanth is 0',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailTEDcontroller,
                  decoration: const InputDecoration(
                    hintText: 'password',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailTEDcontroller,
                  decoration: const InputDecoration(
                    hintText: 'password',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        getapi();
                      },
                      child: Visibility(
                          visible: prosees == false,
                          replacement:
                              Center(child: CircularProgressIndicator()),
                          child: Text('conferm'))),
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
                      onPressed: () {},
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

  Future<void> getapi() async {
    prosees = true;
    setState(() {});
    Map<String, dynamic> inputparams = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _emailTEDcontroller.text
    };
    final respons =
        await NetworkCaller.postRequist(Urls.RecoverResetPass, inputparams);
    prosees = false;
    if (respons.issucsees) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => sign_in_screen(),
          ),
          (route) => false);
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
