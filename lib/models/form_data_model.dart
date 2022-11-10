import 'dart:convert';

class FormDataModel {
  String? formValue;
  int? status;
  int? id;
  int? creationDate;
  int? endingDate;

  FormDataModel({
    this.formValue,
    this.status,
    this.id,
  }) {
    creationDate = DateTime.now().millisecondsSinceEpoch;
    status = 0;
  }

  FormDataModel.fromJson(Map<String, dynamic> json) {
    formValue = json['formValue'];
    status = json['status'];
    id = json['id'];
    creationDate = json['creationDate'];
    endingDate = json["endingDate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formValue'] = this.formValue;
    data["creationDate"] = creationDate;
    data["status"] = status;

    return data;
  }
}
