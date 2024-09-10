import 'package:get/get.dart';

class GetBrandModel {
  Data? data;
  int? status;

  GetBrandModel({this.data, this.status});

  GetBrandModel.fromJson(Map<String, dynamic> json) {
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
  List<BrandData>? brandList;

  Data({this.brandList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['array'] != null) {
      brandList = <BrandData>[];
      json['array'].forEach((v) {
        brandList!.add(BrandData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (brandList != null) {
      data['array'] = brandList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandData {
  int? favorFlag;
  String? linkingTargetTypes;
  int? manuId;
  String? manuName;
  RxBool? isSelected =false.obs; /// :  NOT A API SIDE - LOCALLY ADDED


  BrandData({this.favorFlag, this.linkingTargetTypes, this.manuId, this.manuName,this.isSelected});

  BrandData.fromJson(Map<String, dynamic> json) {
    favorFlag = json['favorFlag'];
    linkingTargetTypes = json['linkingTargetTypes'];
    manuId = json['manuId'];
    manuName = json['manuName'];
    isSelected = isSelected;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['favorFlag'] = favorFlag;
    data['linkingTargetTypes'] = linkingTargetTypes;
    data['manuId'] = manuId;
    data['manuName'] = manuName;
    return data;
  }
}
