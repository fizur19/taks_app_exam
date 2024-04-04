import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taks_app/presetetion/data/controlers/add_controllers.dart';
import 'package:taks_app/presetetion/data/servises/networkcaller.dart';
import 'package:taks_app/presetetion/data/utils/urls.dart';
import 'package:taks_app/presetetion/screen/profileappbar.dart';
import 'package:taks_app/presetetion/widget/bacround_widget.dart';
import 'package:taks_app/presetetion/widget/snakbar.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController titel = TextEditingController();
  TextEditingController descrteption = TextEditingController();

  GlobalKey<FormState> _from = GlobalKey<FormState>();
  AddControler _addControler = Get.find<AddControler>();

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                    child: GetBuilder<AddControler>(
                        init: _addControler,
                        builder: (controler) {
                          return Visibility(
                            visible: controler.inProgress == false,
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
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  Future<void> addtaks() async {
    final result = await _addControler.addtaks(titel.text, descrteption.text);

    if (result == true) {
      refresh = true;
      titel.clear();
      descrteption.clear();
      if (mounted) {
        sncakbarmameg(context, 'taks add');
      }
    } else {
      if (mounted) {
        sncakbarmameg(
            context, _addControler.errormsg ?? 'taks add faild', true);
      }
    }
  }
}
