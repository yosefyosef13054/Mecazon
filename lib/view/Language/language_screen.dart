import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/custom/button_view.dart';
import 'package:mecazone/custom/direction_view_rtl.dart';
import 'package:mecazone/custom/keyboard_hide_view.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/localization/language_settings.dart';
import 'package:mecazone/view/Language/language_controller.dart';
import 'package:mecazone/view/Login/login_screen.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/helper/shared_pref.dart';
import 'package:mecazone/main.dart';

class LanguageScreen extends GetView<LanguageController> {
  static const route = '/LanguageScreen';
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DirectionViewRTL(
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: KeyboardHideView(
          child: Obx(
             () => Column(
                children: [
                SizedBox(
                  height: screenHeight * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetsHelper.getSVGIcon("ic_logo.svg"),
                        height: 120,
                        width: 120,
                      ),
                      CommonWidget.getFieldSpacer(height: 30.0),
                      SizedBox(
                        width: screenWidth,
                        child: Text(
                          "welcome".translate(),
                          textAlign: TextAlign.center,
                          style: Fonts.darkTitleTextStyle.copyWith(color: AppColor.appPrimaryColor),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth,
                        child: Text(
                          ("${"toTheBestAutoParts".translate()} \n ${"finderApp".translate()}"),
                          textAlign: TextAlign.center,
                          style: Fonts.cardTitleTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: screenHeight * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(CARD_CURVE_RADIUS), topLeft: Radius.circular(CARD_CURVE_RADIUS)),
                    image: DecorationImage(image: AssetsHelper.getImage("bg_lang.png"), fit: BoxFit.fill),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(
                        width: screenWidth,
                        child: Text(
                          "selectYourLanguage".translate(),
                          textAlign: TextAlign.center,
                          style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appWhiteColor),
                        ),
                      ),
                      CommonWidget.getFieldSpacer(height: 30.0),

                      ButtonView(
                        buttonTextName: "english".translate(),
                        color: controller.vnIsSelectedLang.value == 1 ? AppColor.appPrimaryColor : Colors.transparent,
                        borderColor: controller.vnIsSelectedLang.value == 1 ? AppColor.appPrimaryColor : AppColor.appWhiteColor,
                        onPressed: () async {
                          await changeLanguage(ENGLISH).then((value) {
                            MyApp.setLocale(context, value);
                          });
                          controller.vnIsSelectedLang.value = 1;
                        },
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),
                      ButtonView(
                        buttonTextName: "french".translate(),
                        color: controller.vnIsSelectedLang.value == 2 ? AppColor.appPrimaryColor : Colors.transparent,
                        borderColor: controller.vnIsSelectedLang.value == 2 ? AppColor.appPrimaryColor : AppColor.appWhiteColor,
                        onPressed: () async {
                          await changeLanguage(FRENCH).then((value) {
                            MyApp.setLocale(context, value);
                          });
                          controller.vnIsSelectedLang.value = 2;
                        },
                      ),
                      CommonWidget.getFieldSpacer(height: 15.0),
                      ButtonView(
                        buttonTextName: "arabic".translate(),
                        color: controller.vnIsSelectedLang.value == 3 ? AppColor.appPrimaryColor : Colors.transparent,
                        borderColor: controller.vnIsSelectedLang.value == 3 ? AppColor.appPrimaryColor : AppColor.appWhiteColor,
                        onPressed: () async {
                          await changeLanguage(FRENCH).then((value) {
                            MyApp.setLocale(context, value);
                          });
                          controller.vnIsSelectedLang.value = 3;
                        },
                      ),
                      CommonWidget.getFieldSpacer(height: 30.0),
                      SizedBox(
                        width: screenWidth * 0.40,
                        child: ButtonView(
                          buttonTextName: "proceed".translate(),
                          color: AppColor.appPrimaryColor,
                          borderColor: AppColor.appPrimaryColor,
                          onPressed: () {
                            if (controller.isFromMenu.value == true) {
                              Get.back(result:  true);
                            } else {
                              SharedPref.savePreferenceValue(isFirstTime, true);
                              Get.toNamed(LoginScreen.route);
                            }
                            /*SharedPref.savePreferenceValue(isFirstTime, true);
                            // NavigatorHelper.goTo(LoginScreen());
                            Get.toNamed(LoginScreen.route);*/
                          },
                        ),
                      ),
                      CommonWidget.getFieldSpacer(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
