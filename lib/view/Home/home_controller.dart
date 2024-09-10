import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/controller/cms_service_controller.dart';
import 'package:mecazone/controller/product_service_controller.dart';
import 'package:mecazone/controller/tecdoc_service_controller.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/model/Common/settings_data_model.dart';
import 'package:mecazone/model/Product/brand_data_model.dart';
import 'package:mecazone/model/Product/model_data_model.dart';
import 'package:mecazone/model/Product/model_type_data_model.dart';
import 'package:mecazone/model/TecDoc/Request/request_get_car.dart';
import 'package:mecazone/model/TecDoc/Response/get_car_data.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/view/Home/home_screen.dart';
import 'package:mecazone/controller/home_service_controller.dart';
import 'package:mecazone/controller/user_service_controller.dart';
import 'package:mecazone/helper/alert_helper.dart';
import 'package:mecazone/helper/navigator_helper.dart';
import 'package:mecazone/helper/shared_pref.dart';
import 'package:mecazone/model/api_response.dart';
import 'package:mecazone/model/Home/home_data_model.dart';
import 'package:mecazone/model/User/user_data_model.dart';
import 'package:mecazone/model/User/profile_data_model.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/view/Menu/menu_screen.dart';
import 'package:mecazone/view/Request/request_list_screen.dart';
import 'package:mecazone/view/Store/store_list_screen.dart';

class HomeBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}

class HomeController extends GetxController{

  late TextEditingController tecSearchController,searchBrandController,searchModelController,searchModelTypeController;
  late FocusNode fnSearch,fnSearchBrand,fnSearchModel,fnSearchModelType;

  final vnCurrentBannerIndex = 0.0.obs;
  final vnCurrentNavigationIndex = 0.obs, noOfCarsAddedByUser = 0.obs;
  final vnIsShowLoader = false.obs, fnBrand = false.obs, fnModel = false.obs, fnModelType = false.obs;
  final bottomSheetLoader = false.obs;
  var homeBrandList = <HomeBrandList>[].obs;
  var homeCategoryList = <HomeCategoryList>[].obs;
  var homeBannerList = <HomeBannerList>[].obs;
  var homeCarList = <HomeCarList>[].obs;

  List<BrandList> lstBrand = [];
  BrandList? selectedBrand ;

  List<ModelList> lstModel = [];
  ModelList? selectedModel;

  List<ModelTypeList> lstModelType = [];
  ModelTypeList? selectedModelType;

  List<CarData>? lstCar = [];

  ScrollController brandScrollController = ScrollController();
  ScrollController modelScrollController = ScrollController();
  ScrollController modelTypeScrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  onClose() {
    fnSearch.dispose();
    fnSearchBrand.dispose();
    fnSearchModel.dispose();
    fnSearchModelType.dispose();
  }

  _init(){
    tecSearchController = TextEditingController();
    searchBrandController = TextEditingController();
    searchModelController = TextEditingController();
    searchModelTypeController = TextEditingController();
    fnSearch = FocusNode();
    fnSearchBrand = FocusNode();
    fnSearchModel = FocusNode();
    fnSearchModelType = FocusNode();
    loadSharedPrefs();

    brandScrollController.addListener(() {
      if (brandScrollController.position.maxScrollExtent == brandScrollController.position.pixels) {
        if (!vnIsShowLoader.value) {
          callGetBrandListAPI(counter: lstBrand.length, isFromScroll: true);
        }
      }
    });

    modelScrollController.addListener(() {
      if (modelScrollController.position.maxScrollExtent == modelScrollController.position.pixels) {
        if (!vnIsShowLoader.value) {
          callGetModelListAPI(counter: lstModel.length, isFromScroll: true);
        }
      }
    });

    modelTypeScrollController.addListener(() {
      if (modelTypeScrollController.position.maxScrollExtent == modelTypeScrollController.position.pixels) {
        if (!vnIsShowLoader.value) {
          callGetModelTypeListAPI(counter: lstModelType.length, isFromScroll: true);
        }
      }
    });
  }

  onChangeBrand(int index) async{
    selectedBrand = lstBrand[index];
    for (var element in lstBrand) {
      element.isSelected?.value = false;
    }
    lstBrand[index].isSelected?.value = true;
    fnModel.value = true;
    lstModel.clear();
    update();
    callGetModelListAPI(counter: 0,isFromScroll: false,brandId: selectedBrand!.brandId.toString());
  }

  onChangeModel(int index) async{
    selectedModel = lstModel[index];
    for (var element in lstModel) {
      element.isSelected?.value = false;
    }
    lstModel[index].isSelected?.value = true;
    fnModelType.value = true;
    lstModelType.clear();
    selectedModelType = null;
    update();
    callGetModelTypeListAPI(counter: 0,isFromScroll: false,modelId: selectedModel!.modelId.toString());
  }

  onChangeModelType(int index) async{
    selectedModelType =lstModelType[index];
    for (var element in lstModelType) {
      element.isSelected?.value = false;
    }
    lstModelType[index].isSelected?.value = true;
    update();
  }

  loadSharedPrefs() async {
    try {
      User? user = User.fromJson(await SharedPref.readPreferenceValue(kUserModelKey, PrefEnum.MODEL));
      CommonWidget.user = user;
      /// : CALL GET USER PROFILE DATA API
      if(CommonWidget.user == null) {
        callGetProfileDataAPI();
      }
      callGetHomeDataListAPI();
      callGetSettingsAPI();
    } catch (error) {
      error.toString();
    }
  }

  navigationTapped(int newPage) {
    vnCurrentNavigationIndex.value = newPage;

    switch (newPage) {
      case 0:
        Get.offAllNamed(HomeScreen.route);
        break;
      case 1:
        Get.toNamed(StoreListScreen.route)?.then((value){
          vnCurrentNavigationIndex.value = 0;
          update();
        });
        break;
      case 2:
        Get.toNamed(RequestListScreen.route)?.then((value){
          vnCurrentNavigationIndex.value = 0;
          update();
        });
        break;
      case 3:
        Get.toNamed(MenuScreen.route)?.then((value) {
          vnCurrentNavigationIndex.value = 0;
          update();
        });
        break;
      default:
        Get.toNamed(MenuScreen.route)?.then((value) {
          vnCurrentNavigationIndex.value = 0;
          update();
        });
        break;
    }
  }

  /// : API CALL - GET BRAND LIST API
  Future<bool> callGetBrandListAPI({int counter = 0, bool isFromScroll = false}) async {
    bottomSheetLoader.value = true;
    Map<String, String> param = {
      'page': counter.toString(),
      'search' : searchBrandController.text.trim()
    };
    BrandDataModel? apiResponse = await ProductServiceController.getBrandList(param);

    bottomSheetLoader.value = false;
    if (apiResponse != null && apiResponse.success! == true) {
      if (!isFromScroll) {
        lstBrand.clear();
      }
      lstBrand.addAll(apiResponse.result!.brandList!);
      fnBrand.value = false;
      update();
      return true;
    } else {
      return false;
    }
  }

  /// : API CALL - GET MODEL LIST API
  Future<bool> callGetModelListAPI({int counter = 0, bool isFromScroll = false,String? brandId}) async {
    if(!isFromScroll){
      vnIsShowLoader.value = true;
    }
    bottomSheetLoader.value = true;
    Map<String, String> param = {
      'brandId': brandId ?? "0",
      'page' : counter.toString(),
      'search' : searchModelController.text.trim()
    };

    ModelDataModel? apiResponse = await ProductServiceController.getModelList(param);
    bottomSheetLoader.value = false;
    vnIsShowLoader.value = false;

    if (apiResponse != null && apiResponse.success! == true) {
      if (!isFromScroll) {
        lstModel.clear();
      }
      lstModel.addAll(apiResponse.result!.modelList!);
      fnModel.value = false;
      update();
      // refresh();
      return true;
    } else {
      return false;
    }
  }

  /// : API CALL - GET MODEL TYPE LIST API
  Future<bool> callGetModelTypeListAPI({int counter = 0, bool isFromScroll = false,String? modelId}) async {
    if(!isFromScroll){
      vnIsShowLoader.value = true;
    }
    bottomSheetLoader.value = true;
    Map<String, String> param = {
      'modelId': modelId ?? "0",
      'page' : counter.toString(),
      'search' : searchModelTypeController.text.trim()
    };

    ModelTypeDataModel? apiResponse = await ProductServiceController.getModelTypeList(param);
    bottomSheetLoader.value = false;
    vnIsShowLoader.value = false;

    if (apiResponse != null && apiResponse.success! == true) {
      if (!isFromScroll) {
        lstModelType.clear();
      }
      lstModelType.addAll(apiResponse.result!.modelTypeList!);
      fnModelType.value = false;
      update();
      // refresh();
      return true;
    } else {
      return false;
    }
  }

  /// : API CALL - GET CAR DATA API
  callGetCarDataAPI({String? carId, String? modelSeriesName}) async{
    try {
      vnIsShowLoader.value = true;
      RequestGetCar data = RequestGetCar(
          getLinkageTargets: GetLinkageTargets(
            lang: CommonWidget.commonSettings?.languageCode.toString(),
            provider: CommonWidget.commonSettings?.providerId,
            linkageTargetCountry: CommonWidget.commonSettings?.countryCode.toString(),
            query: carId ?? "",
            vehicleModelSeriesName: modelSeriesName ??""
          )
      );
      GetCarData? apiResponse = await TecDocServiceController.getTecDocCarData(jsonEncode(data).toString());
      vnIsShowLoader.value = false;

      if (apiResponse != null && apiResponse.carList!.isNotEmpty) {
        apiResponse.carList?.forEach((c) {
           if(c.vehicleImages!.isNotEmpty){
              callAddNewCarAPI(carImage: c.vehicleImages?.first.imageURL100);
           }
        });
      }else{
        callAddNewCarAPI(carImage: "");
      }
    } catch (e) {
      callAddNewCarAPI(carImage: "");
      vnIsShowLoader.value = false;
    }
    update();
  }

  /// : API CALL - GET USER DATA API
  callGetProfileDataAPI() async {
    try {
      vnIsShowLoader.value = true;
      Map<String, String> param = {'id': CommonWidget.user!.id.toString()};

      ProfileDataModel? apiResponse =
      await UserServiceController.getUserProfileDetails(param);
      vnIsShowLoader.value = false;

      if (apiResponse != null) {
        if (apiResponse.success!) {
          SharedPref.savePreferenceValue(kUserModelKey, apiResponse.result!.user!);
          CommonWidget.user = apiResponse.result!.user;
        } else {}
      }
    } catch (e) {
      vnIsShowLoader.value = false;
    }
    update();
  }

  /// : API CALL - GET HOME DATA API
  callGetHomeDataListAPI() async {
    try {
      vnIsShowLoader.value = true;
      Map<String, String> param = {'userId': CommonWidget.user!.id.toString()};

      HomeDataModel? apiResponse = await HomeServiceController.getHomeDataList(param);

      if (apiResponse != null) {
        if (apiResponse.success!) {
          vnIsShowLoader.value = true;

          // homeBrandList.clear();
          homeCategoryList.clear();
          homeBannerList.clear();
          homeCarList.clear();

          // homeBrandList.addAll(apiResponse.result!.homeBrandList!);
          homeCategoryList.addAll(apiResponse.result!.homeCategoryList!);
          homeBannerList.addAll(apiResponse.result!.homeBannerList!);
          homeCarList.addAll(apiResponse.result!.homeCarList!);

          noOfCarsAddedByUser.value = apiResponse.result!.noOfCars ?? 0;

          vnIsShowLoader.value = false;
        } else {}
      }
    } catch (e) {
      vnIsShowLoader.value = false;
    }
    vnIsShowLoader.value = false;
    update();
  }

  /// : API CALL - GET SETTING DATA API
  callGetSettingsAPI() async{
    try {
      vnIsShowLoader.value = true;
      SettingsDataModel? apiResponse = await CMSServiceController.getSettingsData();
      vnIsShowLoader.value = false;

      if (apiResponse != null && apiResponse.success!) {
        CommonWidget.commonSettings = apiResponse.result!.commonSettings ?? CommonSettings();
      }
    } catch (e) {
      vnIsShowLoader.value = false;
    }
    update();
  }

  checkValidationForAddNewCar(BuildContext context) {
    if (selectedModelType == null) {
      AlertHelper.showToast("modelTypeValidation".translate());
    } else {
      callGetCarDataAPI(carId: selectedModelType?.id.toString() ,modelSeriesName: selectedModel?.modelName.toString());
    }
  }

  /// : API CALL - ADD NEW CAR DATA API
  callAddNewCarAPI({String? carImage}) async {
    // vnIsShowLoader.value = true;
    try {
      Map<String, String> param = {
        'UserId': CommonWidget.user!.id.toString(),
        'BrandId': selectedBrand!.brandId.toString(),
        'ModelId': selectedModel!.modelId.toString(),
        'ModelTypeId': selectedModelType!.id.toString(),
        'image': carImage ?? ""
      };

      Log.debug("Add car Params = $param");
      APIResponse? apiResponse = await HomeServiceController.addNewCar(param);
      // vnIsShowLoader.value = false;

      if (apiResponse != null && apiResponse.success!) {
        homeCarList.add(
            HomeCarList(
              id: 0,
              brandId: selectedBrand?.brandId,
              brandName: selectedBrand?.brandName,
              modelId: selectedModel?.modelId,
              modelName: selectedModel?.modelName,
              modelTypeId: selectedModelType?.id,
              image: carImage
            )
        );
        noOfCarsAddedByUser.value ++;
        selectedModelType = null;
        update();

        NavigatorHelper.remove(value: true);
        NavigatorHelper.remove(value: true);
        NavigatorHelper.remove(value: true);
        // callGetHomeDataListAPI();
      }
    } catch (e) {
      vnIsShowLoader.value = false;
    }
    update();
  }

  /// : API CALL - DELETE CAR DATA API
  callDeleteCarAPI(BuildContext context, int index) async {
    vnIsShowLoader.value = true;
    Map<String, String> param = {
      'UserId': CommonWidget.user!.id.toString(),
      'CarId': homeCarList[index].id.toString()
    };

    APIResponse? apiResponse = await HomeServiceController.deleteCar(param);
    vnIsShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success!) {
        homeCarList.removeAt(index);
        noOfCarsAddedByUser.value = noOfCarsAddedByUser.value - 1;
      } else {}
    }
    update();
  }

}