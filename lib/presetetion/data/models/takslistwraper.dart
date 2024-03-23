import 'package:taks_app/presetetion/data/models/taksitem.dart';

class Takslistwraper {
  String? status;
  List<Taksitem>? data;

  Takslistwraper({this.status, this.data});

  Takslistwraper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Taksitem>[];
      json['data'].forEach((v) {
        data!.add(new Taksitem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
