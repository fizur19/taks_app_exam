import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:taks_app/app.dart';
import 'package:taks_app/presetetion/data/controlers/auth_controlers.dart';
import 'package:taks_app/presetetion/data/models/responsobject.dart';
import 'package:taks_app/presetetion/screen/auth/sign_in_screen.dart';

class NetworkCaller {
  static Future<ResponsObject> getRequist(url) async {
    try {
      final Response response = await get(Uri.parse(url), headers: {
        'token': AuthControler.acssestoken ?? '',
      });
      if (response.statusCode == 200) {
        final jsondecode = jsonDecode(response.body);
        return ResponsObject(
          statuscode: 200,
          responsbody: jsondecode,
          issucsees: true,
        );
      } else if (response.statusCode == 401) {
        _movetosinginscree();
        final jsondecode = jsonDecode(response.body);
        return ResponsObject(
          statuscode: 401,
          responsbody: jsondecode,
          issucsees: true,
        );
      } else {
        return ResponsObject(
          statuscode: response.statusCode,
          responsbody: '',
          issucsees: false,
        );
      }
    } catch (e) {
      return ResponsObject(
          statuscode: -1,
          responsbody: e.toString(),
          issucsees: false,
          errormsg: e.toString());
    }
  }

  static Future<ResponsObject> postRequist(
      String url, Map<String, dynamic> body,
      {bool fromSignIn = false}) async {
    try {
      final Response response =
          await post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'token': AuthControler.acssestoken ?? '',
      });
      log(response.statusCode).toString();
      print(response.body.toString());
      if (response.statusCode == 200) {
        final jsondecode = jsonDecode(response.body);
        return ResponsObject(
          statuscode: 200,
          responsbody: jsondecode,
          issucsees: true,
        );
      } else if (response.statusCode == 401) {
        if (fromSignIn) {
          return ResponsObject(
              statuscode: response.statusCode,
              responsbody: '',
              issucsees: false,
              errormsg: 'unauthorize');
        } else {
          _movetosinginscree();
          return ResponsObject(
            statuscode: response.statusCode,
            responsbody: '',
            issucsees: false,
          );
        }
      } else {
        return ResponsObject(
          statuscode: response.statusCode,
          responsbody: '',
          issucsees: false,
        );
      }
    } catch (e) {
      return ResponsObject(
          statuscode: -1,
          responsbody: e.toString(),
          issucsees: false,
          errormsg: e.toString());
    }
  }

  static void _movetosinginscree() async {
    await AuthControler.cler();
    Navigator.pushAndRemoveUntil(
        TaksApp.navigatorkey.currentState!.context,
        MaterialPageRoute(
          builder: (context) => sign_in_screen(),
        ),
        (route) => false);
  }
}
