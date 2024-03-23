import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taks_app/presetetion/data/models/userdata.dart';

class AuthControler {
  static String? acssestoken;
  static Userdata? userdata;

  static Future<void> saveUserdata(Userdata userdata) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        'usersavedata', jsonEncode(userdata.toJson()));
    AuthControler.userdata = userdata;
  }

  static Future<Userdata?> getUserdata() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? result = sharedPreferences.getString('usersavedata');
    if (result == null) {
      return null;
    }
    final user = Userdata.fromJson(jsonDecode(result));
    AuthControler.userdata = user;
    return user;
  }

  static Future<void> saveusertoken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString('token', token);
    acssestoken = token;
  }

  static Future<String?> getusertoken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  static Future<bool> islogin() async {
    final result = await getusertoken();
    acssestoken = result;
    bool loginstate = result != null;
    if (loginstate) {
      await getUserdata();
    }

    return loginstate;
  }

  static Future<void> cler() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
