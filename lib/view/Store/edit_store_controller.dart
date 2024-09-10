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
import 'package:mecazone/model/Store/store_details_data_model.dart';
import 'package:mecazone/model/Store/store_list_data_model.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class EditStoreBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(EditStoreController());
  }
}

class EditStoreController extends GetxController{
  dynamic argsData = Get.arguments;
  int storeId = 0;

  late StoreList? storeDetailsDataModel;

  late TextEditingController tecStoreNameController,
      tecDescriptionController,
      tecAddressController,
      tecProvinceSearchController,
      tecMunicipalitySearchController;

  late List<TextEditingController> tecStoreMobileNoController = [],
      tecCountryCodeInputController = [];

  final contactPersonCount = 0.obs, vnStoreImgLength = 0.obs;

  final nodes = [
    FocusNode(debugLabel: 'fnName'),
    FocusNode(debugLabel: 'fnAddress'),
    FocusNode(debugLabel: 'fnSearchProvince'),
    FocusNode(debugLabel: 'fnSearchMunicipality'),
    FocusNode(debugLabel: 'fnDescription')
  ];

  late List<FocusNode> fnMobileNo = [];

  final formKey = GlobalKey<FormState>();

  final vnIsShowStoreAddress = true.obs, vnIsAvailableDelivery = true.obs, vnIsShowLoader = false.obs , vnIsBrandLoader = false.obs;

  ValueNotifier<List<String>> vnLstProjectPhotos = ValueNotifier([]);

  final lstBrand = <BrandList>[].obs;

  final lstProvince = <ProvinceList>[].obs;
  var selectedProvince = ProvinceList().obs;

  final lstMunicipality = <MunicipalityList>[].obs;
  var selectedMunicipality = MunicipalityList().obs;

  final lstCountry = <CountryData>[].obs;
  var selectedCountry = CountryData().obs;

  List<StoreManagementImagesView>? lstStoreImages = [];

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
    storeId = argsData['storeId'];
    tecStoreNameController = TextEditingController();
    tecDescriptionController = TextEditingController();
    tecAddressController = TextEditingController();
    tecProvinceSearchController = TextEditingController();
    tecMunicipalitySearchController = TextEditingController();

    // fnMobileNo.add(FocusNode());

    selectedProvince = ProvinceList(id: 1, code: 1, name: "").obs;
    selectedMunicipality = MunicipalityList(id: 1, postCode: 1, name: "").obs;

    selectedCountry = CountryData(
        countryName: "Algeria",
        countryId: 1,
        countryCode: "213",
        currencyPre: "DZ").obs;

    update();
    callGetStoreDetailsAPI();
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
          AlertHelper.showToast("enterMobileNo".translate());
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

  /// : DELETE STORE IMAGE
  removeStoreImage(int index) {
    if (vnLstProjectPhotos.value[index].contains("http")) {
      for (var element in lstStoreImages!) {
        if (vnLstProjectPhotos.value[index] == element.storeImage) {
          callDeleteStoreImageAPI(index: index, imageId: element.id);
        }
      }
    } else {
      vnLstProjectPhotos.value.removeAt(index);
      vnStoreImgLength.value--;
      update();
    }
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
        if (lstBrand.isNotEmpty) {
          for (var element in lstBrand) {
            for (var subElement
            in storeDetailsDataModel!.storeManagementBrandsView!) {
              if (element.brandId == subElement.brandId) {
                element.isSelected?.value = true;
              }
            }
          }
        }
        update();
      } else {}
    }
  }

  /// : API CALL - GET PROVINCE LIST
  callGetProvinceListAPI() async {
    vnIsShowLoader.value = true;

    ProvinceDataModel? apiResponse = await StoreServiceController.getProvinceData();

    vnIsShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success! == true && apiResponse.result!.provinceList!.isNotEmpty) {
        // lstProvince.clear();
        lstProvince.addAll(apiResponse.result!.provinceList!);
        selectedProvince.value = lstProvince.first;
        if (lstProvince.isNotEmpty) {
          for (var element in lstProvince) {
            if (element.id == storeDetailsDataModel!.provinceId) {
              selectedProvince.value = element;
              callGetMunicipalityListAPI();
            }
          }
        } else {
          callGetMunicipalityListAPI();
        }
        update();
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
        if (lstMunicipality.isNotEmpty) {
          for (var element in lstMunicipality) {
            if (element.id == storeDetailsDataModel!.municipalityId) {
              selectedMunicipality.value = element;
            }
          }
        }
        update();
      } else {}
    }
  }

  /// : API CALL - ADD STORE
  callEditStoreAPI() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    if (formKey.currentState!.validate()) {
      vnIsShowLoader.value = true;
      Map<String, String> params = {
        "StoreName": tecStoreNameController.text.trim().toString(),
        "Description": tecDescriptionController.text.trim().toString(),
        "ProvinceId": selectedProvince.value.id.toString(),
        "MunicipalityId": selectedMunicipality.value.id.toString(),
        "Address": tecAddressController.text.trim().toString(),
        "AvailableDelivery": vnIsAvailableDelivery.value.toString(),
        "IsHide": vnIsShowStoreAddress.value.toString(),
        "ProfessionalId": CommonWidget.user!.id.toString(),
        "Id": storeDetailsDataModel!.id.toString(),
      };

      params["StoreManagementPhoneNumber[]"] = await getContactPersonData();
      String brandIds = "";
      for (var element in lstBrand) {
        if (element.isSelected?.value == true) {
          brandIds = "$brandIds${element.brandId},";
        }
      }
      if (brandIds.isNotEmpty) {
        params["BrandIds"] = brandIds.substring(0, brandIds.length - 1);
      }

      Map<String, List<File>> fileParams = {};

      List<File> lstStorePicture = [];
      for (int k = 0; k < vnStoreImgLength.value; k++) {
        if (!vnLstProjectPhotos.value.contains("http")) {
          File file = File(vnLstProjectPhotos.value[k]);
          if (await file.exists()) {
            lstStorePicture.add(file);
          }
        }
      }

      fileParams["ProfilePicture"] = lstStorePicture;

      APIResponse? apiResponse = await StoreServiceController.addEditStore(url: EDIT_STORE, body: params, fileBody: fileParams);
      vnIsShowLoader.value = false;

      if (apiResponse?.success! == true) {
        Navigator.pop(Get.context!, true);
        // Get.back(result: true);
      }
    } else {}
  }

  /// : API CALL - GET STORE DETAILS
  callGetStoreDetailsAPI() async {
    // vnIsShowLoader.value = true;

    String url = "$STORE_DETAILS${storeId.toString()}&userId=${CommonWidget.user!.id ?? "0"}";

    StoreDetailsDataModel? apiResponse = await StoreServiceController.getStoreDetailData(url: url);

    // vnIsShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success!) {
        storeDetailsDataModel = apiResponse.result!.storeDetails!;
        if (storeDetailsDataModel != null) {
          tecStoreNameController.text = storeDetailsDataModel!.storeName ?? "";
          tecDescriptionController.text = storeDetailsDataModel!.description ?? "";
          tecAddressController.text = storeDetailsDataModel!.address ?? "";
          vnIsShowStoreAddress.value = storeDetailsDataModel!.isHide ?? false;
          vnIsAvailableDelivery.value = storeDetailsDataModel!.isAvailableDelivery ?? false;
          lstStoreImages!.addAll(storeDetailsDataModel!.storeManagementImagesView!);

          for (var element in storeDetailsDataModel!.storeManagementImagesView!) {
            vnLstProjectPhotos.value.add(element.storeImage!);
          }
          vnStoreImgLength.value = vnLstProjectPhotos.value.length;

          for (var element in storeDetailsDataModel!.storeManagementPhoneNumber!) {
            tecStoreMobileNoController.add(TextEditingController(text: element.phoneNumber));
            tecCountryCodeInputController.add(TextEditingController(text: "213"));
            fnMobileNo.add(FocusNode());
            contactPersonCount.value++;
          }

          if (storeDetailsDataModel!.storeManagementPhoneNumber!.isEmpty) {
            tecStoreMobileNoController.add(TextEditingController());
            tecCountryCodeInputController.add(TextEditingController(text: "213"));
            fnMobileNo.add(FocusNode());
            contactPersonCount.value++;
          }

          await callGetProvinceListAPI();
          await callGetBrandListAPI();
        }
        update();
      } else {}
    }
  }

  /// : API CALL - DELETE STORE IMAGE DATA
  callDeleteStoreImageAPI({int? imageId, int? index}) async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    Map<String, String> param = {
      "storeImageId": imageId.toString(),
      "storeId": storeId.toString(),
    };

    APIResponse? apiResponse =
    await StoreServiceController.deleteStoreImageData(param);

    if (apiResponse != null) {
      if (apiResponse.success!) {
        vnLstProjectPhotos.value.removeAt(index!);
        vnStoreImgLength.value--;
        update();
      } else {}
    }
  }

  Future<String> getContactPersonData() async {
    List<StoreContactPersonDataModel> lstStoreData = [];
    for (int cp = 0; cp < contactPersonCount.value; cp++) {
      StoreContactPersonDataModel contactPersonDataModel = StoreContactPersonDataModel();
      contactPersonDataModel.id = 0;
      contactPersonDataModel.countryId = 1;
      contactPersonDataModel.storeId = 0;
      contactPersonDataModel.phoneNumber = tecStoreMobileNoController[cp].text;
      lstStoreData.add(contactPersonDataModel);
    }
    return jsonEncode(lstStoreData).toString();
  }

}