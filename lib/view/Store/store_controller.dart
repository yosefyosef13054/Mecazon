import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/controller/store_service_controller.dart';
import 'package:mecazone/controller/wishlist_service_controller.dart';
import 'package:mecazone/model/api_response.dart';
import 'package:mecazone/model/Store/store_list_data_model.dart';
import 'package:mecazone/utils/constants.dart';

class StoreBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(StoreController());
  }
}

class StoreController extends  GetxController{
  final vnIsShowLoader = false.obs;
  final lstStore = <StoreList>[].obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  onClose() {

  }

  _init() {
    callGetStoreListAPI(counter: 0);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (!vnIsShowLoader.value) {
          callGetStoreListAPI(counter: lstStore.length, isFromScroll: true);
        }
      }
    });
  }

  addToWishList(int index){
    lstStore[index].isWishListed = !lstStore[index].isWishListed!;
    lstStore.refresh();
    callAddStoreWishListAPI(index: index);
  }

  /// : API CALL - GET STORE LIST
  callGetStoreListAPI({int counter = 0, bool isFromScroll = false}) async {
    vnIsShowLoader.value = true;

    String url ="$STORE_LIST$counter&professionalId=${CommonWidget.user!.id ?? "0"}";
    StoreDataModel? apiResponse = await StoreServiceController.getStoreList(url: url);

    vnIsShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success!) {
        if (!isFromScroll) {
          lstStore.clear();
        }
        lstStore.addAll(apiResponse.result!.storeList!);
        update();
      } else {}
    }
  }

  /// : API CALL - ADD WISH LIST STORE
  callAddStoreWishListAPI({int index = 0}) async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    Map<String, String> param = {
      "storeId": lstStore[index].id!.toString(),
      "customerId": CommonWidget.user!.id!.toString(),
    };

    APIResponse? apiResponse = await WishlistServiceController.addStoreWishList(param);

    if (apiResponse != null) {
      if (apiResponse.success!) {
      } else {
        lstStore[index].isWishListed = !lstStore[index].isWishListed!;
        lstStore.refresh();
      }
    }
  }

}