import 'package:get/get.dart';

class GetCarModelType {
  Data? data;
  int? status;

  GetCarModelType({this.data, this.status});

  GetCarModelType.fromJson(Map<String, dynamic> json) {
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
  List<ModelTypeData>? modelTypeList;

  Data({this.modelTypeList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['array'] != null) {
      modelTypeList = <ModelTypeData>[];
      json['array'].forEach((v) {
        modelTypeList!.add(ModelTypeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (modelTypeList != null) {
      data['array'] = modelTypeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModelTypeData {
  int? carId;
  String? carName;
  String? carType;
  String? firstCountry;
  RxBool? isSelected =false.obs; /// :  NOT A API SIDE - LOCALLY ADDED

  ModelTypeData({this.carId, this.carName, this.carType, this.firstCountry,this.isSelected});

  ModelTypeData.fromJson(Map<String, dynamic> json) {
    carId = json['carId'];
    carName = json['carName'];
    carType = json['carType'];
    firstCountry = json['firstCountry'];
    isSelected = isSelected;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['carId'] = carId;
    data['carName'] = carName;
    data['carType'] = carType;
    data['firstCountry'] = firstCountry;
    return data;
  }
}
