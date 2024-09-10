import 'package:mecazone/model/User/user_data_model.dart';

class ForgotPasswordDataModel {
  bool? success;
  String? messages;
  ForgotPasswordResult? result;

  ForgotPasswordDataModel({this.success, this.messages, this.result});

  ForgotPasswordDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? ForgotPasswordResult() : json['result'] != null ? ForgotPasswordResult.fromJson(json['result']) : null;
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

class ForgotPasswordResult {
  User? user;

  ForgotPasswordResult({this.user});

  ForgotPasswordResult.fromJson(Map<String, dynamic> json) {
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

