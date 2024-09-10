import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/controller/product_service_controller.dart';
import 'package:mecazone/model/Product/category_data_model.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/view/Category/subcategory_screen.dart';
import 'package:mecazone/view/Product/product_screen.dart';

class CategoryBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(CategoryController());
  }
}

class CategoryController extends  GetxController{
  int assemblyId  = 0;
  dynamic argsData = Get.arguments;

  final vnIsShowLoader = false.obs;
  final lstCategory = <CategoryList>[].obs;
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
    assemblyId = argsData['assemblyId']?? 0;
    callGetCategoryListAPI(counter: 0);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (!vnIsShowLoader.value) {
          callGetCategoryListAPI(counter: lstCategory.length, isFromScroll: true);
        }
      }
    });
  }

  onClickCategory(int index){
    if(lstCategory[index].hasChild == true){
      Get.toNamed(
          SubCategoryListScreen.route,
          arguments: {
            'categoryId': lstCategory[index].id,
            'title': lstCategory[index].categoryName
          },
          preventDuplicates: false
      );
    }
    else{
      Get.toNamed(
          ProductScreen.route,
          arguments: {
            'assemblyGroupNodeId' : lstCategory[index].assebmlyGroupNodeId,
            'title' : lstCategory[index].categoryName,
          }
      );
    }
  }

  callGetCategoryListAPI({int counter = 0, bool isFromScroll = false}) async {
    try{
      vnIsShowLoader(true);
      Map<String, String> param = {
        'assemblyGroupId': assemblyId.toString(),
        'pageId':counter.toString(),
      };
      Log.debug("Request Param : $param");
      CategoryDataModel? apiResponse = await ProductServiceController.getCategoryList(param);
      vnIsShowLoader(false);
      if (apiResponse != null && apiResponse.success!) {
        if (!isFromScroll) {
          lstCategory.clear();
        }
        lstCategory.addAll(apiResponse.result!.categoryList!);
      }
      update();
    }catch(e){
      Log.debug("Error : $e");
    }

  }
}