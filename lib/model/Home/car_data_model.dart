class CarDataModel {
  bool? success;
  String? messages;
  CarResult? result;

  CarDataModel({this.success, this.messages, this.result});

  CarDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? CarResult() : json['result'] != null ? CarResult.fromJson(json['result']) : null;
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

class CarResult {
  List<CarList>? carList;

  CarResult({this.carList});

  CarResult.fromJson(Map<String, dynamic> json) {
    if (json['carList'] != null) {
      carList = <CarList>[];
      json['carList'].forEach((v) {
        carList!.add(CarList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (carList != null) {
      data['carList'] = carList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarList {
  int? id;
  int? userId;
  int? brandId;
  int? modelId;
  int? modelTypeId;
  String? brandName;
  String? modelName;
  String? modelTypeName;
  String? userName;
  String? image;

  CarList(
      {this.id,
        this.brandId,
        this.brandName,
        this.modelId,
        this.modelName,
        this.modelTypeId,
        this.modelTypeName,
        this.userId,
        this.userName,
        this.image});

  CarList.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    userId = json['userId']??0;
    brandId = json['brandId']??0;
    modelId = json['modelId']??0;
    modelTypeId = json['modelTypeId']??0;
    brandName = json['brandName']??"";
    modelName = json['modelName']??"";
    modelTypeName = json['modelTypeName']??"";
    userName = json['userName']??"";
    image = json['image']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    data['modelId'] = modelId;
    data['modelName'] = modelName;
    data['modelTypeId'] = modelTypeId;
    data['modelTypeName'] = modelTypeName;
    data['userId'] = userId;
    data['userName'] = userName;
    data['image'] = image;
    return data;
  }
}
