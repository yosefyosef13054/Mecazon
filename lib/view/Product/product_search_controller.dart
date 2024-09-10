import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/controller/tecdoc_service_controller.dart';
import 'package:mecazone/model/TecDoc/Request/request_get_article_model.dart';
import 'package:mecazone/model/TecDoc/Response/get_article_model.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/log.dart';

class ProductSearchBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(ProductSearchController());
  }
}

class ProductSearchController extends GetxController{

  late TextEditingController searchOEMController,searchArticleNoController;
  late FocusNode fnSearch,fnArticle;
  final vnIsShowLoader = false.obs;
  var lstArticles = <ArticlesList>[].obs;

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
    fnSearch.dispose();
  }

  _init(){
    currentPage = 1;
    searchOEMController = TextEditingController();
    searchArticleNoController = TextEditingController();
    fnSearch = FocusNode();
    fnArticle = FocusNode();
    // DEMO OEM NUMBER : 82398550;
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
        searchQuery: searchOEMController.text.trim()
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
    }
    else {

    }
  }

}