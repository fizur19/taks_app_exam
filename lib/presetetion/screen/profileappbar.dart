import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taks_app/app.dart';
import 'package:taks_app/presetetion/data/controlers/auth_controlers.dart';
import 'package:taks_app/presetetion/screen/auth/sign_in_screen.dart';
import 'package:taks_app/presetetion/screen/updatescreen.dart';

PreferredSizeWidget appbar(BuildContext context,
    {bool isupdatescreen = false}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.green,
    title: GestureDetector(
      onTap: () {
        if (isupdatescreen) {
          return;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Updatescreen(),
            ));
      },
      child: Row(children: [
        CircleAvatar(
          backgroundImage: (AuthControler.userdata?.photo ?? null) != null
              ? MemoryImage(base64Decode(AuthControler.userdata!.photo!
                  .split('data:image/png;base64,')
                  .last))
              : null,
        ),
        //  backgroundImage: MemoryImage(base64Decode(AuthControler
        //       .userdata!.photo!
        //       .split('data:image/png;base64,')
        //       .first)),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AuthControler.userdata?.fullname ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                AuthControler.userdata?.email ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              AuthControler.cler();
              Navigator.pushAndRemoveUntil(
                  TaksApp.navigatorkey.currentState!.context,
                  MaterialPageRoute(
                    builder: (context) => sign_in_screen(),
                  ),
                  (route) => false);
            },
            icon: Icon(Icons.logout))
      ]),
    ),
  );
}
