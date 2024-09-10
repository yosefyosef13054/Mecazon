class SubCategoryDataModel {
  bool? success;
  String? messages;
  SubCategoryResult? subcategoryResult;

  SubCategoryDataModel({this.success, this.messages, this.subcategoryResult});

  SubCategoryDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    subcategoryResult = json['result'] == "" ? SubCategoryResult() : json['result'] != null ? SubCategoryResult.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['messages'] = messages;
    if (subcategoryResult != null) {
      data['result'] = subcategoryResult!.toJson();
    }
    return data;
  }
}

class SubCategoryResult {
  List<SubCategoryList>? subCategoryList;

  SubCategoryResult({this.subCategoryList});

  SubCategoryResult.fromJson(Map<String, dynamic> json) {
    if (json['subCategoryData'] != null) {
      subCategoryList = <SubCategoryList>[];
      json['subCategoryData'].forEach((v) {
        subCategoryList!.add(SubCategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subCategoryList != null) {
      data['subCategoryData'] = subCategoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategoryList {
  int? id;
  int? assemblyGroupId;
  int? assebmlyGroupNodeId;
  String? categoryName;
  String? parentCategoryName;
  String? assemblyGroupName;
  String? active;
  String? strProfilePicture;
  bool? isActive;
  bool? isAdminCategory;
  bool? isCurrentUserCategory;
  bool? isOnlineSynced;
  bool? hasChild;

  SubCategoryList(
      {this.id,
        this.assemblyGroupId,
        this.assebmlyGroupNodeId,
        this.categoryName,
        this.parentCategoryName,
        this.assemblyGroupName,
        this.active,
        this.strProfilePicture,
        this.isActive,
        this.isAdminCategory,
        this.isCurrentUserCategory,
        this.isOnlineSynced,
        this.hasChild});

  SubCategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    assemblyGroupId = json['assemblyGroupId']??0;
    assebmlyGroupNodeId = json['assebmlyGroupNodeId']??0;
    categoryName = json['categoryName']??"";
    parentCategoryName = json['parentCategoryName']??"";
    assemblyGroupName = json['assemblyGroupName']??"";
    active = json['active']??"";
    strProfilePicture = json['strProfilePicture'] ?? "";
    isActive = json['isActive']??false;
    isAdminCategory = json['isAdminCategory']??false;
    isCurrentUserCategory = json['isCurrentUserCategory']??false;
    isOnlineSynced = json['isOnlineSynced']??false;
    hasChild = json['hasChild']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['assemblyGroupId'] = assemblyGroupId;
    data['assebmlyGroupNodeId'] = assebmlyGroupNodeId;
    data['categoryName'] = categoryName;
    data['parentCategoryName'] = parentCategoryName;
    data['assemblyGroupName'] = assemblyGroupName;
    data['active'] = active;
    data['strProfilePicture'] = strProfilePicture;
    data['isActive'] = isActive;
    data['isAdminCategory'] = isAdminCategory;
    data['isCurrentUserCategory'] = isCurrentUserCategory;
    data['isOnlineSynced'] = isOnlineSynced;
    data['hasChild'] = hasChild;
    return data;
  }
}
