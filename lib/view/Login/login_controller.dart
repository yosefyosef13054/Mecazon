import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/controller/user_service_controller.dart';
import 'package:mecazone/helper/shared_pref.dart';
import 'package:mecazone/model/country_data_model.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/view/Home/home_screen.dart';
import 'package:mecazone/view/Store/add_store_screen.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}

class LoginController extends  GetxController{

  final nodes = [
    FocusNode(debugLabel: 'fnEmail'),
    FocusNode(debugLabel: 'fnMobileNo'),
    FocusNode(debugLabel: 'fnPassword'),
    FocusNode(debugLabel: 'fnSearchCountry')
  ];

  late TextEditingController emailController,
      mobileNoController,
      passwordController,
      countrySearchController;

  final formKey = GlobalKey<FormState>();

  final rxIsShowLoader = false.obs;
  final rxIsLoginType = 1.obs;

  final lstCountry = <CountryData>[].obs;
  final selectedCountry = Rx<CountryData>(CountryData(
      countryName: "Algeria",
      countryId: 1,
      countryCode: "213",
      currencyPre: "DZ"));

  String pairId = "";

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
  }

  _init() async {
    emailController = TextEditingController();
    mobileNoController = TextEditingController();
    passwordController = TextEditingController();
    countrySearchController = TextEditingController();
    pairId = await SharedPref.readPreferenceValue(kPrefKeyPairId, PrefEnum.STRING);
  }

  void signIn() async {

    FocusScope.of(Get.context!).requestFocus(FocusNode());

    if (formKey.currentState!.validate()) {
      rxIsShowLoader(true);

      Map<String, String> param = {
        "email": rxIsLoginType.value == LOGIN_TYPE_1
            ? emailController.text.trim()
            : mobileNoController.text.trim(),
        "password": passwordController.text.trim(),
        "pairID": pairId,
      };

      Log.debug("Login Request = $param");
      final apiResponse = await UserServiceController.login(param);
      rxIsShowLoader(false);

      if (apiResponse != null && apiResponse.success == true) {
        if (CommonWidget.user!.profileTypeId == USER_TYPE_1057_PROFESSIONAL && CommonWidget.user!.hasAddedStore == false) {
          Get.offAllNamed(AddStoreScreen.route);
        } else {
          Get.offAllNamed(HomeScreen.route);
        }
      }
      return;
    }
  }

}