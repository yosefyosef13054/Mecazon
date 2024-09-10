import 'package:mecazone/model/User/user_data_model.dart';

class VerificationDataModel {
  bool? success;
  String? messages;
  VerificationResult? result;

  VerificationDataModel({this.success, this.messages, this.result});

  VerificationDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? VerificationResult() : json['result'] != null ? VerificationResult.fromJson(json['result']) : null;
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

class VerificationResult {
  User? user;

  VerificationResult({this.user});

  VerificationResult.fromJson(Map<String, dynamic> json) {
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

