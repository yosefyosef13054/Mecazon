import 'package:get/get.dart';

import 'package:mecazone/controller/product_service_controller.dart';
import 'package:mecazone/model/Product/brand_data_model.dart';

class BrandBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(BrandController());
  }
}

class BrandController extends GetxController{
  final vnIsShowLoader = false.obs;
  final lstBrand = <BrandList>[].obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  onClose() {

  }

  _init() {
    callGetBrandListAPI();
  }

  /// : CALL GET BRAND LIST API
  callGetBrandListAPI() async {
    vnIsShowLoader.value = true;

    Map<String, String> param = {
      'page': "0",//lstBrand.length.toString(),
      // 'search' : searchBrandController.text.trim()
    };
    BrandDataModel? apiResponse = await ProductServiceController.getBrandList(param);
    vnIsShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success!) {
        lstBrand.addAll(apiResponse.result!.brandList!);
        update();
      } else {}
    }
  }

}