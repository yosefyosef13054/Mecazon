import 'package:get/get.dart';

class GetCarModel {
  Data? data;
  int? status;

  GetCarModel({this.data, this.status});

  GetCarModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] == "" ? Data() : json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Data {
  List<ModelData>? modelList;

  Data({this.modelList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['array'] != null) {
      modelList = <ModelData>[];
      json['array'].forEach((v) {
        modelList!.add(ModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (modelList != null) {
      data['array'] = modelList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModelData {
  int? favorFlag;
  int? modelId;
  String? modelname;
  int? yearOfConstrFrom;
  int? yearOfConstrTo;
  RxBool? isSelected =false.obs; /// :  NOT A API SIDE - LOCALLY ADDED

  ModelData(
      {this.favorFlag,
        this.modelId,
        this.modelname,
        this.yearOfConstrFrom,
        this.yearOfConstrTo,
        this.isSelected
      });

  ModelData.fromJson(Map<String, dynamic> json) {
    favorFlag = json['favorFlag'];
    modelId = json['modelId'];
    modelname = json['modelname'];
    yearOfConstrFrom = json['yearOfConstrFrom'];
    yearOfConstrTo = json['yearOfConstrTo'];
    isSelected = isSelected;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['favorFlag'] = favorFlag;
    data['modelId'] = modelId;
    data['modelname'] = modelname;
    data['yearOfConstrFrom'] = yearOfConstrFrom;
    data['yearOfConstrTo'] = yearOfConstrTo;
    return data;
  }
}
