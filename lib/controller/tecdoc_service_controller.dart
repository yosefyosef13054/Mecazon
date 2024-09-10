import 'dart:convert';
import 'package:mecazone/model/TecDoc/Response/get_article_model.dart';
import 'package:mecazone/model/TecDoc/Response/get_car_data.dart';
import 'package:mecazone/model/TecDoc/Response/get_car_details_model.dart';
import 'package:mecazone/model/TecDoc/Response/get_car_model.dart';
import 'package:mecazone/model/TecDoc/Response/get_car_model_type.dart';
import 'package:mecazone/model/TecDoc/Response/get_category_data_model.dart';
import 'package:mecazone/helper/api.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/model/TecDoc/Response/get_brand_data_model.dart';

class TecDocServiceController{

  static Future<GetBrandModel?> getTecDocBrands(String params) async {
    return API.callTecDocApi(MethodType.POST, body: params).then((response) {
      Log.debug("getBrands RESPONSE : $response");
      GetBrandModel? apiResponse = GetBrandModel.fromJson(jsonDecode(response));
      if (apiResponse.data!.brandList!.isNotEmpty) {
        return apiResponse;
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<GetCategoryModel?> getTecDocCategory(String params) async {
    return API.callTecDocApi(MethodType.POST, body: params).then((response) {
      Log.debug("getTecDocCategory RESPONSE : $response");
      GetCategoryModel? apiResponse = GetCategoryModel.fromJson(jsonDecode(response));
      if (apiResponse.data!.categoryList!.isNotEmpty) {
        return apiResponse;
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<GetCarModel?> getTecDocCarModel(String params) async {
    return API.callTecDocApi(MethodType.POST, body: params).then((response) {
      Log.debug("getTecDocCarModel RESPONSE : $response");
      GetCarModel? apiResponse = GetCarModel.fromJson(jsonDecode(response));
      if (apiResponse.data!.modelList!.isNotEmpty) {
        return apiResponse;
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<GetCarModelType?> getTecDocCarModelType(String params) async {
    return API.callTecDocApi(MethodType.POST, body: params).then((response) {
      Log.debug("getTecDocCarModelType RESPONSE : $response");
      GetCarModelType? apiResponse = GetCarModelType.fromJson(jsonDecode(response));
      if (apiResponse.data!.modelTypeList!.isNotEmpty) {
        return apiResponse;
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<GetCarDetailsModel?> getTecDocCarDetailsType(String params) async {
    return API.callTecDocApi(MethodType.POST, body: params).then((response) {
      Log.debug("getTecDocCarModelType RESPONSE : $response");
      GetCarDetailsModel? apiResponse = GetCarDetailsModel.fromJson(jsonDecode(response));
      if (apiResponse.data!.carList!.isNotEmpty) {
        return apiResponse;
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<GetArticleModel?> getTecDocArticleData(String params) async {
    return API.callTecDocApi(MethodType.POST, body: params).then((response) {
      Log.debug("getTecDocArticleData RESPONSE : $response");
      GetArticleModel? apiResponse = GetArticleModel.fromJson(jsonDecode(response));
      if (apiResponse.articleList!.isNotEmpty) {
        return apiResponse;
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<GetCarData?> getTecDocCarData(String params) async {
    return API.callTecDocApi(MethodType.POST, body: params).then((response) {
      Log.debug("getTecDocCarData RESPONSE : $response");
      GetCarData? apiResponse = GetCarData.fromJson(jsonDecode(response));
      if (apiResponse.carList!.isNotEmpty) {
        return apiResponse;
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }
}