import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/controller/product_service_controller.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/model/Product/sub_category_data_model.dart';
import 'package:mecazone/view/Category/subcategory_screen.dart';
import 'package:mecazone/view/Product/product_screen.dart';

class SubCategoryBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(SubCategoryController());
  }
}

class SubCategoryController extends GetxController{
  int categoryId  = 0;
  var title = "subCategory".translate();
  dynamic argsData = Get.arguments;

  final vnIsShowLoader = false.obs;
  final lstSubCategory = <SubCategoryList>[].obs;
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
    categoryId = argsData['categoryId']?? 0;
    title = argsData['title']?? "subCategory".translate();
    callGetSubCategoryListAPI(counter: 0);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (!vnIsShowLoader.value) {
          callGetSubCategoryListAPI(counter: lstSubCategory.length, isFromScroll: true);
        }
      }
    });
  }

  onClickSubCategory(int index){
    if(lstSubCategory[index].hasChild == true){
      Get.toNamed(
          SubCategoryListScreen.route,
          arguments: {
            'categoryId': lstSubCategory[index].id,
            'title': lstSubCategory[index].categoryName
          },
          preventDuplicates: false
      );
    }
    else{
      Get.toNamed(
          ProductScreen.route,
          arguments: {
            'assemblyGroupNodeId' : lstSubCategory[index].assebmlyGroupNodeId,
            'title' : lstSubCategory[index].categoryName,
          }
      );
    }
  }

  callGetSubCategoryListAPI({int counter = 0, bool isFromScroll = false}) async {
    vnIsShowLoader(true);
    Map<String, String> param = {'categoryId': categoryId.toString()};
    SubCategoryDataModel? apiResponse = await ProductServiceController.getSubCategoryList(param);
    vnIsShowLoader(false);

    if (apiResponse != null && apiResponse.success!) {
      if (!isFromScroll) {
        lstSubCategory.clear();
      }
      lstSubCategory.addAll(apiResponse.subcategoryResult!.subCategoryList!);
    }
    update();
  }

}