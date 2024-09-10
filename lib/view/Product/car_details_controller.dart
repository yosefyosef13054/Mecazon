import 'dart:convert';

import 'package:get/get.dart';
import 'package:mecazone/controller/tecdoc_service_controller.dart';
import 'package:mecazone/model/TecDoc/Request/request_get_car_details_model.dart';
import 'package:mecazone/model/TecDoc/Response/get_car_details_model.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/log.dart';

class  CarDetailsBindings  extends Bindings{
  @override
  void dependencies() {
      Get.put(CarDetailsController());
  }
}

class CarDetailsController extends GetxController{

  final vnIsShowLoader = false.obs;
  // var carDetails = CarList().obs;
  CarList? carDetails;
  late int carId;
  dynamic argsData = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  onClose() {

  }

  _init(){
    carId = argsData['carId'] ?? 0;
    callGetCarDetailsAPI();
  }

  /// : API CALL - GET CAR DETAILS API
  callGetCarDetailsAPI() async {
    RequestGetCarDetailsModel data = RequestGetCarDetailsModel(
      getVehicleByIds4: GetVehicleByIds4(
        lang: CommonWidget.commonSettings?.languageCode.toString(),
        provider: CommonWidget.commonSettings?.providerId,
        articleCountry: CommonWidget.commonSettings?.countryCode.toString(),
        countriesCarSelection: CommonWidget.commonSettings?.countryCode.toString(),
        country: CommonWidget.commonSettings?.countryCode.toString(),
        carIds: CarIds(
          array: [
            carId
          ],
        )
      ),
    );
    vnIsShowLoader.value = true;

    Log.debug("Car Details param = ${jsonEncode(data).toString()}");
    GetCarDetailsModel? response = await TecDocServiceController.getTecDocCarDetailsType(jsonEncode(data).toString());
    vnIsShowLoader.value = false;

    if (response != null && response.status == 200 && response.data!.carList!.isNotEmpty) {
      carDetails = response.data!.carList!.first;
      update();
    }
  }

}