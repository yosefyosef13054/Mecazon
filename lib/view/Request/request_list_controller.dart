import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/controller/product_service_controller.dart';
import 'package:mecazone/controller/request_service_controller.dart';
import 'package:mecazone/model/Product/brand_data_model.dart';
import 'package:mecazone/model/api_response.dart';
import 'package:mecazone/model/Request/request_data_model.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/utils/log.dart';

class RequestListBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(RequestListController());
  }
}

class RequestListController extends GetxController with GetTickerProviderStateMixin {

  final vnIsShowLoader = false.obs;
  final lstCurrentRequest = <ProductRequestList>[].obs;
  final lstPastRequest = <ProductRequestList>[].obs;

  late TabController tabController;
  final ScrollController currentScrollController = ScrollController();
  final ScrollController pastScrollController = ScrollController();

  final isRequestLimitOver = true.obs;
  RxInt totalRequestLimit = 0.obs;

  var lstBrand = <BrandList>[].obs;
  String selectedBrandIds = "";

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
    callGetRequestListAPI(isCurrent: true, counter: 0);
    callGetBrandListAPI();

    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(() async {
      if (tabController.index == 0) {
        await onFilterApply();
        callGetRequestListAPI(isCurrent: true, counter: lstCurrentRequest.length);
      } else {
        await onFilterApply();
        callGetRequestListAPI(isCurrent: false, counter: lstPastRequest.length);
      }
    });

    currentScrollController.addListener(() async {
      if (currentScrollController.position.maxScrollExtent == currentScrollController.position.pixels) {
        if (!vnIsShowLoader.value) {
          await onFilterApply();
          callGetRequestListAPI(
              isCurrent: true,
              isFromScroll: true,
              counter: lstCurrentRequest.length
          );
        }
      }
    });

    pastScrollController.addListener(() async {
      if (pastScrollController.position.maxScrollExtent == pastScrollController.position.pixels) {
        if (!vnIsShowLoader.value) {
          await onFilterApply();
          callGetRequestListAPI(
              isCurrent: false,
              isFromScroll: true,
              counter: lstPastRequest.length
          );
        }
      }
    });
  }

  onCancelAll(){
    selectedBrandIds = "";
    for (var element in lstBrand) {
      if(element.isSelected!.value){
        element.isSelected!.value = false;
      }
    }
    callGetRequestListAPI(counter: 0,brandId: "",isCurrent: tabController.index == 0 ? true : false,isFromScroll: false);
    update();
  }

  onFilterApply({bool isFromFilter = false}) async{
    selectedBrandIds = "";
    for (var element in lstBrand) {
        if(element.isSelected!.value){
          selectedBrandIds = "$selectedBrandIds${element.brandId},";
        }
    }
    if(selectedBrandIds.isNotEmpty){
      selectedBrandIds = selectedBrandIds.substring(0, selectedBrandIds.length - 1);
    }
    if(isFromFilter){
      callGetRequestListAPI(counter: 0,brandId: selectedBrandIds,isCurrent: tabController.index == 0 ? true : false,isFromScroll: false);
    }
  }

  /// : API CALL - GET REQUEST LIST
  callGetRequestListAPI(
      {int? counter,
        bool isFromScroll = false,
        bool isCurrent = false,
        String brandId = ""}) async {
    vnIsShowLoader.value = true;
    String url = "$REQUEST_LIST$counter&userID=${CommonWidget.user!.id ?? "0"}&status=${isCurrent ? "0" : "1"}&brandId=$brandId";
    Log.debug("Request List Param = $url");

    ProductRequestDataModel? apiResponse = await RequestServiceController.getData(url: url);
    vnIsShowLoader.value = false;

    if (apiResponse != null && apiResponse.success!) {
      isRequestLimitOver.value = apiResponse.result!.requestLimit ?? true;

      totalRequestLimit.value = apiResponse.result!.limitNumber ?? 0;
      refresh();
      if (!isFromScroll && isCurrent) {
        lstCurrentRequest.clear();
      }
      if (!isFromScroll && !isCurrent) {
        lstPastRequest.clear();
      }
      if (isCurrent) {
        lstCurrentRequest.addAll(apiResponse.result!.productRequestList!);
      }
      else {
        lstPastRequest.addAll(apiResponse.result!.productRequestList!);
      }
    }
    update();
  }

  /// : API CALL - DELETE REQUEST PRODUCT
  callDeleteRequestAPI({int index = 0}) async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    Map<String, String> param = {
      "requestId": lstCurrentRequest[index].id!.toString(),
      "userId": CommonWidget.user!.id!.toString(),
    };

    APIResponse? apiResponse = await RequestServiceController.deleteRequest(param);

    if (apiResponse != null && apiResponse.success!) {
      lstCurrentRequest.removeAt(index);
      lstCurrentRequest.refresh();
      update();
    }
  }

  /// : API CALL - GET BRAND LIST
  Future<bool>? callGetBrandListAPI() async {
    vnIsShowLoader.value = true;
    Map<String, String> param = {
      'page': "0",//lstBrand.length.toString(),
      // 'search' : searchBrandController.text.trim()
    };
    BrandDataModel? apiResponse = await ProductServiceController.getBrandList(param);
    vnIsShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success!) {
        lstBrand.clear();
        lstBrand.addAll(apiResponse.result!.brandList!);
        // lstBrand.add(BrandList(brandId: 0, brandName: "Others",isSelected: false.obs));
        update();
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

}