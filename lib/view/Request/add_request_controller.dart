import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mecazone/controller/home_service_controller.dart';
import 'package:mecazone/controller/product_service_controller.dart';
import 'package:mecazone/controller/request_service_controller.dart';
import 'package:mecazone/model/Home/car_data_model.dart';
import 'package:mecazone/model/Product/model_type_data_model.dart';
import 'package:mecazone/model/api_response.dart';
import 'package:mecazone/model/country_data_model.dart';
import 'package:mecazone/model/Product/brand_data_model.dart';
import 'package:mecazone/model/Product/manufacturer_data_model.dart';
import 'package:mecazone/model/Product/model_data_model.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/log.dart';

class AddRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddRequestController());
  }
}

class AddRequestController extends GetxController {
  final formKey = GlobalKey<FormState>();

  late TextEditingController tecNameController,
      tecDescriptionController,
      tecBrandNameController,
      tecModelNameController,
      tecModelTypeNameController,
      tecManufacturerNameController,
      tecOeReferenceNoController,
      tecMobileNoController,
      tecYearController,
      tecBrandSearchController,
      tecModelSearchController,
      tecModelTypeSearchController,
      tecManufacturerSearchController,
      tecCarSearchController,
      tecCountrySearchController;

  late FocusNode fnName,
      fnDescription,
      fnBrandName,
      fnModelName,
      fnModelTypeName,
      fnManufacturer,
      fnCar,
      fnOeReferenceNo,
      fnMobileNo,
      fnYear,
      fnSearchCar,
      fnSearchBrand,
      fnSearchModel,
      fnSearchModelType,
      fnSearchManufacturer,
      fnSearchCountry;

  RxBool vnIsShowOtherBrand = false.obs;
  RxBool vnIsShowOtherModel = false.obs;
  RxBool vnIsShowOtherModelType = false.obs;
  RxBool vnIsShowOtherManufacturer = false.obs;
  RxBool vnIsShowLoader = false.obs;

  var lstCountry = <CountryData>[].obs;
  var selectedCountry = CountryData().obs;

  var lstBrand = <BrandList>[].obs;
  var selectedBrands = BrandList().obs;

  var lstModel = <ModelList>[].obs;
  var selectedModel = ModelList().obs;

  var lstModelType = <ModelTypeList>[].obs;
  var selectedModelType = ModelTypeList().obs;

  var lstCar = <CarList>[].obs;
  var selectedCar = CarList().obs;

  var lstManufacturer = <ManufacturerData>[].obs;
  var selectedManufacturer = ManufacturerData().obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  void onClose() {
    super.onClose();
    _close();
  }

  _init() {
    tecNameController = TextEditingController();
    tecDescriptionController = TextEditingController();
    tecBrandNameController = TextEditingController();
    tecModelNameController = TextEditingController();
    tecModelTypeNameController = TextEditingController();
    tecManufacturerNameController = TextEditingController();
    tecOeReferenceNoController = TextEditingController();
    tecMobileNoController = TextEditingController();
    tecBrandSearchController = TextEditingController();
    tecModelSearchController = TextEditingController();
    tecModelTypeSearchController = TextEditingController();
    tecManufacturerSearchController = TextEditingController();
    tecCarSearchController = TextEditingController();
    tecCountrySearchController = TextEditingController();
    tecYearController = TextEditingController(text: DateTime.now().year.toString());

    fnName = FocusNode();
    fnDescription = FocusNode();
    fnBrandName = FocusNode();
    fnModelName = FocusNode();
    fnModelTypeName = FocusNode();
    fnManufacturer = FocusNode();
    fnCar = FocusNode();
    fnOeReferenceNo = FocusNode();
    fnMobileNo = FocusNode();
    fnYear = FocusNode();
    fnSearchCar = FocusNode();
    fnSearchBrand = FocusNode();
    fnSearchModel = FocusNode();
    fnSearchModelType = FocusNode();
    fnSearchManufacturer = FocusNode();
    fnSearchCountry = FocusNode();

    selectedCountry = CountryData(countryName: "Algeria", countryId: 1, countryCode: "213", currencyPre: "DZ").obs;

    callGetCarListAPI();
  }

  _close() {
    tecNameController.dispose();
    tecDescriptionController.dispose();
    tecBrandNameController.dispose();
    tecModelNameController.dispose();
    tecModelTypeNameController.dispose();
    tecManufacturerNameController.dispose();
    tecOeReferenceNoController.dispose();
    tecMobileNoController.dispose();
    tecBrandSearchController.dispose();
    tecModelSearchController.dispose();
    tecModelTypeSearchController.dispose();
    tecManufacturerSearchController.dispose();
    tecCarSearchController.dispose();
    tecCountrySearchController.dispose();
    tecYearController.dispose();

    fnName.dispose();
    fnDescription.dispose();
    fnBrandName.dispose();
    fnModelName.dispose();
    fnModelTypeName.dispose();
    fnManufacturer.dispose();
    fnCar.dispose();
    fnOeReferenceNo.dispose();
    fnMobileNo.dispose();
    fnYear.dispose();
    fnSearchCar.dispose();
    fnSearchBrand.dispose();
    fnSearchModel.dispose();
    fnSearchModelType.dispose();
    fnSearchManufacturer.dispose();
    fnSearchCountry.dispose();
  }

  onChangeCar(){
    for (var element in lstBrand) {
      if(selectedCar.value.brandId == element.brandId){
        selectedBrands.value = element;
      }
    }
    callGetModelListAPI(brandId: selectedBrands.value.brandId.toString());
    update();
  }

  onChangeBrand(){
    if (selectedBrands.value.brandId != 0) {
      vnIsShowOtherBrand.value = false;
      selectedModel.value = ModelList();
      callGetModelListAPI(brandId: selectedBrands.value.brandId.toString());
    } else {
      vnIsShowOtherBrand.value = true;
    }
    update();
  }

  onChangeModel(){
    if (selectedModel.value.modelId != 0) {
      vnIsShowOtherModel.value = false;
      selectedModelType.value = ModelTypeList();
      callGetModelTypeListAPI(modelId: selectedModel.value.modelId.toString());
    } else {
      vnIsShowOtherModel.value = true;
    }
    update();
  }

  onChangeModelType(){
    if (selectedModelType.value.id != 0) {
      vnIsShowOtherModelType.value = false;
    } else {
      vnIsShowOtherModelType.value = true;
    }
    update();
  }

  callGetManufacturerListAPI() async {
    vnIsShowLoader.value = true;

    APIResponse? apiResponse = await ProductServiceController.getManufacturerList();
    vnIsShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success!) {
        lstManufacturer.clear();
        lstManufacturer.addAll(apiResponse.result!.manufacturerList!);
        if(lstManufacturer.isNotEmpty){
          selectedManufacturer.value = lstManufacturer.first;
          tecManufacturerNameController.text = lstManufacturer.first.mfrName ??"";
        }
        update();
      } else {}
    }

    lstManufacturer.add(ManufacturerData(id: 0, mfrName: "Others",mfrId: 0));
  }

  callGetBrandListAPI() async {
    vnIsShowLoader.value = true;
    Map<String, String> param = {
      'page': "0",//lstBrand.length.toString(),
      // 'search' : searchBrandController.text.trim()
    };
    BrandDataModel? apiResponse = await ProductServiceController.getBrandList(param);
    vnIsShowLoader.value = false;

    if (apiResponse != null && apiResponse.success == true) {
      if (apiResponse.result!.brandList!.isNotEmpty) {
        lstBrand.clear();
        lstBrand.addAll(apiResponse.result!.brandList!);

        if(lstCar.isNotEmpty){
          for (var element in lstBrand) {
            if(selectedCar.value.brandId == element.brandId){
              selectedBrands.value = element;
              tecBrandNameController.text = element.brandName ?? "";
            }
          }
        }
        else{
          selectedBrands.value = lstBrand.first;
          tecBrandNameController.text = lstBrand.first.brandName ?? "";
        }
        callGetModelListAPI(brandId: selectedBrands.value.brandId.toString());
        update();
      } else {}
    }

    lstBrand.add(BrandList(brandName: "Others",brandId: 0));
  }

  callGetModelListAPI({String? brandId}) async {
    vnIsShowLoader.value = true;
    Map<String, String> param = {'brandId': brandId ?? "0"};

    ModelDataModel? apiResponse = await ProductServiceController.getModelList(param);
    vnIsShowLoader.value = false;

    if (apiResponse != null && apiResponse.success == true) {
      if (apiResponse.result!.modelList!.isNotEmpty) {
        lstModel.clear();
        lstModel.addAll(apiResponse.result!.modelList!);

        if(lstCar.isNotEmpty){
          for (var element in lstModel) {
            if(selectedCar.value.modelId == element.modelId){
              selectedModel.value = element;
              tecModelNameController.text = element.modelName ?? "";
            }
          }
        }
        else{
          selectedModel.value = lstModel.first;
          tecModelNameController.text = lstModel.first.modelName ?? "";
        }
        update();

        callGetModelTypeListAPI(modelId: selectedModel.value.modelId.toString());
      } else {}
    }

    lstModel.add(ModelList(modelName: "Others",modelId: 0));
  }

  callGetModelTypeListAPI({String? modelId}) async {
    vnIsShowLoader.value = true;
    Map<String, String> param = {'modelId': modelId ?? "0"};

    ModelTypeDataModel? apiResponse = await ProductServiceController.getModelTypeList(param);
    vnIsShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success!) {
        lstModelType.clear();
        lstModelType.addAll(apiResponse.result!.modelTypeList!);
        if(lstCar.isNotEmpty){
          for (var element in lstModelType) {
            if(selectedCar.value.modelTypeId == element.id){
              selectedModelType.value = element;
              tecModelTypeNameController.text = element.typeName ?? "";
            }
          }
        }
        else{
          selectedModelType.value = lstModelType.first;
          tecModelTypeNameController.text = lstModelType.first.typeName ?? "";
        }

        if(lstModelType.isEmpty){
          lstModelType.add(ModelTypeList(id: 0, typeName: "Others"));
          selectedModelType.value = lstModelType.first;
          tecModelTypeNameController.text = lstModelType.first.typeName ?? "";
          update();
        }

        update();
      } else {}
    }
  }

  callGetCarListAPI() async {
    vnIsShowLoader.value = true;
    Map<String, String> param = {
      'UserId': CommonWidget.user?.id.toString() ?? "0"
    };

    CarDataModel? apiResponse = await HomeServiceController.getCarList(param);
    vnIsShowLoader.value = false;

    if (apiResponse != null && apiResponse.success! == true) {
      lstCar.clear();
      lstCar.addAll(apiResponse.result!.carList!);
      if(lstCar.isNotEmpty){
        selectedCar.value = lstCar.first;
      }
    }
    update();
    await callGetBrandListAPI();
    await callGetManufacturerListAPI();
  }

  callAddRequestAPI(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (formKey.currentState!.validate()) {
      Map<String, String> param = {
        "Id": "0",
        "ProductName": tecNameController.text.trim(),
        "BrandId": selectedBrands.value.brandId !=0 ? selectedBrands.value.brandId.toString() : "",
        "BrandName": selectedBrands.value.brandName !="" ? tecBrandNameController.text.trim() : "",
        "ModelId": selectedModel.value.modelId !=0 ? selectedModel.value.modelId.toString() : "",
        "ModelName": selectedModel.value.modelName !="" ? tecModelNameController.text.trim() : "",
        "ModelTypeId":selectedModelType.value.id !=0 ?selectedModelType.value.id.toString() : "0",
        "MfrId": selectedManufacturer.value.mfrId !=0 ? selectedManufacturer.value.mfrId.toString() : "0",
        "MfrName": selectedManufacturer.value.mfrName !="" ? tecManufacturerNameController.text.trim() : "",
        "Year": tecYearController.text.trim(),
        "Description": tecDescriptionController.text.trim(),
        "PhoneNumber": tecMobileNoController.text.trim(),
        "Oenumber": tecOeReferenceNoController.text.trim(),
        "CustomerId": CommonWidget.user?.id.toString() ?? "0"
      };

      Log.debug("Add Request param = ${jsonEncode(param).toString()}");
      vnIsShowLoader.value = true;
      APIResponse? apiResponse = await RequestServiceController.addRequest(param);
      vnIsShowLoader.value = false;

      if (apiResponse != null && apiResponse.success == true) {
        Navigator.pop(Get.context!, true);
      }
    }
  }
}
