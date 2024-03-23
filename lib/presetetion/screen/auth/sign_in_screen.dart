import 'package:flutter/material.dart';
import 'package:taks_app/presetetion/data/controlers/auth_controlers.dart';
import 'package:taks_app/presetetion/data/models/login_respons.dart';
import 'package:taks_app/presetetion/data/models/responsobject.dart';
import 'package:taks_app/presetetion/data/servises/networkcaller.dart';
import 'package:taks_app/presetetion/data/utils/urls.dart';
import 'package:taks_app/presetetion/screen/auth/email.dart';
import 'package:taks_app/presetetion/screen/main_screen.dart';
import 'package:taks_app/presetetion/screen/auth/sign_up_screen.dart';
import 'package:taks_app/presetetion/widget/bacround_widget.dart';
import 'package:taks_app/presetetion/widget/snakbar.dart';

class sign_in_screen extends StatefulWidget {
  const sign_in_screen({super.key});

  @override
  State<sign_in_screen> createState() => _sign_in_screenState();
}

class _sign_in_screenState extends State<sign_in_screen> {
  TextEditingController _emailTEDcontroller = TextEditingController();
  TextEditingController _passwordTEDcontroller = TextEditingController();
  GlobalKey<FormState> _fromkey = GlobalKey<FormState>();
  bool singinprocess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: backroundwidget(
        child: SingleChildScrollView(
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
                  Text('Get Started with',
                      style: Theme.of(context).textTheme.titleLarge),
                  TextFormField(
                    controller: _emailTEDcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordTEDcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: singinprocess == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_fromkey.currentState!.validate()) {
                            singin();
                          }
                        },
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPassword(),
                          ),
                        );
                      },
                      child: Text(
                        'Forget Password',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have a account ?',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Sing_Up_Screen(),
                              ));
                        },
                        child: Text(
                          'Sign up',
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
      ),
    );
  }

  Future<void> singin() async {
    singinprocess = true;
    setState(() {});
    Map<String, dynamic> inputparams = {
      "email": _emailTEDcontroller.text.trim(),
      "password": _passwordTEDcontroller.text
    };
    final ResponsObject respons = await NetworkCaller.postRequist(
        Urls.login, inputparams,
        fromSignIn: true);
    singinprocess = false;
    setState(() {});
    if (respons.issucsees) {
      if (!mounted) {
        return;
      }
      LoginRespons loginRespons = LoginRespons.fromJson(respons.responsbody);
      await AuthControler.saveUserdata(loginRespons.data!);
      await AuthControler.saveusertoken(loginRespons.token!);
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Main_screen(),
            ),
            (route) => false);
        sncakbarmameg(context, 'login ');
      }
    } else {
      if (mounted) {
        sncakbarmameg(context, respons.errormsg ?? 'login faild try again');
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTEDcontroller.dispose();
    _passwordTEDcontroller.dispose();
    super.dispose();
  }
}
