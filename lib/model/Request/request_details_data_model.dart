class RequestDetailsDataModel {
  bool? success;
  String? messages;
  RequestDetailsResult? result;

  RequestDetailsDataModel({this.success, this.messages, this.result});

  RequestDetailsDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? RequestDetailsResult() : json['result'] != null ? RequestDetailsResult.fromJson(json['result']) : null;
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

class RequestDetailsResult {
  ProductRequestDetails? productRequestDetails;
  bool? requestLimit;
  int? limitNumber;

  RequestDetailsResult({this.productRequestDetails, this.requestLimit, this.limitNumber});

  RequestDetailsResult.fromJson(Map<String, dynamic> json) {
    productRequestDetails = json['productRequestDetails'] != null
        ? ProductRequestDetails.fromJson(json['productRequestDetails'])
        : null;
    requestLimit = json['requestLimit'];
    limitNumber = json['limitNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    final productRequestDetails = this.productRequestDetails;
    if (productRequestDetails != null) {
      data['productRequestDetails'] = productRequestDetails.toJson();
    }
    data['requestLimit'] = requestLimit;
    data['limitNumber'] = limitNumber;
    return data;
  }
}

class ProductRequestDetails {
  int? id;
  String? productName;
  String? brandName;
  String? modelName;
  int? year;
  String? description;
  int? createdBy;
  int? brandId;
  int? modelId;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
  bool? isActive;
  String? active;
  String? isApproved;
  String? approved;
  String? isDeleted;
  int? customerId;
  String? strCustomer;
  int? mfrId;
  String? mfrName;
  String? phoneNumber;
  String? oenumber;
  String? requestImages;

  ProductRequestDetails(
      {this.id,
        this.productName,
        this.brandName,
        this.modelName,
        this.year,
        this.description,
        this.createdBy,
        this.brandId,
        this.modelId,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.isActive,
        this.active,
        this.isApproved,
        this.approved,
        this.isDeleted,
        this.customerId,
        this.strCustomer,
        this.mfrId,
        this.mfrName,
        this.phoneNumber,
        this.oenumber,
        this.requestImages});

  ProductRequestDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    brandName = json['brandName'];
    modelName = json['modelName'];
    year = json['year'];
    description = json['description'];
    createdBy = json['createdBy'];
    brandId = json['brandId'];
    modelId = json['modelId'];
    createdOn = json['createdOn'];
    updatedBy = json['updatedBy'];
    updatedOn = json['updatedOn'];
    isActive = json['isActive'];
    active = json['active'];
    isApproved = json['isApproved'];
    approved = json['approved'];
    isDeleted = json['isDeleted'];
    customerId = json['customerId'];
    strCustomer = json['strCustomer'];
    mfrId = json['mfrId'];
    mfrName = json['mfrName'];
    phoneNumber = json['phoneNumber'];
    oenumber = json['oenumber'];
    requestImages = json['requestImages'];
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
    data['createdOn'] = createdOn;
    data['updatedBy'] = updatedBy;
    data['updatedOn'] = updatedOn;
    data['isActive'] = isActive;
    data['active'] = active;
    data['isApproved'] = isApproved;
    data['approved'] = approved;
    data['isDeleted'] = isDeleted;
    data['customerId'] = customerId;
    data['strCustomer'] = strCustomer;
    data['mfrId'] = mfrId;
    data['mfrName'] = mfrName;
    data['phoneNumber'] = phoneNumber;
    data['oenumber'] = oenumber;
    data['requestImages'] = requestImages;
    return data;
  }
}
