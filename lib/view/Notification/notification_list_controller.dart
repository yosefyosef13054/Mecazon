import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/controller/notification_service_controller.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/model/Common/notification_data_model.dart';

class NotificationListBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NotificationListController());
  }
}

class NotificationListController extends GetxController{
  final vnIsShowLoader = false.obs;
  final lstNotification = <NotificationList>[].obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  onClose() {

  }

  _init(){
    callGetNotificationListAPI(counter: 0);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (!vnIsShowLoader.value) {
          callGetNotificationListAPI(counter: lstNotification.length, isFromScroll: true);
        }
      }
    });
  }

  /// : API CALL - GET ALL NOTIFICATION LIST API
  callGetNotificationListAPI({int counter = 0, bool isFromScroll = false}) async {
    vnIsShowLoader.value = true;

    // String url ="$NOTIFICATION_LIST$counter&userId=${CommonWidget.user!.id ?? "0"}";
    String url ="$NOTIFICATION_LIST?userId=${CommonWidget.user!.id ?? "0"}";
    NotificationDataModel? apiResponse = await NotificationServiceController.getNotificationList(url: url);

    vnIsShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success!) {
        if (!isFromScroll) {
          lstNotification.clear();
        }
        lstNotification.addAll(apiResponse.result!.notificationList!);
        update();
      } else {}
    }
  }

}