class ProvinceDataModel {
  bool? success;
  String? messages;
  ProvinceResult? result;

  ProvinceDataModel({this.success, this.messages, this.result});

  ProvinceDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? ProvinceResult() : json['result'] != null ? ProvinceResult.fromJson(json['result']) : null;
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

class ProvinceResult {
  List<ProvinceList>? provinceList;

  ProvinceResult({this.provinceList});

  ProvinceResult.fromJson(Map<String, dynamic> json) {
    if (json['provinceList'] != null) {
      provinceList = <ProvinceList>[];
      json['provinceList'].forEach((v) {
        provinceList!.add(ProvinceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (provinceList != null) {
      data['provinceList'] = provinceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProvinceList {
  int? id;
  int? code;
  String? name;

  ProvinceList({this.id, this.code, this.name});

  ProvinceList.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    code = json['code']??0;
    name = json['name']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}


