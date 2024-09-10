class OTPVerificationDataModel {
  bool? success;
  String? messages;
  String? result;

  OTPVerificationDataModel({this.success, this.messages, this.result});

  OTPVerificationDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['messages'] = messages;
    data['result'] = result;
    return data;
  }
}
