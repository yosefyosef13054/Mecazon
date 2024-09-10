import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:mecazone/controller/cms_service_controller.dart';
import 'package:mecazone/model/api_response.dart';
import 'package:mecazone/utils/constants.dart';

class CMSBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(CMSController());
  }
}

class CMSController extends GetxController{

  // About us - 1099
  // Contact Us - 1100
  // Privacy Policy -1101
  // Rate the app -1102

  late String? titleName, cmsTypeId ;
  late InAppWebViewController webViewController ;
  dynamic argsData = Get.arguments;

  final isShowLoader = false.obs;
  final htmlContents = "".obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  onClose() {

  }

  _init(){
    titleName = argsData['titleName'] ?? "";
    cmsTypeId = argsData['cmsTypeId'] ?? "1099";

    update();
    callCMSDataAPI();
  }

  /// : CALL GET  CMS DATA API
  callCMSDataAPI() async {
    isShowLoader.value = true;
    String url = CMS_DATA + cmsTypeId!;

    APIResponse? apiResponse = await CMSServiceController.getCMSData(url: url);
    isShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success! == true && apiResponse.result!.contentDetail!.content!.isNotEmpty) {
        htmlContents.value  =
            "<html><head><style>body {background-color: #FFFFFF; }</style></head><body>${apiResponse.result!.contentDetail!.content ?? ""}</html></body>"; // font-size:100px
        _loadHtmlData(htmlContents.value);
      }
    }
  }

  void _loadHtmlData(String htmlData) async {
    await webViewController.loadData(data: htmlData, mimeType: 'text/html', encoding: 'UTF-8');
    update();
  }

}