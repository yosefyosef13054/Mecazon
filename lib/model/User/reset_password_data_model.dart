import 'package:mecazone/model/User/user_data_model.dart';

class ResetPasswordDataModel {
  bool? success;
  String? messages;
  ResetPasswordResult? result;

  ResetPasswordDataModel({this.success, this.messages, this.result});

  ResetPasswordDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? ResetPasswordResult() : json['result'] != null ? ResetPasswordResult.fromJson(json['result']) : null;
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

class ResetPasswordResult {
  User? user;

  ResetPasswordResult({this.user});

  ResetPasswordResult.fromJson(Map<String, dynamic> json) {
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

