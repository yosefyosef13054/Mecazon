import 'package:get/get.dart';

class ModelDataModel {
  bool? success;
  String? messages;
  ModelResult? result;

  ModelDataModel({this.success, this.messages, this.result});

  ModelDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? ModelResult() : json['result'] != null ? ModelResult.fromJson(json['result']) : null;
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

class ModelResult {
  List<ModelList>? modelList;

  ModelResult({this.modelList});

  ModelResult.fromJson(Map<String, dynamic> json) {
    if (json['modelList'] != null) {
      modelList = <ModelList>[];
      json['modelList'].forEach((v) {
        modelList!.add(ModelList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (modelList != null) {
      data['modelList'] = modelList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModelList {
  // int? id;
  int? modelId;
  String? modelName;
  bool? isActive;
  String? active;
  int? createdBy;
  RxBool? isSelected =false.obs; /// :  NOT A API SIDE - LOCALLY ADDED

  ModelList(
      {
        this.modelId,
        this.modelName,
        this.isActive,
        this.active,
        this.createdBy,
        this.isSelected});

  ModelList.fromJson(Map<String, dynamic> json) {
    modelId = json['modelId'] ?? 0;
    modelName = json['modelName'] ?? "";
    isActive = json['isActive'] ?? false;
    active = json['active'] ?? "";
    createdBy = json['createdBy'] ?? "";
    isSelected = isSelected;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['modelId'] = modelId;
    data['modelName'] = modelName;
    data['isActive'] = isActive;
    data['active'] = active;
    data['createdBy'] = createdBy;
    return data;
  }
}
