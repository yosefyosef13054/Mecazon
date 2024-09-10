import 'package:get/get.dart';

class ModelTypeDataModel {
  bool? success;
  String? messages;
  ModelTypeResult? result;

  ModelTypeDataModel({this.success, this.messages, this.result});

  ModelTypeDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? ModelTypeResult() : json['result'] != null ? ModelTypeResult.fromJson(json['result']) : null;
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

class ModelTypeResult {
  List<ModelTypeList>? modelTypeList;

  ModelTypeResult({this.modelTypeList});

  ModelTypeResult.fromJson(Map<String, dynamic> json) {
    if (json['modelList'] != null) {
      modelTypeList = <ModelTypeList>[];
      json['modelList'].forEach((v) {
        modelTypeList!.add(ModelTypeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (modelTypeList != null) {
      data['modelList'] = modelTypeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModelTypeList {
  int? id; /// : this id means car id
  String? typeName;
  bool? isActive;
  int? createdBy;
  String? active;

  RxBool? isSelected =false.obs; /// :  NOT A API SIDE - LOCALLY ADDED

  ModelTypeList({this.id, this.typeName, this.isActive, this.createdBy, this.active,this.isSelected});

  ModelTypeList.fromJson(Map<String, dynamic> json) {
    id = json['carId']??0;
    typeName = json['typeName']??"";
    isActive = json['isActive']??false;
    createdBy = json['createdBy']??"";
    active = json['active']??"";
    isSelected = isSelected;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['carId'] = id;
    data['typeName'] = typeName;
    data['isActive'] = isActive;
    data['createdBy'] = createdBy;
    data['active'] = active;
    return data;
  }
}