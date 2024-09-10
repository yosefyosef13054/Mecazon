import 'package:mecazone/model/Common/province_data_model.dart';
import 'package:mecazone/model/Product/manufacturer_data_model.dart';
import 'package:mecazone/model/Request/request_data_model.dart';
import 'package:mecazone/model/Store/store_list_data_model.dart';
import 'package:mecazone/model/Wishlist/wishlist_product_data_model.dart';
import 'package:mecazone/model/product/category_data_model.dart';
import 'package:mecazone/model/product/model_type_data_model.dart';
import 'package:mecazone/model/Common/cms_data_model.dart';
import 'package:mecazone/model/Common/municipality_data_model.dart';
import 'package:mecazone/model/country_data_model.dart';
import 'package:mecazone/model/Product/brand_data_model.dart';
import 'package:mecazone/model/Store/store_details_data_model.dart';
import 'package:mecazone/model/User/user_data_model.dart';
import 'package:mecazone/model/Wishlist/wishlist_store_data_model.dart';
import 'package:mecazone/model/product/model_data_model.dart';

class Result {
  User? user;
  int? id;
  int? requestLimitNo;
  bool? isWishlisted;
  bool? isRequestLimitOver;

  ContentDetail? contentDetail;
  StoreList? storeDetails;

  List<CountryData>? countryList;
  List<CategoryList>? categoryList;
  List<BrandList>? brandList;
  List<ModelList>? modelList;
  List<ModelTypeList>? modelTypeList;

  List<ProvinceList>? provinceList;
  List<MunicipalityList>? municipalityList;
  List<StoreList>? storeList;
  List<WishListStoreList>? wishlistStoreList;
  List<WishlistProductList>? wishlistProductList;
  List<StoreProducts>? storeProducts;
  List<ProductRequestList>? productRequestList;
  List<ManufacturerData>? manufacturerList;

  Result(
      {this.id,
        this.requestLimitNo,
        this.isWishlisted,
        this.isRequestLimitOver,
        this.user,
        this.contentDetail,
        this.countryList,
        this.categoryList,
        this.brandList,
        this.modelList,
        this.modelTypeList,
        this.provinceList,
        this.municipalityList,
        this.storeDetails,
        this.storeList,
        this.storeProducts,
        this.wishlistStoreList,
        this.wishlistProductList,
        this.productRequestList,
        this.manufacturerList});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'] ?? 0,
      requestLimitNo: json['limitNumber'] ?? 0,
      isWishlisted: json['isWishlisted'] ?? false,
      isRequestLimitOver: json['requestLimit'] ?? false,
      user: json['frontUserDetails'] != null
          ? User.fromJson(json['frontUserDetails'])
          : null,
      contentDetail: json['contentDetail'] != null
          ? ContentDetail.fromJson(json['contentDetail'])
          : null,
      storeDetails: json['storeDetails'] != null
          ? StoreList.fromJson(json['storeDetails'])
          : null,
      countryList: json['countryList'] != null
          ? (json['countryList'] as List)
          .map((i) => CountryData.fromJson(i))
          .toList()
          : [],
      categoryList: json['catagoryList'] != null
          ? (json['catagoryList'] as List)
          .map((i) => CategoryList.fromJson(i))
          .toList()
          : [],
      brandList: json['brandList'] != null
          ? (json['brandList'] as List)
          .map((i) => BrandList.fromJson(i))
          .toList()
          : [],
      modelList: json['modelList'] != null
          ? (json['modelList'] as List)
          .map((i) => ModelList.fromJson(i))
          .toList()
          : [],
      modelTypeList: json['modelList'] != null
          ? (json['modelList'] as List)
          .map((i) => ModelTypeList.fromJson(i))
          .toList()
          : [],
      provinceList: json['provinceList'] != null
          ? (json['provinceList'] as List)
          .map((i) => ProvinceList.fromJson(i))
          .toList()
          : [],
      municipalityList: json['municipalityList'] != null
          ? (json['municipalityList'] as List)
          .map((i) => MunicipalityList.fromJson(i))
          .toList()
          : [],
      storeList: json['storeList'] != null
          ? (json['storeList'] as List)
          .map((i) => StoreList.fromJson(i))
          .toList()
          : [],
      storeProducts: json['storeProducts'] != null
          ? (json['storeProducts'] as List)
          .map((i) => StoreProducts.fromJson(i))
          .toList()
          : [],
      wishlistStoreList: json['wishList'] != null
          ? (json['wishList'] as List)
          .map((i) => WishListStoreList.fromJson(i))
          .toList()
          : [],
      wishlistProductList: json['wishList'] != null
          ? (json['wishList'] as List)
          .map((i) => WishlistProductList.fromJson(i))
          .toList()
          : [],
      productRequestList: json['productRequestList'] != null
          ? (json['productRequestList'] as List)
          .map((i) => ProductRequestList.fromJson(i))
          .toList()
          : [],
      manufacturerList: json['manufacturerList'] != null
          ? (json['manufacturerList'] as List)
          .map((i) => ManufacturerData.fromJson(i))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['limitNumber'] = requestLimitNo;
    data['isWishlisted'] = isWishlisted;
    data['requestLimit'] = isRequestLimitOver;

    if (user != null) {
      data['frontUserDetails'] = user!.toJson();
    }

    if (contentDetail != null) {
      data['contentDetail'] = contentDetail!.toJson();
    }

    if (storeDetails != null) {
      data['storeDetails'] = storeDetails!.toJson();
    }

    if (countryList != null) {
      data['countryList'] = countryList!.map((v) => v.toJson()).toList();
    }

    if (categoryList != null) {
      data['catagoryList'] = categoryList!.map((v) => v.toJson()).toList();
    }

    if (brandList != null) {
      data['brandList'] = brandList!.map((v) => v.toJson()).toList();
    }

    if (modelList != null) {
      data['modelList'] = modelList!.map((v) => v.toJson()).toList();
    }

    if (modelTypeList != null) {
      data['modelList'] = modelTypeList!.map((v) => v.toJson()).toList();
    }

    if (provinceList != null) {
      data['provinceList'] = provinceList!.map((v) => v.toJson()).toList();
    }

    if (municipalityList != null) {
      data['municipalityList'] =
          municipalityList!.map((v) => v.toJson()).toList();
    }

    if (storeList != null) {
      data['storeList'] = storeList!.map((v) => v.toJson()).toList();
    }

    if (storeProducts != null) {
      data['storeProducts'] = storeProducts!.map((v) => v.toJson()).toList();
    }

    if (wishlistStoreList != null) {
      data['wishList'] = wishlistStoreList!.map((v) => v.toJson()).toList();
    }

    if (wishlistProductList != null) {
      data['wishList'] = wishlistProductList!.map((v) => v.toJson()).toList();
    }

    if (productRequestList != null) {
      data['productRequestList'] =
          productRequestList!.map((v) => v.toJson()).toList();
    }

    if (manufacturerList != null) {
      data['manufacturerList'] =
          manufacturerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
