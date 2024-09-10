import 'package:mecazone/model/User/user_data_model.dart';

class SignUpDataModel {
  bool? success;
  String? messages;
  SignUpResult? result;

  SignUpDataModel({this.success, this.messages, this.result});

  SignUpDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? SignUpResult() : json['result'] != null ? SignUpResult.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['messages'] = messages;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class SignUpResult {
  User? user;

  SignUpResult({this.user});

  SignUpResult.fromJson(Map<String, dynamic> json) {
    user = json['frontUserDetails'] != null
        ? User.fromJson(json['frontUserDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['frontUserDetails'] = user!.toJson();
    }
    return data;
  }
}

