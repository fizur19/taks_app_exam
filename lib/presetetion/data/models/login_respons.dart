import 'package:taks_app/presetetion/data/models/userdata.dart';

class LoginRespons {
  String? status;
  String? token;
  Userdata? data;

  LoginRespons({this.status, this.token, this.data});

  LoginRespons.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    data = json['data'] == null ? null : new Userdata.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
