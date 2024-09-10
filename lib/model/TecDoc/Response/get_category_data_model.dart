class GetCategoryModel {
  Data? data;
  int? status;

  GetCategoryModel({this.data, this.status});

  GetCategoryModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  List<CategoryData>? categoryList;

  Data({this.categoryList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['array'] != null) {
      categoryList = <CategoryData>[];
      json['array'].forEach((v) {
        categoryList!.add(CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categoryList != null) {
      data['array'] = categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryData {
  String? assemblyGroupName;
  int? assemblyGroupNodeId;
  bool? hasChilds;  // true = means sub category and false means only category
  int? parentNodeId;

  CategoryData(
      {this.assemblyGroupName,
        this.assemblyGroupNodeId,
        this.hasChilds,
        this.parentNodeId});

  CategoryData.fromJson(Map<String, dynamic> json) {
    assemblyGroupName = json['assemblyGroupName'];
    assemblyGroupNodeId = json['assemblyGroupNodeId'];
    hasChilds = json['hasChilds'];
    parentNodeId = json['parentNodeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assemblyGroupName'] = assemblyGroupName;
    data['assemblyGroupNodeId'] = assemblyGroupNodeId;
    data['hasChilds'] = hasChilds;
    data['parentNodeId'] = parentNodeId;
    return data;
  }
}
