import 'result.dart';

class APIResponse {
  Result? result;
  String? message;
  bool? success;

  APIResponse({
    this.success,
    this.message,
    this.result
  });

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    if(json['result'] == ""){
      return APIResponse(
          message: json['messages'] ?? "",
          success: json['success'] ?? false,
          result: Result()
      );
    }else{
      return APIResponse(
          message: json['messages'] ?? "",
          success: json['success'] ?? false,
          result: json['result'] != null ? Result.fromJson(json['result']) : null
      );
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messages'] = message;
    data['success'] = success;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}
