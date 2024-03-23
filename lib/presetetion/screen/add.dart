import 'dart:math';

import 'package:flutter/material.dart';
import 'package:taks_app/presetetion/data/servises/networkcaller.dart';
import 'package:taks_app/presetetion/data/utils/urls.dart';
import 'package:taks_app/presetetion/screen/profileappbar.dart';
import 'package:taks_app/presetetion/widget/bacround_widget.dart';
import 'package:taks_app/presetetion/widget/snakbar.dart';

class add extends StatefulWidget {
  const add({super.key});

  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  TextEditingController titel = TextEditingController();
  TextEditingController descrteption = TextEditingController();

  GlobalKey<FormState> _from = GlobalKey<FormState>();

  bool addprogess = false;
  bool refresh = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, refresh);
        return false;
      },
      child: Scaffold(
        appBar: appbar(context),
        body: backroundwidget(
            child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _from,
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Text('add new taks',
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: titel,
                  validator: (value) {
                    validator:
                    (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    };
                  },
                  decoration: const InputDecoration(
                    hintText: 'titel',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: 6,
                  controller: descrteption,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'descreption',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: addprogess == false,
                    replacement: Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_from.currentState!.validate()) {
                          addtaks();
                        }
                      },
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Future<void> addtaks() async {
    addprogess = true;
    setState(() {});
    Map<String, dynamic> inputparams = {
      "title": titel.text.trim(),
      "description": descrteption.text.trim(),
      "status": "New"
    };
    final respons =
        await NetworkCaller.postRequist(Urls.createTask, inputparams);
    addprogess = false;
    setState(() {});

    if (respons.issucsees) {
      refresh = true;
      titel.clear();
      descrteption.clear();
      if (mounted) {
        sncakbarmameg(context, 'taks add');
      }
    } else {
      if (mounted) {
        sncakbarmameg(context, respons.errormsg ?? 'taks add faild', true);
      }
    }
  }
}
