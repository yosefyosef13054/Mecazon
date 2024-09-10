import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/controller/product_service_controller.dart';
import 'package:mecazone/controller/store_service_controller.dart';
import 'package:mecazone/helper/alert_helper.dart';
import 'package:mecazone/model/api_response.dart';
import 'package:mecazone/model/Common/municipality_data_model.dart';
import 'package:mecazone/model/Common/province_data_model.dart';
import 'package:mecazone/model/country_data_model.dart';
import 'package:mecazone/model/Product/brand_data_model.dart';
import 'package:mecazone/model/Store/store_contact_person_data_model.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class AddStoreBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(AddStoreController());
  }
}

class AddStoreController extends GetxController{

  RxBool vnIsShowStoreAddress = true.obs, vnIsAvailableDelivery = true.obs, vnIsShowLoader = false.obs , vnIsBrandLoader = false.obs;

  final formKey = GlobalKey<FormState>();
  late TextEditingController tecStoreNameController,
      tecDescriptionController,
      tecAddressController,
      tecProvinceSearchController,
      tecMunicipalitySearchController;

  late List<TextEditingController> tecStoreMobileNoController = [],tecCountryCodeInputController = [];

  final contactPersonCount = 1.obs, vnStoreImgLength = 0.obs;

  final nodes = [
    FocusNode(debugLabel: 'fnName'),
    FocusNode(debugLabel: 'fnAddress'),
    FocusNode(debugLabel: 'fnSearchProvince'),
    FocusNode(debugLabel: 'fnSearchMunicipality'),
    FocusNode(debugLabel: 'fnDescription')
  ];

  late List<FocusNode> fnMobileNo = [];

  final lstBrand = <BrandList>[].obs;

  ValueNotifier<List<String>> vnLstProjectPhotos = ValueNotifier([]);

  final lstProvince = <ProvinceList>[].obs;
  var selectedProvince = ProvinceList().obs;

  final lstMunicipality = <MunicipalityList>[].obs;
  var selectedMunicipality = MunicipalityList().obs;

  final lstCountry = <CountryData>[].obs;
  var selectedCountry = CountryData().obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  onClose() {
    for (final node in nodes) {
      node.dispose();
    }
    fnMobileNo.clear();
  }

  _init(){
    tecStoreNameController = TextEditingController();
    tecDescriptionController = TextEditingController();
    tecAddressController = TextEditingController();
    tecProvinceSearchController = TextEditingController();
    tecMunicipalitySearchController = TextEditingController();
    tecStoreMobileNoController.add(TextEditingController());
    tecCountryCodeInputController.add(TextEditingController(text: "213"));
    fnMobileNo.add(FocusNode());

    selectedProvince = ProvinceList(
        id: 1,
        code: 1,
        name: ""
    ).obs;

    selectedMunicipality = MunicipalityList(
        id: 1,
        postCode: 1,
        name: ""
    ).obs;

    selectedCountry = CountryData(
        countryName: "Algeria",
        countryId: 1,
        countryCode: "213",
        currencyPre: "DZ"
    ).obs;

    callGetBrandListAPI();
    callGetProvinceListAPI();
  }

  changeStoreActiveOrHide(){
    vnIsShowStoreAddress.value = !vnIsShowStoreAddress.value;
    refresh();
  }

  changeStoreAvailableOrNot(){
    vnIsAvailableDelivery.value = !vnIsAvailableDelivery.value;
    refresh();
  }

  changeBrandSelection(int index){
    lstBrand[index].isSelected?.value = !lstBrand[index].isSelected!.value;
    refresh();
  }

  /// :  ADD  NEW CONTACT PERSON
  addNewContactPerson(BuildContext context) {
    bool temp = true;
    if (temp) {
      for (int t = 0; t < tecStoreMobileNoController.length; t++) {
        if (tecStoreMobileNoController[t].text.trim().isEmpty) {
          temp = false;
          AlertHelper.showToast("phoneNoValidation".translate());
          break;
        }
      }
      if (temp) {
        tecStoreMobileNoController.add(TextEditingController());
        tecCountryCodeInputController.add(TextEditingController(text: "213"));
        fnMobileNo.add(FocusNode());
        contactPersonCount.value++;
        update();
      }
    }
  }

  /// : DELETE CONTACT PERSON
  removeContactPerson(int index) {
    tecStoreMobileNoController.removeAt(index);
    tecCountryCodeInputController.removeAt(index);
    fnMobileNo.removeAt(index);
    contactPersonCount.value--;
    update();
  }

  /// : API CALL - GET BRAND LIST
  callGetBrandListAPI() async {
    vnIsBrandLoader.value = true;
    Map<String, String> param = {
      'page': "0",//lstBrand.length.toString(),
      // 'search' : searchBrandController.text.trim()
    };
    BrandDataModel? apiResponse = await ProductServiceController.getBrandList(param);
    vnIsBrandLoader.value = false;
    if (apiResponse != null) {
      if (apiResponse.success!) {
        lstBrand.clear();
        lstBrand.addAll(apiResponse.result!.brandList!);
      } else {}
    }
    update();
  }

  /// : API CALL - GET PROVINCE LIST
  callGetProvinceListAPI() async {
    vnIsShowLoader.value = true;
    ProvinceDataModel? apiResponse = await StoreServiceController.getProvinceData();
    vnIsShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success! == true && apiResponse.result!.provinceList!.isNotEmpty) {
        lstProvince.addAll(apiResponse.result!.provinceList!);
        selectedProvince.value = lstProvince.first;
        update();
        callGetMunicipalityListAPI();
      } else {}
    }
  }

  /// : API CALL - GET MUNICIPALITY LIST
  callGetMunicipalityListAPI() async {
    String url = MUNICIPALITY_LIST + selectedProvince.value.id.toString();

    MunicipalityDataModel? apiResponse = await StoreServiceController.getMunicipalityData(url: url);

    if (apiResponse != null) {
      if (apiResponse.success!) {
        lstMunicipality.clear();
        lstMunicipality.addAll(apiResponse.result!.municipalityList!);
        selectedMunicipality.value = lstMunicipality.first;
        update();
      } else {}
    }

  }

  /// : API CALL - ADD STORE
  callAddStoreAPI() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    if (formKey.currentState!.validate()) {

      vnIsShowLoader.value = true;
      Map<String, String> params = {
        "StoreName": tecStoreNameController.text.trim().toString(),
        "Description": tecDescriptionController.text.trim().toString(),
        "ProvinceId": selectedProvince.value.id.toString(),
        "MunicipalityId": selectedMunicipality.value.id.toString(),
        "Address": tecAddressController.text.trim().toString(),
        "ProfessionalId": CommonWidget.user!.id.toString(),
        "AvailableDelivery": vnIsAvailableDelivery.value.toString(),
        "IsHide": vnIsShowStoreAddress.value.toString(),
        "Id": "0",
      };

      params["StoreManagementPhoneNumber[]"] = await getContactPersonData();
      String brandIds = "";
      for (var element in lstBrand) {
        if (element.isSelected!.value) {
          brandIds = "$brandIds${element.brandId},";
        }
      }
      if (brandIds.isNotEmpty) {
        params["BrandIds"] = brandIds.substring(0, brandIds.length - 1);
      }

      Map<String, List<File>> fileParams = {};

      List<File> lstStorePicture = [];
      for (int k = 0; k < vnStoreImgLength.value; k++) {
        File file = File(vnLstProjectPhotos.value[k]);
        if (await file.exists()) {
          lstStorePicture.add(file);
        }
      }

      fileParams["ProfilePicture"] = lstStorePicture;

      APIResponse? apiResponse = await StoreServiceController.addEditStore(url: ADD_STORE, body: params, fileBody: fileParams);
      vnIsShowLoader.value = false;

      if (apiResponse?.success! == true) {
        Navigator.pop(Get.context!, true);
      }
    } else {}
  }

  Future<String> getContactPersonData() async {
    List<StoreContactPersonDataModel> lstStoreData = [];
    for (int cp = 0; cp < contactPersonCount.value; cp++) {
      StoreContactPersonDataModel contactPersonDataModel =
      StoreContactPersonDataModel();
      contactPersonDataModel.id = 0;
      contactPersonDataModel.countryId = 1;
      contactPersonDataModel.storeId = 0;
      contactPersonDataModel.phoneNumber = tecStoreMobileNoController[cp].text;
      lstStoreData.add(contactPersonDataModel);
    }
    return jsonEncode(lstStoreData).toString();
  }
}