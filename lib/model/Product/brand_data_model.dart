import 'package:get/get.dart';

class BrandDataModel {
  bool? success;
  String? messages;
  BrandResult? result;

  BrandDataModel({this.success, this.messages, this.result});

  BrandDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? BrandResult() : json['result'] != null ? BrandResult.fromJson(json['result']) : null;
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

class BrandResult {
  List<BrandList>? brandList;

  BrandResult({this.brandList});

  BrandResult.fromJson(Map<String, dynamic> json) {
    if (json['brandList'] != null) {
      brandList = <BrandList>[];
      json['brandList'].forEach((v) {
        brandList!.add(BrandList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (brandList != null) {
      data['brandList'] = brandList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandList {
  // int? id;
  int? brandId;
  String? brandName;
  String? brandDescription;
  bool? isActive;
  String? iListRole;
  String? active;
  String? moduleName;
  bool? isAdminBrand;
  bool? isCurrentUserBrand;
  int? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
  String? image;
  String? strProfilePicture;

  RxBool? isSelected =false.obs; /// :  NOT A API SIDE - LOCALLY ADDED

  BrandList(
      {/*this.id,*/
        this.brandId,
        this.brandName,
        this.brandDescription,
        this.isActive,
        this.iListRole,
        this.active,
        this.moduleName,
        this.isAdminBrand,
        this.isCurrentUserBrand,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.image,
        this.strProfilePicture,
        this.isSelected
      });

  BrandList.fromJson(Map<String, dynamic> json) {
    // id = json['id']??0;
    brandId = json['brandId']??0;
    brandName = json['brandName']??"";
    brandDescription = json['brandDescription']??"";
    isActive = json['isActive']??"";
    iListRole = json['iListRole']??"";
    active = json['active']??"";
    moduleName = json['moduleName']??"";
    isAdminBrand = json['isAdminBrand']??false;
    isCurrentUserBrand = json['isCurrentUserBrand']??false;
    createdBy = json['createdBy']??0;
    createdOn = json['createdOn']??"";
    updatedBy = json['updatedBy']??"";
    updatedOn = json['updatedOn']??"";
    image = json['image']??"";
    strProfilePicture = json['strProfilePicture']??"";
    isSelected = isSelected;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['brandDescription'] = brandDescription;
    data['isActive'] = isActive;
    data['iListRole'] = iListRole;
    data['active'] = active;
    data['moduleName'] = moduleName;
    data['isAdminBrand'] = isAdminBrand;
    data['isCurrentUserBrand'] = isCurrentUserBrand;
    data['createdBy'] = createdBy;
    data['createdOn'] = createdOn;
    data['updatedBy'] = updatedBy;
    data['updatedOn'] = updatedOn;
    data['image'] = image;
    data['strProfilePicture'] = strProfilePicture;
    return data;
  }
}
