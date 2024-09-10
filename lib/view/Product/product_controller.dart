import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/controller/tecdoc_service_controller.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/model/TecDoc/Request/request_get_article_model.dart';
import 'package:mecazone/model/TecDoc/Response/get_article_model.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/log.dart';

class ProductBindings extends Bindings{
  @override
  void dependencies() {
      Get.put(ProductController());
  }
}

class ProductController  extends GetxController{

  final vnIsShowLoader = false.obs;
  var assemblyGroupNodeId = 0;
  var title = "";
  var lstArticles = <ArticlesList>[].obs;
  dynamic argsData = Get.arguments;

  int totalPage = 0;
  int currentPage = 0;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  onClose() {

  }

  _init(){
    assemblyGroupNodeId = argsData['assemblyGroupNodeId']?? 0;
    title = argsData['title']?? "product".translate();

    callGetArticlesListAPI(page:1, isFromScroll: false);

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (!vnIsShowLoader.value) {
          callGetArticlesListAPI(page: currentPage, isFromScroll: true);
        }
      }
    });
  }

  /// : API CALL - GET ARTICLES LIST API
  callGetArticlesListAPI({int? page, String? searchQuery, int? searchType, bool isFromScroll = false}) async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    RequestGetArticleModel data = RequestGetArticleModel(
        getArticles: GetArticles(
            articleCountry: CommonWidget.commonSettings?.countryCode.toString(),
            lang: CommonWidget.commonSettings?.languageCode.toString(),
            provider: CommonWidget.commonSettings?.providerId,
            includeImages: true,
            page: page ?? 1,
            perPage: 15,
            searchType: searchType ?? 1,
            assemblyGroupNodeIds:assemblyGroupNodeId,
            // searchQuery: searchQuery
        )
    );

    vnIsShowLoader(true);
    Log.debug("Article param = ${jsonEncode(data).toString()}");
    GetArticleModel? response = await TecDocServiceController.getTecDocArticleData(jsonEncode(data).toString());
    vnIsShowLoader(false);

    if (response!.articleList!.isNotEmpty) {
      currentPage++;
      totalPage =  response.maxAllowedPage ?? 1;
      if (!isFromScroll) {
        lstArticles.clear();
      }
      lstArticles.addAll(response.articleList!);
      update();
    } else {

    }
  }


}