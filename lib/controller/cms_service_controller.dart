import 'dart:convert';
import 'package:mecazone/helper/api.dart';
import 'package:mecazone/helper/alert_helper.dart';
import 'package:mecazone/model/Common/settings_data_model.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/model/api_response.dart';

class CMSServiceController {
  static Future<APIResponse?> getCMSData({String? url}) async {
    return API.callApi(url!, MethodType.GET).then((response) {
      Log.debug("getCMSData RESPONSE : $response");
      APIResponse? apiResponse = APIResponse.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        // if (apiResponse.message != "") AlertHelper.showToast(apiResponse.message!);
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

  static Future<APIResponse?> getCountryData() async {
    return API.callApi(COUNTRY_LIST, MethodType.GET).then((response) {
      Log.debug("getCountryData RESPONSE : $response");
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

  static Future<SettingsDataModel?> getSettingsData() async {
    return API.callApi(SETTINGS, MethodType.GET).then((response) {
      Log.debug("getSettingsData RESPONSE : $response");
      SettingsDataModel? apiResponse = SettingsDataModel.fromJson(jsonDecode(response));
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
}
