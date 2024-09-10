import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/custom/direction_view_rtl.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/view/ForgotPassword/opt_verification_controller.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/custom/button_view.dart';
import 'package:mecazone/helper/navigator_helper.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class OTPVerificationScreen extends GetView<OTPVerificationController>{

  static const route = '/otpVerification';
  const OTPVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(OTPVerificationController());
    return DirectionViewRTL(
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size(Get.width, kToolbarHeight),
          child: const _LocalAppBar(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric( horizontal: MAIN_PADDING, vertical: MAIN_PADDING),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetsHelper.getSVGIcon("ic_logo.svg"),
                  height: 100,
                  width: 100,
                ),
                CommonWidget.getFieldSpacer(height: 30.0),
                SizedBox(
                  width: screenWidth,
                  child: Text(
                    "otpVerification".translate(),
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.labelLarge,
                  ),
                ),
                CommonWidget.getFieldSpacer(height: 40.0),
                SizedBox(
                  width: screenWidth,
                  child: Text(
                    ("${"selectWhichContactDetailsShould".translate()} "),
                    // textAlign: TextAlign.center,
                    style: context.theme.textTheme.bodyLarge,
                  ),
                ),
                CommonWidget.getFieldSpacer(height: 30.0),
                Visibility(
                  visible: controller.email!.isNotEmpty,
                  child: ListTile(
                    onTap: () {
                      controller.rxIsEmailSelected.value = true;
                    },
                    leading: CircleAvatar(
                      backgroundColor: controller.rxIsEmailSelected.value
                          ? AppColor.appLightOrangeColor
                          : AppColor.appButtonGreyColor,
                      maxRadius: 40.0,
                      child: SvgPicture.asset(
                        AssetsHelper.getSVGIcon('ic_email.svg'),
                        height: 25.0,
                        width: 25.0,
                        colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn)
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(15.0)),
                        side: BorderSide(
                            color: controller.rxIsEmailSelected.value
                                ? AppColor.appPrimaryColor
                                : AppColor.appButtonGreyColor,
                            width: 1.0)),
                    tileColor: controller.rxIsEmailSelected.value
                        ? AppColor.appLightOrangeColor
                        : AppColor.appButtonGreyColor,
                    minVerticalPadding: 0.0,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: -4.0, vertical: 0.0),
                    horizontalTitleGap: 0.0,
                    title: Text(
                      "viaEmail".translate(),
                      style: context.theme.textTheme.bodyLarge?.copyWith(fontSize: 12.0),
                    ),
                    subtitle: Text(
                      controller.email ?? "",
                      style: Fonts.regularTextStyle,
                    ),
                  ),
                ),
                CommonWidget.getFieldSpacer(height: 15.0),
                Visibility(
                  visible: controller.mobileNo!.isNotEmpty,
                  child: ListTile(
                    onTap: () {
                      controller.rxIsEmailSelected.value = false;
                    },
                    leading: CircleAvatar(
                      backgroundColor: controller.rxIsEmailSelected.value
                          ? AppColor.appButtonGreyColor
                          : AppColor.appLightOrangeColor,
                      maxRadius: 40.0,
                      child: SvgPicture.asset(
                        AssetsHelper.getSVGIcon('ic_message.svg'),
                        height: 25.0,
                        width: 25.0,
                        colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn)
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(15.0)),
                        side: BorderSide(
                            color: controller.rxIsEmailSelected.value
                                ? AppColor.appButtonGreyColor
                                : AppColor.appPrimaryColor,
                            width: 1.0)),
                    tileColor: controller.rxIsEmailSelected.value
                        ? AppColor.appButtonGreyColor
                        : AppColor.appLightOrangeColor,
                    minVerticalPadding: 0.0,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: -4.0, vertical: 0.0),
                    horizontalTitleGap: 0.0,
                    title: Text(
                      "viaSMS".translate(),
                      // textAlign: TextAlign.center,
                      style: context.theme.textTheme.bodyLarge?.copyWith(fontSize: 12.0),
                    ),
                    subtitle: Text(
                      " + ${controller.countryCode} ${controller.mobileNo} ",
                      // textAlign: TextAlign.center,
                      style: Fonts.regularTextStyle,
                    ),
                  ),
                ),
                CommonWidget.getFieldSpacer(height: 30.0),
                ButtonView(
                  buttonTextName: "sendOTP".translate(),
                  color: AppColor.appPrimaryColor,
                  borderColor: AppColor.appPrimaryColor,
                  rxIsShowLoader: controller.rxIsShowLoader,
                  onPressed: () {
                    if (!controller.rxIsShowLoader.value) {
                      controller.rxIsEmailSelected.value == true
                          ? controller.callSendOTPOnEmailAPI()
                          : controller.callSendOTPOnMobileNo();
                    }
                  },
                ),
                CommonWidget.getFieldSpacer(height: 15.0),
              ],
            )
          ),
        ),
      ),
    );
  }

}

class _LocalAppBar extends StatelessWidget {
  const _LocalAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                NavigatorHelper.remove();
              },
              child: SvgPicture.asset(
                AssetsHelper.getSVGIcon('ic_back_round.svg'),
                height: 40.0,
                width: 40.0,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: context.theme.scaffoldBackgroundColor,
    );
  }
}