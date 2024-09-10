class AssemblyGroupDataModel {
  bool? success;
  String? messages;
  AssemblyGroupResult? result;

  AssemblyGroupDataModel({this.success, this.messages, this.result});

  AssemblyGroupDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success']?? false;
    messages = json['messages']?? "";
    result = json['result'] == "" ? AssemblyGroupResult() : json['result'] != null ? AssemblyGroupResult.fromJson(json['result']) : null;
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

class AssemblyGroupResult {
  List<AssemblyGroupList>? assemblyGroupList;

  AssemblyGroupResult({this.assemblyGroupList});

  AssemblyGroupResult.fromJson(Map<String, dynamic> json) {
    if (json['assemblyGroupList'] != null) {
      assemblyGroupList = <AssemblyGroupList>[];
      json['assemblyGroupList'].forEach((v) {
        assemblyGroupList!.add(AssemblyGroupList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (assemblyGroupList != null) {
      data['assemblyGroupList'] = assemblyGroupList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssemblyGroupList {
  int? id;
  int? shortCutId;
  String? shortCutName;
  String? strImage;

  AssemblyGroupList({this.id, this.shortCutName, this.strImage,this.shortCutId});

  AssemblyGroupList.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    shortCutId = json['shortCutId']??0;
    shortCutName = json['shortCutName']??"";
    strImage = json['strImage']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shortCutId'] = shortCutId;
    data['shortCutName'] = shortCutName;
    data['strImage'] = strImage;
    return data;
  }
}