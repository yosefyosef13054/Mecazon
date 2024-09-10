import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/controller/wishlist_service_controller.dart';
import 'package:mecazone/model/api_response.dart';
import 'package:mecazone/model/Wishlist/wishlist_product_data_model.dart';
import 'package:mecazone/model/Wishlist/wishlist_store_data_model.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class WishListBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(WishListController());
  }
}

class WishListController extends GetxController with GetSingleTickerProviderStateMixin {

  final vnIsShowLoader = false.obs;
  final lstWishlistStore = <WishListStoreList>[].obs;
  final lstWishlistProduct = <WishlistProductList>[].obs;
  late TabController tabController;
  final ScrollController storeScrollController = ScrollController();
  final ScrollController productScrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
    _init();
  }

  @override
  onClose() {
    tabController.dispose();
  }

  _init() {
    callGetWishlistProductListAPI(counter: 0);

    tabController.addListener(() {
      if (tabController.index == 0) {
        callGetWishlistProductListAPI(counter: lstWishlistProduct.length);
      } else {
        callGetWishlistStoreListAPI(counter: lstWishlistStore.length);
      }
    });

    productScrollController.addListener(() {
      if (productScrollController.position.maxScrollExtent ==
          productScrollController.position.pixels) {
        if (!vnIsShowLoader.value) {
          callGetWishlistProductListAPI(isFromScroll: true, counter: lstWishlistProduct.length);
        }
      }
    });

    storeScrollController.addListener(() {
      if (storeScrollController.position.maxScrollExtent ==
          storeScrollController.position.pixels) {
        if (!vnIsShowLoader.value) {
          callGetWishlistStoreListAPI(isFromScroll: true, counter: lstWishlistStore.length);
        }
      }
    });
  }

  /// : API CALL - GET WISH LIST PRODUCT LIST
  callGetWishlistProductListAPI({int? counter, bool isFromScroll = false}) async {
    vnIsShowLoader.value = true;
    String url = "$WISHLIST_PRODUCT$counter&userId=${CommonWidget.user!.id ?? "0"}";

    WishListProductDataModel? apiResponse = await WishlistServiceController.getWishlistProduct(url: url);
    vnIsShowLoader.value = false;

    if (apiResponse != null && apiResponse.success!) {
      if (!isFromScroll) {
        lstWishlistProduct.clear();
      }
      lstWishlistProduct.addAll(apiResponse.result!.wishlistProductList!);
      update();
    }
  }

  /// : API CALL - GET WISH LIST STORE LIST
  callGetWishlistStoreListAPI({int? counter, bool isFromScroll = false}) async {
    vnIsShowLoader.value = true;
    String url = "$WISHLIST_STORE$counter&userId=${CommonWidget.user!.id ?? "0"}";

    WishListStoreDataModel? apiResponse = await WishlistServiceController.getWishlistStore(url: url);
    vnIsShowLoader.value = false;

    if (apiResponse != null && apiResponse.success!) {
      if (!isFromScroll) {
        lstWishlistStore.clear();
      }
      lstWishlistStore.addAll(apiResponse.result!.wishlistStoreList!);
      update();
    }
  }

  /// : API CALL - REMOVE WISH LIST PRODUCT
  callRemoveProductWishListAPI({int index = 0}) async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    Map<String, String> param = {
      "productId": lstWishlistProduct[index].productId!.toString(),
      "userId": CommonWidget.user!.id!.toString(),
    };

    APIResponse? apiResponse =
    await WishlistServiceController.addProductWishList(param);

    if (apiResponse != null) {
      if (apiResponse.success!) {
        lstWishlistProduct.removeAt(index);
        lstWishlistProduct.refresh();
      } else {}
    }
  }

  /// : API CALL - REMOVE WISH LIST STORE
  callRemoveStoreWishListAPI({int index = 0}) async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    Map<String, String> param = {
      "storeId": lstWishlistStore[index].storeId!.toString(),
      "customerId": CommonWidget.user!.id!.toString(),
    };

    APIResponse? apiResponse = await WishlistServiceController.addStoreWishList(param);

    if (apiResponse != null) {
      if (apiResponse.success!) {
        lstWishlistStore.removeAt(index);
        lstWishlistStore.refresh();
      } else {}
    }
  }

}