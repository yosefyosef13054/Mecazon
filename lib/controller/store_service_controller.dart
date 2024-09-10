import 'dart:convert';
import 'dart:io';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/helper/api.dart';
import 'package:mecazone/helper/alert_helper.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/model/api_response.dart';
import 'package:mecazone/model/Common/municipality_data_model.dart';
import 'package:mecazone/model/Common/province_data_model.dart';
import 'package:mecazone/model/Store/store_details_data_model.dart';
import 'package:mecazone/model/Store/store_list_data_model.dart';

class StoreServiceController {
  static Future<ProvinceDataModel?> getProvinceData() async {
    return API.callApi(PROVINCE_LIST, MethodType.GET).then((response) {
      Log.debug("getProvinceData RESPONSE : $response");
      ProvinceDataModel? apiResponse = ProvinceDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }
      if (apiResponse.messages != "") {
        AlertHelper.showToast(apiResponse.messages!);
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<MunicipalityDataModel?> getMunicipalityData({String? url}) async {
    return API.callApi(url!, MethodType.GET).then((response) {
      Log.debug("getMunicipalityData RESPONSE : $response");
      MunicipalityDataModel? apiResponse = MunicipalityDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }
      if (apiResponse.messages != "") {
        AlertHelper.showToast(apiResponse.messages!);
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<APIResponse?> addEditStore({String? url,Map<String, String>? body,Map<String, List<File>>? fileBody}) async {
    return API.callPostMultipleImageWithArray(url!, fileBody: fileBody, body: body).then((response) {
      Log.debug("STORE RESPONSE : $response");
      APIResponse? apiResponse = APIResponse.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        if (apiResponse.message != "") {
          AlertHelper.showToast(apiResponse.message!);
        }
        return apiResponse;
      }
      if (apiResponse.message  != "") {
        AlertHelper.showToast(apiResponse.message!);
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<StoreDetailsDataModel?> getStoreDetailData({String? url}) async {
    return API.callApi(url!, MethodType.GET).then((response) {
      Log.debug("getStoreDetailData RESPONSE : $response");
      StoreDetailsDataModel? apiResponse = StoreDetailsDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success !) {
        return apiResponse;
      }
      if (apiResponse.messages  != "") {
        AlertHelper.showToast(apiResponse.messages!);
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<StoreDataModel?> getStoreList({String? url}) async {
    return API.callApi(url!, MethodType.GET).then((response) {
      Log.debug("getStoreList RESPONSE : $response");
      StoreDataModel? apiResponse = StoreDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<APIResponse?> deleteStoreImageData(Map<String, String> params) async {
    return API.call(DELETE_STORE_IMAGE, MethodType.POST, body: params, formData: true).then((response) {
      Log.debug("deleteStoreImageData RESPONSE : $response");
      APIResponse? apiResponse = APIResponse.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }
      if (apiResponse.message != "") {
        AlertHelper.showToast(apiResponse.message!);
      }
      return null;
    }).catchError((onError) {
      return null;
    });
  }

  static Future<APIResponse?> storeVisited({String? url}) async {
    return API.callApi(url!, MethodType.GET).then((response) {
      Log.debug("storeVisited RESPONSE : $response");
      APIResponse? apiResponse = APIResponse.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }
      // if (apiResponse.message != "") AlertHelper.showToast(apiResponse.message!);
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }
}
