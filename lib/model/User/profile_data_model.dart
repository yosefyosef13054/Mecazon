import 'package:mecazone/model/User/user_data_model.dart';

class ProfileDataModel {
  bool? success;
  String? messages;
  ProfileResult? result;

  ProfileDataModel({this.success, this.messages, this.result});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? ProfileResult() : json['result'] != null ? ProfileResult.fromJson(json['result']) : null;
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

class ProfileResult {
  User? user;

  ProfileResult({this.user});

  ProfileResult.fromJson(Map<String, dynamic> json) {
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

