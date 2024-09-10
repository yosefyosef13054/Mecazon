import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/controller/wishlist_service_controller.dart';
import 'package:mecazone/model/Store/store_details_data_model.dart';
import 'package:mecazone/controller/store_service_controller.dart';
import 'package:mecazone/model/api_response.dart';
import 'package:mecazone/model/Store/store_list_data_model.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class StoreDetailsBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(StoreDetailsController()) ;
  }
}

class StoreDetailsController extends GetxController{
  int storeId = 0;
  dynamic argsData = Get.arguments;

  final vnIsShowLoader = false.obs;
  final vnCurrentBannerIndex = 0.0.obs;
  final bannerList = <StoreManagementImagesView>[].obs;
  final lstStoreProducts = <StoreProducts>[].obs;

  var storeDetailsDataModel = StoreList().obs;
  final vnIsTabChange = true.obs, vnIsStoreWishListed = false.obs;
  final vnWishlistCount = 0.obs;
  String? storeMobileNo = "";

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  onClose() {

  }

  _init() {
    storeId = argsData['storeId'] ?? 0;
    update();
    callVisitStoreAPI();
    callGetStoreDetailsAPI();
  }

  /// : API CALL - GET STORE DETAILS
  callGetStoreDetailsAPI() async {
    vnIsShowLoader.value = true;

    String url = "$STORE_DETAILS${storeId.toString()}&userId=${CommonWidget.user!.id ?? "0"}";

    StoreDetailsDataModel? apiResponse = await StoreServiceController.getStoreDetailData(url: url);

    vnIsShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success!) {
        storeDetailsDataModel.value = apiResponse.result!.storeDetails!;
        vnIsStoreWishListed.value = apiResponse.result!.isWishlisted!;
        vnWishlistCount.value = storeDetailsDataModel.value.wishListCount ?? 0;

        if (storeDetailsDataModel.value.storeManagementImagesView!.isNotEmpty) {
          bannerList.addAll(storeDetailsDataModel.value.storeManagementImagesView!);
        }
        if (storeDetailsDataModel.value.storeManagementPhoneNumber!.isNotEmpty) {
          for (var element in storeDetailsDataModel.value.storeManagementPhoneNumber!) {
            storeMobileNo = storeMobileNo!.isEmpty
                ? element.phoneNumber!
                : "$storeMobileNo , ${element.phoneNumber!}";
          }
        }
        if (apiResponse.result!.storeProducts!.isNotEmpty) {
          lstStoreProducts.addAll(apiResponse.result!.storeProducts!);
        }
        // update();
      } else {}
    }
    update();
  }

  /// : API CALL - VISIT STORE - STORE COUNT INCREASE
  callVisitStoreAPI() async {
    vnIsShowLoader.value = true;
    String url = "$VISIT_STORE${CommonWidget.user!.id}&storeId=$storeId";

    APIResponse? apiResponse = await StoreServiceController.storeVisited(url: url);
    vnIsShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success!) {
      } else {}
    }
  }

  /// : API CALL - ADD WIH LIST STORE
  callAddStoreWishListAPI() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    Map<String, String> param = {
      "storeId": storeDetailsDataModel.value.id!.toString(),
      "customerId": CommonWidget.user!.id!.toString(),
    };

    APIResponse? apiResponse = await WishlistServiceController.addStoreWishList(param);

    if (apiResponse != null) {
      if (apiResponse.success!) {
        vnIsStoreWishListed.value = !vnIsStoreWishListed.value;
        if (vnIsStoreWishListed.value) {
          vnWishlistCount.value++;
        } else {
          vnWishlistCount.value--;
        }
        update();
      } else {}
    }
  }

}