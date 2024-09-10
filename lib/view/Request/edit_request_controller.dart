import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/controller/product_service_controller.dart';
import 'package:mecazone/controller/request_service_controller.dart';
import 'package:mecazone/model/api_response.dart';
import 'package:mecazone/model/country_data_model.dart';
import 'package:mecazone/model/Product/brand_data_model.dart';
import 'package:mecazone/model/Product/manufacturer_data_model.dart';
import 'package:mecazone/model/Product/model_type_data_model.dart';
import 'package:mecazone/model/Product/model_data_model.dart';
import 'package:mecazone/model/Request/request_data_model.dart';
import 'package:mecazone/utils/common_widget.dart';

class EditRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditRequestController());
  }
}

class EditRequestController extends GetxController {
  final formKey = GlobalKey<FormState>();

  late ProductRequestList productRequestList;

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
      tecCountrySearchController;

  late FocusNode fnName,
      fnDescription,
      fnBrandName,
      fnModelName,
      fnModelTypeName,
      fnManufacturer,
      fnOeReferenceNo,
      fnMobileNo,
      fnYear,
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

  /*  var lstBrand = <BrandData>[].obs;
  var selectedBrands = BrandData().obs;

  var lstModel = <ModelData>[].obs;
  var selectedModel = ModelData().obs;*/

  var lstBrand = <BrandList>[].obs;
  var selectedBrands = BrandList().obs;

  var lstModel = <ModelList>[].obs;
  var selectedModel = ModelList().obs;

  var lstModelType = <ModelTypeList>[].obs;
  var selectedModelType = ModelTypeList().obs;

  // var lstCar = <CarList>[].obs;
  // var selectedCar = CarList().obs;

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
    productRequestList = Get.arguments;

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
    tecCountrySearchController = TextEditingController();
    tecYearController = TextEditingController(text: DateTime.now().year.toString());

    fnName = FocusNode();
    fnDescription = FocusNode();
    fnBrandName = FocusNode();
    fnModelName = FocusNode();
    fnModelTypeName = FocusNode();
    fnManufacturer = FocusNode();
    fnOeReferenceNo = FocusNode();
    fnMobileNo = FocusNode();
    fnYear = FocusNode();
    fnSearchBrand = FocusNode();
    fnSearchModel = FocusNode();
    fnSearchModelType = FocusNode();
    fnSearchManufacturer = FocusNode();
    fnSearchCountry = FocusNode();

    tecNameController.text = productRequestList.productName!;
    tecYearController.text = productRequestList.year.toString();
    tecOeReferenceNoController.text = productRequestList.oenumber.toString();
    tecBrandNameController.text = productRequestList.brandName.toString();
    tecModelNameController.text = productRequestList.modelName.toString();
    // tecModelTypeNameController.text = productRequestList.modelName.toString();
    tecManufacturerNameController.text = productRequestList.mfrName.toString();
    tecMobileNoController.text = productRequestList.phoneNumber.toString();
    tecDescriptionController.text = productRequestList.description.toString();

    selectedCountry = CountryData(countryName: "Algeria", countryId: 1, countryCode: "213", currencyPre: "DZ").obs;

    // callGetCarListAPI();
    callGetBrandListAPI();
    callGetManufacturerListAPI();
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
    tecCountrySearchController.dispose();
    tecYearController.dispose();

    fnName.dispose();
    fnDescription.dispose();
    fnBrandName.dispose();
    fnModelName.dispose();
    fnModelTypeName.dispose();
    fnManufacturer.dispose();
    fnOeReferenceNo.dispose();
    fnMobileNo.dispose();
    fnYear.dispose();
    fnSearchBrand.dispose();
    fnSearchModel.dispose();
    fnSearchModelType.dispose();
    fnSearchManufacturer.dispose();
    fnSearchCountry.dispose();
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
        if (lstManufacturer.isNotEmpty) {
          for (var element in lstManufacturer) {
            if (element.mfrId == productRequestList.mfrId) {
              element.isSelected?.value = true;
              selectedManufacturer.value = element;
              refresh();
            }
          }
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

    if (apiResponse != null) {
      if (apiResponse.success!) {
        lstBrand.clear();
        lstBrand.addAll(apiResponse.result!.brandList!);

        if (lstBrand.isNotEmpty) {
          for (var element in lstBrand) {
            if(productRequestList.brandId == element.brandId){
              selectedBrands.value = element;
              tecBrandNameController.text = element.brandName ?? "";
            }
          }
          callGetModelListAPI(brandId: productRequestList.brandId.toString());
        }

        update();
      } else {}
    }

    lstBrand.add(BrandList(brandId: 0, brandName: "Others"));
  }

  callGetModelListAPI({String? brandId}) async {
    vnIsShowLoader.value = true;
    Map<String, String> param = {'brandId': brandId ?? "0"};

    ModelDataModel? apiResponse = await ProductServiceController.getModelList(param);
    vnIsShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success!) {
        lstModel.clear();
        lstModel.addAll(apiResponse.result!.modelList!);
        for (var element in lstModel) {
          if(productRequestList.modelId == element.modelId){
            selectedModel.value = element;
            tecModelNameController.text = element.modelName ?? "";
          }
        }
        callGetModelTypeListAPI(modelId: selectedModel.value.modelId.toString());
        update();
      } else {}
    }

    lstModel.add(ModelList(modelId: 0, modelName: "Others"));
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
        for (var element in lstModelType) {
          if(productRequestList.modelTypeId == element.id){
            selectedModelType.value = element;
            tecModelTypeNameController.text = element.typeName ?? "";
          }
        }
        if(lstModelType.isEmpty){
          lstModelType.add(ModelTypeList(id: 0, typeName: "Others"));
          selectedModelType.value = lstModelType.first;
          tecModelTypeNameController.text = lstModelType.first.typeName ?? "";
          vnIsShowOtherModelType.value = true;
        }
        update();
      } else {}
    }
  }

  callEditRequestAPI(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (formKey.currentState!.validate()) {

      Map<String, String> param = {
        "Id": productRequestList.id.toString(),
        "ProductName": tecNameController.text.trim(),
        "BrandId": selectedBrands.value.brandId!=0  ? selectedBrands.value.brandId.toString() : productRequestList.brandId.toString(),
        "BrandName": selectedBrands.value.brandName!="" ? tecBrandNameController.text.trim() : productRequestList.brandName.toString(),
        "ModelId": selectedModel.value.modelId!=0  ? selectedModel.value.modelId.toString() : productRequestList.modelId.toString(),
        "ModelName": selectedModel.value.modelName!="" ? tecModelNameController.text.trim() : productRequestList.modelName.toString(),
        "ModelTypeId":selectedModelType.value.id!=0 ? selectedModelType.value.id.toString() : productRequestList.modelTypeId.toString(),
        "MfrId": selectedManufacturer.value.mfrId!=0  ? selectedManufacturer.value.mfrId.toString() : productRequestList.mfrId.toString(),
        "MfrName": selectedManufacturer.value.mfrName!="" ? tecManufacturerNameController.text.trim() : productRequestList.mfrName.toString(),
        "Year": tecYearController.text.trim(),
        "Description": tecDescriptionController.text.trim(),
        "PhoneNumber": tecMobileNoController.text.trim(),
        "Oenumber": tecOeReferenceNoController.text.trim(),
        "CustomerId": CommonWidget.user?.id.toString() ?? "0"
      };

      Log.debug('PARAM :  $param');

      vnIsShowLoader.value = true;
      APIResponse? apiResponse = await RequestServiceController.editRequest(param);
      vnIsShowLoader.value = false;

      if (apiResponse != null && apiResponse.success == true) {
        Navigator.pop(Get.context!, true);
      }
    }
  }

}
