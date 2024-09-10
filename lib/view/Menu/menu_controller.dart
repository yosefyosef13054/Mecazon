import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/shared_pref.dart';
import 'package:mecazone/model/User/user_data_model.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/view/Login/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MenusBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(MenusController());
  }
}

class MenusController extends GetxController{

  final vnIsShowNotification = false.obs , vnIsDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  _init() async {
    final isNotification = await SharedPref.readPreferenceValue(kPrefKeyIsNotification, PrefEnum.BOOL);
    final isDarkMode = await SharedPref.readPreferenceValue(kPrefKeyDarkMode, PrefEnum.BOOL);
    vnIsShowNotification.value = !isNotification;
    vnIsDarkMode.value = isDarkMode;
    update();
  }

  /// : LOGOUT FUNCTION
  appLogout({bool? isFromLogout}) {
    User? user = User();
    SharedPref.savePreferenceValue(kUserModelKey, user);
    SharedPref.savePreferenceValue(isLogin, false);
    CommonWidget.user = null;
    if (isFromLogout == true) {
      Get.toNamed(LoginScreen.route);
    }
  }

  openUrl(String url) async {
    Uri u = Uri.https(url);
    if(await canLaunchUrl(u)){
      await launchUrl(u);
    }else {
      throw 'Could not launch';
    }
  }

  /// : CHANGE NOTIFICATION ON OFF
  changeNotification() async {
     vnIsShowNotification.value = !vnIsShowNotification.value;
     await SharedPref.savePreferenceValue(kPrefKeyIsNotification, !vnIsShowNotification.value);
     update();
  }

  /// : CHANGE DARK MODE THEME ON OFF
  changeThemeMode() async {
    vnIsDarkMode.value = !vnIsDarkMode.value;
    await SharedPref.savePreferenceValue(kPrefKeyDarkMode, !vnIsDarkMode.value);
    ThemeMode theme = vnIsDarkMode.value ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(theme);
    update();
  }

  /// : CHANGE DARK MODE THEME ON OFF
  Future<ThemeMode> getThemeMode() async {
    final isDarkMode = await SharedPref.readPreferenceValue(kPrefKeyDarkMode, PrefEnum.BOOL);
    vnIsDarkMode.value = !isDarkMode;
    ThemeMode theme = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(theme);
    update();
    return theme;
  }


}