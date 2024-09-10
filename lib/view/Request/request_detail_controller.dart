import 'package:get/get.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/controller/request_service_controller.dart';
import 'package:mecazone/model/Request/request_details_data_model.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class RequestDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RequestDetailController());
  }
}

class RequestDetailController extends GetxController {
  RequestDetailsDataModel? requestDetailsDataModel;
  RxBool vnIsShowLoader = false.obs;
  late final int? requestId;

  String? storeMobileNo = "";

  @override
  void onInit() {
    super.onInit();
    requestId = Get.arguments;
    _callGetRequestDetailsAPI();
  }

  _callGetRequestDetailsAPI() async {
    vnIsShowLoader.value = true;

    String url = "$REQUEST_DETAILS${requestId.toString()}&userId=${CommonWidget.user!.id ?? "0"}";
    Log.debug(url);

    RequestDetailsDataModel? apiResponse = await RequestServiceController.getRequestDetailData(url: url);

    vnIsShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success!) {
        requestDetailsDataModel = apiResponse;
      } else {}
    }
    update();
  }
}
