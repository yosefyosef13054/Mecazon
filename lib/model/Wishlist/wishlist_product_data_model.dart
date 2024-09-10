class WishListProductDataModel {
  bool? success;
  String? messages;
  WishListProductResult? result;

  WishListProductDataModel({this.success, this.messages, this.result});

  WishListProductDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? WishListProductResult() : json['result'] != null ? WishListProductResult.fromJson(json['result']) : null;
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

class WishListProductResult {
  List<WishlistProductList>? wishlistProductList;

  WishListProductResult({this.wishlistProductList});

  WishListProductResult.fromJson(Map<String, dynamic> json) {
    if (json['wishList'] != null) {
      wishlistProductList = <WishlistProductList>[];
      json['wishList'].forEach((v) {
        wishlistProductList!.add(WishlistProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wishlistProductList != null) {
      data['wishList'] = wishlistProductList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishlistProductList {
  int? id;
  int? productId;
  String? productName;
  bool? isActive;
  List<Image>? image;
  List<OemNumber>? oemNumber;

  WishlistProductList(
      {this.id,
        this.productId,
        this.productName,
        this.isActive,
        this.image,
        this.oemNumber});

  WishlistProductList.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    productId = json['productId']??0;
    productName = json['productName']??"";
    isActive = json['isActive']??false;
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(Image.fromJson(v));
      });
    }
    if (json['oemNumber'] != null) {
      oemNumber = <OemNumber>[];
      json['oemNumber'].forEach((v) {
        oemNumber!.add(OemNumber.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['productName'] = productName;
    data['isActive'] = isActive;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    if (oemNumber != null) {
      data['oemNumber'] = oemNumber!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Image {
  int? imageId;
  int? productId;
  String? image;

  Image({this.imageId, this.productId, this.image});

  Image.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId']??0;
    productId = json['productId']??0;
    image = json['image']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageId'] = imageId;
    data['productId'] = productId;
    data['image'] = image;
    return data;
  }
}

class OemNumber {
  int? id;
  int? productId;
  int? brandId;
  int? oemId;
  String? oem;
  String? articleNumber;
  String? brandName;

  OemNumber(
      {this.id,
        this.productId,
        this.brandId,
        this.articleNumber,
        this.brandName,
        this.oem,
        this.oemId});

  OemNumber.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    productId = json['productId']??0;
    brandId = json['brandId']??0;
    articleNumber = json['articleNumber']??"";
    brandName = json['brandName']??"";
    oemId = json['oemId']??0;
    oem = json['oem']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['brandId'] = brandId;
    data['articleNumber'] = articleNumber;
    data['brandName'] = brandName;
    data['oem'] = oem;
    data['oemId'] = oemId;
    return data;
  }
}
