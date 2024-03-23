import 'package:flutter/material.dart';
import 'package:taks_app/presetetion/data/models/responsobject.dart';
import 'package:taks_app/presetetion/data/servises/networkcaller.dart';
import 'package:taks_app/presetetion/data/utils/urls.dart';
import 'package:taks_app/presetetion/util/appcolor.dart';
import 'package:taks_app/presetetion/widget/bacround_widget.dart';
import 'package:taks_app/presetetion/widget/snakbar.dart';

class Sing_Up_Screen extends StatefulWidget {
  Sing_Up_Screen({super.key});

  @override
  State<Sing_Up_Screen> createState() => _Sing_Up_ScreenState();
}

class _Sing_Up_ScreenState extends State<Sing_Up_Screen> {
  TextEditingController _email = TextEditingController();

  TextEditingController _firstname = TextEditingController();

  TextEditingController _lastname = TextEditingController();

  TextEditingController _mobile = TextEditingController();

  TextEditingController _password = TextEditingController();

  GlobalKey<FormState> _fromkey = GlobalKey<FormState>();

  bool registrationprogess = false;

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
              children: [
                SizedBox(
                  height: 60,
                ),
                Text(
                  'Join With Us',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _email,
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
                  controller: _firstname,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'FIrst Name',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _lastname,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _mobile,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Mobile',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _password,
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
                  height: 20,
                ),
                Visibility(
                  visible: registrationprogess == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => _singup(context),
                        child: Icon(Icons.arrow_circle_right_outlined)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have a account ?',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Sing in',
                          style: TextStyle(
                              fontSize: 16, color: AppColor.themcolor),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> _singup(context) async {
    if (_fromkey.currentState!.validate()) {
      registrationprogess = true;
      setState(() {});

      Map<String, dynamic> inputparams = {
        "email": _email.text.trim(),
        "firstName": _firstname.text.trim(),
        "lastName": _lastname.text.trim(),
        "mobile": _mobile.text.trim(),
        "password": _password.text,
      };
      final ResponsObject respons =
          await NetworkCaller.postRequist(Urls.registration, inputparams);
      registrationprogess = false;
      setState(() {});
      if (respons.issucsees) {
        sncakbarmameg(context, 'registretion is complete');
        Navigator.pop(context);
      } else {
        sncakbarmameg(context, ' registretion is falild');
      }
    }
  }
}
