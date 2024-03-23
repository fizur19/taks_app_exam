import 'package:flutter/material.dart';
import 'package:taks_app/presetetion/data/controlers/auth_controlers.dart';
import 'package:taks_app/presetetion/data/servises/networkcaller.dart';
import 'package:taks_app/presetetion/data/utils/urls.dart';
import 'package:taks_app/presetetion/screen/auth/pin.dart';
import 'package:taks_app/presetetion/widget/bacround_widget.dart';
import 'package:taks_app/presetetion/widget/snakbar.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _emailTEDcontroller = TextEditingController();
  GlobalKey<FormState> _fromkey = GlobalKey<FormState>();
  bool prosees = false;
  @override
  void initState() {
    // TODO: implement initState
    _emailTEDcontroller.text = AuthControler.userdata?.email ?? '';
    super.initState();
  }

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
                Text('Your Email Adrees',
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
                TextFormField(
                  controller: _emailTEDcontroller,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      emailerecoverapi(_emailTEDcontroller.text);
                    },
                    child: Visibility(
                      visible: prosees == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                      ),
                    ),
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
                        Navigator.pop(context);
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

  Future<void> emailerecoverapi(email) async {
    prosees = true;
    setState(() {});
    final respons =
        await NetworkCaller.getRequist(Urls.RecoverVerifyEmail(email));
    prosees = false;
    if (respons.issucsees) {
      if (!mounted) {
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => pincode(
            email: email,
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
