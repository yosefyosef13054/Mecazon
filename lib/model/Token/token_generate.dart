import 'token_result.dart';

class TokenGenerate {
  List<Object>? messages;
  TokenResult? result;
  bool? success;

  TokenGenerate({this.messages, this.result, this.success});

  factory TokenGenerate.fromJson(Map<String, dynamic> json) {
    return TokenGenerate(
      //  messages: json['messages'] != null ? (json['messages'] as List).map((i) => Object.fromJson(i)).toList() : null,
      result: json['result'] != null ? TokenResult.fromJson(json['result']) : null,
      success: json['success'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    /* if (this.messages != null) {
            data['messages'] = this.messages.map((v) => v.toJson()).toList();
        }*/
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}
