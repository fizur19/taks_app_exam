import 'package:flutter/material.dart';

sncakbarmameg(BuildContext context, msg, [bool iserormsg = false]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg.toString()),
    backgroundColor: iserormsg ? Colors.red : null,
  ));
}
