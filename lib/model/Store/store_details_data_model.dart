import 'package:mecazone/model/Store/store_list_data_model.dart';

class StoreDetailsDataModel {
  bool? success;
  String? messages;
  StoreDetailsResult? result;

  StoreDetailsDataModel({this.success, this.messages, this.result});

  StoreDetailsDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    messages = json['messages'] ?? "";
    result = json['result'] == "" ? StoreDetailsResult() : json['result'] != null ? StoreDetailsResult.fromJson(json['result']) : null;
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

class StoreDetailsResult {
  StoreList? storeDetails;
  List<StoreProducts>? storeProducts;
  bool? isWishlisted;

  StoreDetailsResult({this.storeDetails,this.storeProducts,this.isWishlisted});

  StoreDetailsResult.fromJson(Map<String, dynamic> json) {

    storeDetails = json['storeDetails'] != null
        ? StoreList.fromJson(json['storeDetails'])
        : StoreList();

    if (json['storeProducts'] != null) {
      storeProducts = <StoreProducts>[];
      json['storeProducts'].forEach((v) {
        storeProducts!.add(StoreProducts.fromJson(v));
      });
    }

    isWishlisted = json['isWishlisted']?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (storeDetails != null) {
      data['storeDetails'] = storeDetails!.toJson();
    }
    if (storeProducts != null) {
      data['storeProducts'] = storeProducts!.map((v) => v.toJson()).toList();
    }
    data['isWishlisted'] = isWishlisted;
    return data;
  }

}

class StoreProducts {
  int? id;
  int? productOemNumber;
  int? brandId;
  String? productName;
  List<ProductImagesView>? productImagesView;

  StoreProducts({this.id, this.productOemNumber, this.brandId, this.productName,this.productImagesView});

  StoreProducts.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    productOemNumber = json['storeId']??0;
    brandId = json['brandId']??0;
    productName = json['productName']??"";
    if (json['productImagesView'] != null) {
      productImagesView = <ProductImagesView>[];
      json['productImagesView'].forEach((v) {
        productImagesView!.add(ProductImagesView.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['storeId'] = productOemNumber;
    data['brandId'] = brandId;
    data['productName'] = productName;
    if (productImagesView != null) {
      data['productImagesView'] = productImagesView!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImagesView {
  int? imageId;
  int? productId;
  String? image;

  ProductImagesView({this.imageId, this.productId, this.image});

  ProductImagesView.fromJson(Map<String, dynamic> json) {
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