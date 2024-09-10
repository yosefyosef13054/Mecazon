class StoreDataModel {
  bool? success;
  String? messages;
  StoreResult? result;

  StoreDataModel({this.success, this.messages, this.result});

  StoreDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? StoreResult() : json['result'] != null ? StoreResult.fromJson(json['result']) : null;
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

class StoreResult {
  List<StoreList>? storeList;

  StoreResult({this.storeList});

  StoreResult.fromJson(Map<String, dynamic> json) {
    if (json['storeList'] != null) {
      storeList = <StoreList>[];
      json['storeList'].forEach((v) {
        storeList!.add(StoreList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (storeList != null) {
      data['storeList'] = storeList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class StoreList {
  int? id;
  int? professionalId;
  int? provinceId;
  int? visitCount;
  int? wishListCount;
  int? storeTotalProductCounts;
  int? subscriptionId;
  int? municipalityId;
  String? storeName;
  String? description;
  String? address;
  String? provinceName;
  String? municipalityName;
  String? subscriptionName;
  bool? isAvailableDelivery;
  bool? isHide;
  bool? isActive;
  bool? isWishListed;
  List<StoreManagementImagesView>? storeManagementImagesView;
  List<StoreManagementBrandsView>? storeManagementBrandsView;
  List<StoreMangementPhoneNumber>? storeManagementPhoneNumber;

  StoreList(
      {this.id,
        this.subscriptionId,
        this.visitCount,
        this.wishListCount,
        this.storeTotalProductCounts,
        this.storeName,
        this.description,
        this.isAvailableDelivery,
        this.isActive,
        this.address,
        this.provinceName,
        this.municipalityName,
        this.isHide,
        this.professionalId,
        this.provinceId,
        this.municipalityId,
        this.subscriptionName,
        this.isWishListed,
        this.storeManagementImagesView,
        this.storeManagementBrandsView,
        this.storeManagementPhoneNumber
      });

  StoreList.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    subscriptionId = json['subscriptionId']??0;
    visitCount = json['visitCount']??0;
    wishListCount = json['wishListCount']??0;
    storeTotalProductCounts = json['storeTotalProductCounts']??0;
    storeName = json['storeName']??"";
    description = json['description']??"";
    isAvailableDelivery = json['availableDelivery']?? false;
    isActive = json['isActive']??false;
    address = json['address']??"";
    provinceName = json['provinceName']??"";
    municipalityName = json['municipalityName']??"";
    subscriptionName = json['subscriptionName']??"";
    isHide = json['isHide']??false;
    isWishListed = json['isWishListed']??false;
    professionalId = json['professionalId']??0;
    provinceId = json['provinceId']??0;
    municipalityId = json['municipalityId']??0;
    if (json['storeManagementImagesView'] != null) {
      storeManagementImagesView = <StoreManagementImagesView>[];
      json['storeManagementImagesView'].forEach((v) {
        storeManagementImagesView!.add(StoreManagementImagesView.fromJson(v));
      });
    }
    if (json['storeManagementBrandsView'] != null) {
      storeManagementBrandsView = <StoreManagementBrandsView>[];
      json['storeManagementBrandsView'].forEach((v) {
        storeManagementBrandsView!.add(StoreManagementBrandsView.fromJson(v));
      });
    }

    if (json['storeMangementPhoneNumber'] != null) {
      storeManagementPhoneNumber = <StoreMangementPhoneNumber>[];
      json['storeMangementPhoneNumber'].forEach((v) {
        storeManagementPhoneNumber!
            .add(StoreMangementPhoneNumber.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subscriptionId'] = subscriptionId;
    data['visitCount'] = visitCount;
    data['wishListCount'] = wishListCount;
    data['storeTotalProductCounts'] = storeTotalProductCounts;
    data['storeName'] = storeName;
    data['description'] = description;
    data['availableDelivery'] = isAvailableDelivery;
    data['isActive'] = isActive;
    data['address'] = address;
    data['provinceName'] = provinceName;
    data['municipalityName'] = municipalityName;
    data['subscriptionName'] = subscriptionName;
    data['isHide'] = isHide;
    data['isWishListed'] = isWishListed;
    data['professionalId'] = professionalId;
    data['provinceId'] = provinceId;
    data['municipalityId'] = municipalityId;
    if (storeManagementImagesView != null) {
      data['storeManagementImagesView'] =
          storeManagementImagesView!.map((v) => v.toJson()).toList();
    }
    if (storeManagementBrandsView != null) {
      data['storeManagementBrandsView'] =
          storeManagementBrandsView!.map((v) => v.toJson()).toList();
    }
    if (storeManagementPhoneNumber != null) {
      data['storeMangementPhoneNumber'] =
          storeManagementPhoneNumber!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoreManagementImagesView {
  int? id;
  int? storeId;
  String? storeImage;

  StoreManagementImagesView({this.id, this.storeId, this.storeImage});

  StoreManagementImagesView.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    storeId = json['storeId']??0;
    storeImage = json['storeImage']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['storeId'] = storeId;
    data['storeImage'] = storeImage;
    return data;
  }
}

class StoreManagementBrandsView {
  int? id;
  int? storeId;
  int? brandId;
  String? brandName;

  StoreManagementBrandsView(
      {this.id, this.storeId, this.brandId, this.brandName});

  StoreManagementBrandsView.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    storeId = json['storeId']??0;
    brandId = json['brandId']??0;
    brandName = json['brandName']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['storeId'] = storeId;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    return data;
  }
}

class StoreMangementPhoneNumber {
  int? id;
  int? storeId;
  int? countryId;
  String? phoneNumber;

  StoreMangementPhoneNumber(
      {this.id, this.storeId, this.countryId, this.phoneNumber});

  StoreMangementPhoneNumber.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['storeId'];
    countryId = json['countryId'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['storeId'] = storeId;
    data['countryId'] = countryId;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}