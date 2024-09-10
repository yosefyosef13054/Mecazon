import 'dart:convert';
import 'package:mecazone/model/Home/car_data_model.dart';
import 'package:mecazone/model/Home/home_data_model.dart';
import 'package:mecazone/helper/api.dart';
import 'package:mecazone/helper/alert_helper.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/model/api_response.dart';

class HomeServiceController {

  static Future<HomeDataModel?> getHomeDataList(Map<String, String> params) async {
    return API.callMultipartFormData(HOME_PAGE_LIST, MethodType.POST, body: params).then((response) {
      Log.debug("getHomeDataList RESPONSE : $response");

      HomeDataModel? apiResponse = HomeDataModel.fromJson(jsonDecode(response));
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

  static Future<APIResponse?> addNewCar(Map<String, String> params) async {

    return API.callMultipartFormData(ADD_CAR, MethodType.POST, body: params).then((response) {
      Log.debug("getAddNewCar RESPONSE : $response");

      APIResponse? apiResponse = APIResponse.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
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

  static Future<APIResponse?> deleteCar(Map<String, String> params) async {
    return API
        .callMultipartFormData(DELETE_CAR, MethodType.POST, body: params)
        .then((response) {
      Log.debug("removeCar RESPONSE : $response");

      APIResponse? apiResponse = APIResponse.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
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

  static Future<CarDataModel?> getCarList(Map<String, String> params) async {
    return API.callMultipartFormData(CAR_LIST, MethodType.POST, body: params).then((response) {
      Log.debug("getCarList RESPONSE : $response");

      CarDataModel? apiResponse = CarDataModel.fromJson(jsonDecode(response));
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

}
