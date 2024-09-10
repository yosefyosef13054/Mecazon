import 'dart:convert';
import 'package:mecazone/model/Product/assembly_group_data_model.dart';
import 'package:mecazone/model/Product/model_data_model.dart';
import 'package:mecazone/helper/api.dart';
import 'package:mecazone/helper/alert_helper.dart';
import 'package:mecazone/model/Product/model_type_data_model.dart';
import 'package:mecazone/model/Product/sub_category_data_model.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/model/api_response.dart';
import 'package:mecazone/model/Product/brand_data_model.dart';
import 'package:mecazone/model/Product/category_data_model.dart';

class ProductServiceController {
  static Future<BrandDataModel?> getBrandList(Map<String, String> params) async {
    return API.call(BRAND_LIST, MethodType.POST, body: params,formData: true).then((response) {
      Log.debug("getBrandList RESPONSE : $response");

      BrandDataModel? apiResponse =
          BrandDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }

      if (apiResponse.messages != ""){
        AlertHelper.showToast(apiResponse.messages ?? "");
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<AssemblyGroupDataModel?> getAssemblyGroupList() async {
    return API.call(ASSEMBLY_GROUP_LIST, MethodType.POST).then((response) {
      Log.debug("getAssemblyGroupList RESPONSE : $response");

      AssemblyGroupDataModel? apiResponse = AssemblyGroupDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }

      if (apiResponse.messages != "") {
        AlertHelper.showToast(apiResponse.messages ?? "");
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<CategoryDataModel?> getCategoryList(Map<String, String> params) async {
    return API.callMultipartFormData(CATEGORY_LIST, MethodType.POST,body: params).then((response) {
      Log.debug("getCategoryList RESPONSE : $response");

      CategoryDataModel? apiResponse = CategoryDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }

      if (apiResponse.messages != ""){
        AlertHelper.showToast(apiResponse.messages ?? "");
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<SubCategoryDataModel?> getSubCategoryList(Map<String, String> params) async {
    return API.callMultipartFormData(SUBCATEGORY_LIST, MethodType.POST,body: params).then((response) {
      Log.debug("getSubCategoryList RESPONSE : $response");

      SubCategoryDataModel? apiResponse = SubCategoryDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }

      if (apiResponse.messages != ""){
        AlertHelper.showToast(apiResponse.messages ?? "");
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<ModelDataModel?> getModelList(Map<String, String> params) async {
    return API.callMultipartFormData(MODEL_LIST, MethodType.POST, body: params).then((response) {
      Log.debug("getModelList RESPONSE : $response");

      ModelDataModel? apiResponse = ModelDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }

      if (apiResponse.messages != "") {
        AlertHelper.showToast(apiResponse.messages ?? "");
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<ModelTypeDataModel?> getModelTypeList(Map<String, String> params) async {
    return API.callMultipartFormData(MODEL_TYPE_LIST, MethodType.POST, body: params).then((response) {
      Log.debug("getModelTypeList RESPONSE : $response");

      ModelTypeDataModel? apiResponse = ModelTypeDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }

      if (apiResponse.messages != "") {
        AlertHelper.showToast(apiResponse.messages ?? "");
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<APIResponse?> getManufacturerList() async {
    return API.callApi(MANUFACTURER_LIST, MethodType.GET).then((response) {
      Log.debug("getManufacturerList RESPONSE : $response");
      APIResponse? apiResponse = APIResponse.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }
      if (apiResponse.message != "") {
        AlertHelper.showToast(apiResponse.message!);
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }
}
