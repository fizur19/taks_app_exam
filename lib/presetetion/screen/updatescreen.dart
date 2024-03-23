import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taks_app/presetetion/data/controlers/auth_controlers.dart';
import 'package:taks_app/presetetion/data/models/userdata.dart';
import 'package:taks_app/presetetion/data/servises/networkcaller.dart';
import 'package:taks_app/presetetion/data/utils/urls.dart';
import 'package:taks_app/presetetion/screen/profileappbar.dart';
import 'package:taks_app/presetetion/widget/bacround_widget.dart';
import 'package:taks_app/presetetion/widget/snakbar.dart';

class Updatescreen extends StatefulWidget {
  const Updatescreen({super.key});

  @override
  State<Updatescreen> createState() => _UpdatescreenState();
}

class _UpdatescreenState extends State<Updatescreen> {
  var email = TextEditingController();
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var mobile = TextEditingController();

  var password = TextEditingController();
  XFile? image;

  bool Updatebool = false;

  @override
  void initState() {
    // TODO: implement initState
    email.text = AuthControler.userdata?.email ?? '';
    firstname.text = AuthControler.userdata?.firstName ?? '';
    lastname.text = AuthControler.userdata?.lastName ?? '';
    mobile.text = AuthControler.userdata?.mobile ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, isupdatescreen: true),
      body: backroundwidget(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'Update profile',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  imagepick();
                },
                child: Row(children: [
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.all(20),
                    child: Text('photo'),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      image?.name ?? '',
                      maxLines: 1,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  )
                ]),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                hintText: 'email',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: firstname,
              decoration: const InputDecoration(
                hintText: 'first name',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: lastname,
              decoration: const InputDecoration(
                hintText: 'last name',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: mobile,
              decoration: const InputDecoration(
                hintText: 'mobile',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: password,
              decoration: const InputDecoration(
                hintText: 'password',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Visibility(
                visible: Updatebool == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: ElevatedButton(
                  onPressed: () async {
                    await Updateapi();
                  },
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void imagepick() async {
    ImagePicker imagePicker = ImagePicker();
    image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  Future<void> Updateapi() async {
    String? photo;

    Updatebool = true;
    setState(() {});
    Map<String, dynamic> inputparams = {
      "email": email.text,
      "firstName": firstname.text,
      "lastName": lastname.text,
      "mobile": mobile.text,
    };
    if (password.text.isNotEmpty) {
      inputparams['password'] = password.text;
    }
    if (image != null) {
      List<int> byts = await File(image!.path).readAsBytesSync();
      photo = base64Encode(byts);
      inputparams['photo'] = photo;
    }

    // ignore: unused_local_variable
    final respons =
        await NetworkCaller.postRequist(Urls.profileUpdate, inputparams);
    Updatebool = false;

    if (respons.issucsees) {
      if (true) {
        Userdata userdata = Userdata(
            email: email.text,
            firstName: firstname.text,
            lastName: lastname.text,
            mobile: mobile.text,
            photo: photo);
        await AuthControler.saveUserdata(userdata);
        setState(() {});
      }
    } else {
      if (!mounted) {
        return;
      }
      setState(() {});
      sncakbarmameg(context, 'update try');
    }
  }
}
