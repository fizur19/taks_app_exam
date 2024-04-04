import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taks_app/presetetion/data/controlers/add_controllers.dart';
import 'package:taks_app/presetetion/data/controlers/newtaks.dart';
import 'package:taks_app/presetetion/data/controlers/sign_in_controler.dart';
import 'package:taks_app/presetetion/data/controlers/sign_up_controler.dart';
import 'package:taks_app/presetetion/data/controlers/taks_by_status_count.dart';
import 'package:taks_app/presetetion/screen/splash_screen.dart';

class TaksApp extends StatefulWidget {
  const TaksApp({super.key});
  static GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();
  @override
  State<TaksApp> createState() => _TaksAppState();
}

class _TaksAppState extends State<TaksApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaksApp.navigatorkey,
      theme: _themeData,
      home: SplashScreen(),
      initialBinding: ControllerBinder(),
    );
  }

  ThemeData _themeData = ThemeData(
      useMaterial3: true,
      textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 6,
        ),
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
      ),
      chipTheme: ChipThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))));
}

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInControler(), fenix: true);
    Get.put(SignUpControler());
    Get.put(TaksBystauscountcontroler());
    Get.put(NewtaksControlers());
    Get.put(AddControler());
    // TODO: implement dependencies
  }
}
