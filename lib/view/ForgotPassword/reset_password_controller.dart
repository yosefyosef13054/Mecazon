import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/model/User/reset_password_data_model.dart';
import 'package:mecazone/controller/user_service_controller.dart';
import 'package:mecazone/helper/shared_pref.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/view/Login/login_screen.dart';

class ResetPasswordBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(ResetPasswordController());
  }
}

class ResetPasswordController extends GetxController{

  late int? userId;
  var argsData = Get.arguments;

  late TextEditingController passwordController,confirmPasswordController;
  final nodes = [
    FocusNode(debugLabel: 'fnPassword'),
    FocusNode(debugLabel: 'fnConfirmPassword')
  ];

  final formKey = GlobalKey<FormState>();
  final rxIsShowLoader = false.obs , rxIsShowPwd = true.obs , rxIsShowConfirmPwd = true.obs , rxIsRememberMe = false.obs ;

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

  _init() {
    userId = argsData['userId']??0;
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    update();
  }

  /// : REMEMBER PASSWORD - SAVE PASSWORD
  rememberPassword() async {
    rxIsRememberMe.value = !rxIsRememberMe.value;
    if (rxIsRememberMe.value) {
      await SharedPref.savePreferenceValue(kPrefKeyPassword,passwordController.text);
    } else {
      await SharedPref.savePreferenceValue(kPrefKeyPassword, "");
    }
    update();
  }

  /// : CALL RESET PASSWORD API
  callResetPasswordAPI() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    if (formKey.currentState!.validate()) {
      Map<String, String> param = {
        "Id": userId.toString(),
        "Password": passwordController.text.toString()
      };

      rxIsShowLoader.value = true;

      ResetPasswordDataModel? apiResponse = await UserServiceController.resetPassword(param);

      rxIsShowLoader.value = false;

      if (apiResponse != null) {
        if (apiResponse.success!) {
          Get.offAllNamed(LoginScreen.route);
        } else {
          // NavigatorHelper.removeAllAndOpen(HomeScreen());
        }
      }
    }
  }

}