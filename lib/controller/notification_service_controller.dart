import 'dart:convert';
import 'package:mecazone/model/Common/notification_data_model.dart';
import 'package:mecazone/helper/api.dart';
import 'package:mecazone/utils/log.dart';

class NotificationServiceController {

  static Future<NotificationDataModel?> getNotificationList({String? url}) async {
    return API.callApi(url!, MethodType.GET).then((response) {
      Log.debug("getNotificationList RESPONSE : $response");
      NotificationDataModel? apiResponse = NotificationDataModel.fromJson(jsonDecode(response));
      if (apiResponse.success!) {
        return apiResponse;
      }
      return null;
    }).catchError((onError) {
      Log.error("ERROR $onError");
      return null;
    });
  }

}