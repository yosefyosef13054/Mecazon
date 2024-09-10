class ProductRequestDataModel {
  bool? success;
  String? messages;
  ProductRequestResult? result;

  ProductRequestDataModel({this.success, this.messages, this.result});

  ProductRequestDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? ProductRequestResult() : json['result'] != null ? ProductRequestResult.fromJson(json['result']) : null;
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

class ProductRequestResult {
  List<ProductRequestList>? productRequestList;
  bool? requestLimit; // here false means request limit over
  int? limitNumber; // total number of limit represent

  ProductRequestResult({this.productRequestList,this.requestLimit,this.limitNumber});

  ProductRequestResult.fromJson(Map<String, dynamic> json) {
    if (json['productRequestList'] != null) {
      productRequestList = <ProductRequestList>[];
      json['productRequestList'].forEach((v) {
        productRequestList!.add(ProductRequestList.fromJson(v));
      });
    }
    requestLimit = json['requestLimit'] ?? true;
    limitNumber = json['limitNumber'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productRequestList != null) {
      data['productRequestList'] = productRequestList!.map((v) => v.toJson()).toList();
    }
    data['requestLimit'] = requestLimit;
    data['limitNumber'] = limitNumber;
    return data;
  }
}

class ProductRequestList {
  int? id;
  String? productName;
  String? brandName;
  String? modelName;
  int? year;
  String? description;
  int? createdBy;
  int? brandId;
  int? modelId;
  int? modelTypeId;
  int? customerId;
  int? mfrId;
  String? mfrName;
  String? phoneNumber;
  String? oenumber;
  String? image;

  ProductRequestList(
      {this.id,
        this.productName,
        this.brandName,
        this.modelName,
        this.year,
        this.description,
        this.createdBy,
        this.brandId,
        this.modelId,
        this.modelTypeId,
        this.customerId,
        this.mfrId,
        this.mfrName,
        this.phoneNumber,
        this.oenumber,
        this.image
      });

  ProductRequestList.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    productName = json['productName']??"";
    brandName = json['brandName']??"";
    modelName = json['modelName']??"";
    year = json['year']??0;
    description = json['description']??"";
    createdBy = json['createdBy']??0;
    brandId = json['brandId']??0;
    modelId = json['modelId']??0;
    modelTypeId = json['modelTypeId']??0;
    customerId = json['customerId']??0;
    mfrId = json['mfrId']??0;
    mfrName = json['mfrName']??"";
    phoneNumber = json['phoneNumber']??"";
    oenumber = json['oenumber']??"";
    image = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productName'] = productName;
    data['brandName'] = brandName;
    data['modelName'] = modelName;
    data['year'] = year;
    data['description'] = description;
    data['createdBy'] = createdBy;
    data['brandId'] = brandId;
    data['modelId'] = modelId;
    data['modelTypeId'] = modelTypeId;
    data['customerId'] = customerId;
    data['mfrId'] = mfrId;
    data['mfrName'] = mfrName;
    data['phoneNumber'] = phoneNumber;
    data['oenumber'] = oenumber;
    return data;
  }
}
