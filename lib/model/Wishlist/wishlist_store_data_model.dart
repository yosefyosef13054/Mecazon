class WishListStoreDataModel {
  bool? success;
  String? messages;
  WishListStoreResult? result;

  WishListStoreDataModel({this.success, this.messages, this.result});

  WishListStoreDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? WishListStoreResult() : json['result'] != null ? WishListStoreResult.fromJson(json['result']) : null;
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

class WishListStoreResult {
  List<WishListStoreList>? wishlistStoreList;

  WishListStoreResult({this.wishlistStoreList});

  WishListStoreResult.fromJson(Map<String, dynamic> json) {
    if (json['wishList'] != null) {
      wishlistStoreList = <WishListStoreList>[];
      json['wishList'].forEach((v) {
        wishlistStoreList!.add(WishListStoreList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wishlistStoreList != null) {
      data['wishList'] = wishlistStoreList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishListStoreList {
  int? id;
  int? storeId;
  bool? isActive;
  String? storeName;
  List<Images>? images;

  WishListStoreList(
      {this.id,
        this.storeId,
        this.isActive,
        this.storeName,
        this.images,
      });

  WishListStoreList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['storeId'];
    isActive = json['isActive'];
    storeName = json['storeName'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['storeId'] = storeId;
    data['isActive'] = isActive;
    data['storeName'] = storeName;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  int? storeId;
  String? storeImage;

  Images({this.id, this.storeId, this.storeImage});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['storeId'];
    storeImage = json['storeImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['storeId'] = storeId;
    data['storeImage'] = storeImage;
    return data;
  }
}
