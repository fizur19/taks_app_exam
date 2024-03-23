import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taks_app/presetetion/data/controlers/auth_controlers.dart';
import 'package:taks_app/presetetion/screen/auth/sign_in_screen.dart';
import 'package:taks_app/presetetion/screen/main_screen.dart';
import 'package:taks_app/presetetion/util/imagephath.dart';
import 'package:taks_app/presetetion/widget/bacround_widget.dart';
import 'package:taks_app/presetetion/widget/snakbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  gotosigninscreen() async {
    await Future.delayed(
      Duration(seconds: 3),
    );

    bool isloginstate = await AuthControler.islogin();
    if (isloginstate) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Main_screen(),
          ),
          (route) => false);
      sncakbarmameg(context, 'login ');
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => sign_in_screen(),
          ));
    }
  }

  @override
  void initState() {
    super.initState();

    gotosigninscreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: backroundwidget(
        child: Center(
          child: SvgPicture.asset(imagepath.applogo),
        ),
      ),
    );
  }
}
