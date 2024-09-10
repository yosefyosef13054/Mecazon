import 'dart:convert';
import 'package:mecazone/model/Request/request_details_data_model.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/helper/api.dart';
import 'package:mecazone/helper/alert_helper.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/model/api_response.dart';
import 'package:mecazone/model/Request/request_data_model.dart';

class RequestServiceController {
  static Future<APIResponse?> addRequest(Map<String, String> params) async {
    return API.callMultipartFormData(ADD_REQUEST, MethodType.POST, body: params).then((response) {
      final apiResponse = APIResponse.fromJson(jsonDecode(response));
      if (apiResponse.success == true && apiResponse.message != "") {
        AlertHelper.showToast(apiResponse.message ?? "");
        return apiResponse;
      }
      if (apiResponse.message != "") {
        AlertHelper.showToast(apiResponse.message ?? "");
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<APIResponse?> editRequest(Map<String, String> params) async {
    return API.callMultipartFormData(EDIT_REQUEST, MethodType.POST, body: params).then((response) {
      Log.debug("editRequest RESPONSE : $response");
      APIResponse? apiResponse = APIResponse.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        if (apiResponse.message != "") AlertHelper.showToast(apiResponse.message ?? "");
        return apiResponse;
      }
      if (apiResponse.message != "") AlertHelper.showToast(apiResponse.message ?? "");
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

  static Future<APIResponse?> deleteRequest(Map<String, String> params) async {
    return API.call(DELETE_REQUEST, MethodType.POST, body: params, formData: true).then((response) {
      Log.debug("deleteRequest RESPONSE : $response");
      final apiResponse = APIResponse.fromJson(jsonDecode(response));
      if (apiResponse.success == true && apiResponse.message != "") {
        AlertHelper.showToast(apiResponse.message!);
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

  static Future<ProductRequestDataModel?> getData({String? url}) async {
    return API.callApi(url!, MethodType.GET).then((response) {
      Log.debug("getRequestList RESPONSE : $response");
      ProductRequestDataModel? apiResponse = ProductRequestDataModel.fromJson(jsonDecode(response));
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

  static Future<RequestDetailsDataModel?> getRequestDetailData({String? url}) async {
    return API.callApi(url!, MethodType.GET).then((response) {
      RequestDetailsDataModel? apiResponse = RequestDetailsDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }
      if (apiResponse.messages != "") AlertHelper.showToast(apiResponse.messages!);
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }
}
