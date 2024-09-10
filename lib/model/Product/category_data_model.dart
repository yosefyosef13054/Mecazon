class CategoryDataModel {
  bool? success;
  String? messages;
  CategoryResult? result;

  CategoryDataModel({this.success, this.messages, this.result});

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success']?? false;
    messages = json['messages']?? "";
    result = json['result'] == "" ? CategoryResult() : json['result'] != null ? CategoryResult.fromJson(json['result']) : null;
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

class CategoryResult {
  List<CategoryList>? categoryList;

  CategoryResult({this.categoryList});

  CategoryResult.fromJson(Map<String, dynamic> json) {
    if (json['categoryList'] != null) {
      categoryList = <CategoryList>[];
      json['categoryList'].forEach((v) {
        categoryList!.add(CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categoryList != null) {
      data['categoryList'] = categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryList {
  int? id;
  int? assemblyGroupId;
  int? assebmlyGroupNodeId;
  String? categoryName;
  String? assemblyGroupName;
  String? active;
  String? strProfilePicture;
  bool? isActive;
  bool? isAdminCategory;
  bool? isCurrentUserCategory;
  bool? isOnlineSynced;
  bool? hasChild;

  CategoryList(
      {this.id,
        this.assemblyGroupId,
        this.assebmlyGroupNodeId,
        this.categoryName,
        this.isActive,
        this.assemblyGroupName,
        this.active,
        this.isAdminCategory,
        this.isCurrentUserCategory,
        this.strProfilePicture,
        this.isOnlineSynced,
        this.hasChild});

  CategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    assemblyGroupId = json['assemblyGroupId']??0;
    assebmlyGroupNodeId = json['assebmlyGroupNodeId']??0;
    categoryName = json['categoryName']??"";
    assemblyGroupName = json['assemblyGroupName']??"";
    strProfilePicture = json['strProfilePicture']??"";
    active = json['active']??"";
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
    data['isActive'] = isActive;
    data['assemblyGroupName'] = assemblyGroupName;
    data['active'] = active;
    data['isAdminCategory'] = isAdminCategory;
    data['isCurrentUserCategory'] = isCurrentUserCategory;
    data['strProfilePicture'] = strProfilePicture;
    data['isOnlineSynced'] = isOnlineSynced;
    data['hasChild'] = hasChild;
    return data;
  }
}
