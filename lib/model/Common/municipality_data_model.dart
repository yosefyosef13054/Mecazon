class MunicipalityDataModel {
  bool? success;
  String? messages;
  MunicipalityResult? result;

  MunicipalityDataModel({this.success, this.messages, this.result});

  MunicipalityDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? MunicipalityResult() : json['result'] != null ? MunicipalityResult.fromJson(json['result']) : null;
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

class MunicipalityResult {
  List<MunicipalityList>? municipalityList;

  MunicipalityResult({this.municipalityList});

  MunicipalityResult.fromJson(Map<String, dynamic> json) {
    if (json['municipalityList'] != null) {
      municipalityList = <MunicipalityList>[];
      json['municipalityList'].forEach((v) {
        municipalityList!.add(MunicipalityList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (municipalityList != null) {
      data['municipalityList'] = municipalityList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MunicipalityList {
  int? id;
  int? postCode;
  String? name;

  MunicipalityList({this.id, this.postCode, this.name});

  MunicipalityList.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    postCode = json['postCode']??0;
    name = json['name']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['postCode'] = postCode;
    data['name'] = name;
    return data;
  }
}