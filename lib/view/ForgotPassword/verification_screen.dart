import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/alert_helper.dart';
import 'package:pinput/pinput.dart';
import 'package:mecazone/custom/direction_view_rtl.dart';
import 'package:mecazone/helper/validation_helper.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/view/ForgotPassword/verification_controller.dart';
import 'package:mecazone/utils/log.dart';
import 'package:mecazone/custom/button_view.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/navigator_helper.dart';
import 'package:mecazone/helper/regex.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class VerificationScreen extends GetView<VerificationController> {
  const VerificationScreen({super.key});
  static const route = '/verification';

  @override
  Widget build(BuildContext context) {
      return DirectionViewRTL(
        child: Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          appBar: PreferredSize(
              preferredSize: Size(Get.width, kToolbarHeight),
              child: const _LocalAppBar()
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING, vertical: MAIN_PADDING),
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
                  Text(
                    "otpVerification".translate(),
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.labelLarge,
                  ),
                  CommonWidget.getFieldSpacer(height: 30.0),
                  Text(
                    ("${"codeHasBeenSendTo".translate()} ${controller.otpSentByText}"),
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.bodyLarge,
                  ),
                  CommonWidget.getFieldSpacer(height: 15.0),
                  Pinput(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                      FilteringTextInputFormatter.allow(Regex.onlyDigits)
                    ],
                    defaultPinTheme: controller.defaultPinTheme,
                    length: 6,
                    validator: (value) => ValidationHelper.checkBlankValidation(context, controller.pinController.text, "otpCodeValidation"),
                    focusedPinTheme: controller.defaultPinTheme.copyWith(
                      height: 50,
                      width: 50,
                      textStyle: context.theme.textTheme.bodyMedium,
                      decoration: controller.defaultPinTheme.decoration?.copyWith(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColor.appPrimaryColor),
                        color: AppColor.appLightOrangeColor,
                      ),
                    ),
                    submittedPinTheme:controller. defaultPinTheme.copyWith(
                      height: 50,
                      width: 50,
                      textStyle: context.theme.textTheme.bodyMedium,
                      decoration: controller.defaultPinTheme.decoration?.copyWith(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColor.appPrimaryColor),
                        color: AppColor.appLightOrangeColor
                      ),
                    ),
                    closeKeyboardWhenCompleted: true,
                    controller: controller.pinController,
                    focusNode: controller.pinPutFocusNode,
                    useNativeKeyboard: true,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) => Log.info(pin),
                  ),
                  CommonWidget.getFieldSpacer(height: 15.0),
                  SizedBox(
                    width: screenWidth,
                    child: Visibility(
                      visible: controller.rxResendSeconds.value != 0,
                      child: RichText(
                        text: TextSpan(
                            text:"resendCodeIn".translate(),
                            style: context.theme.textTheme.bodyLarge,
                            children: [
                              TextSpan(
                                text: " ${controller.rxResendSeconds.value} s",
                                style: context.theme.textTheme.bodyLarge?.copyWith(color: AppColor.appPrimaryColor),
                              )
                            ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  CommonWidget.getFieldSpacer(height: 30.0),
                  ButtonView(
                    buttonTextName: controller.rxResendSeconds.value < 1
                        ? "resend".translate()
                        : "verify".translate(),
                    color: AppColor.appPrimaryColor,
                    borderColor: AppColor.appPrimaryColor,
                    rxIsShowLoader: controller.rxIsShowLoader,
                    onPressed: () {
                      if (controller.rxResendSeconds.value > 0) {
                        if (controller.email!.isNotEmpty && controller.pinController.text.isNotEmpty) {
                          controller.callVerifyOTPAPI();
                        } else if (controller.mobileNo!.isNotEmpty && controller.pinController.text.isNotEmpty) {
                          controller.callVerifyOTPOnMobileAPI();
                        }else{
                          AlertHelper.showToast("otpCodeValidation".translate());
                        }
                      }
                      else {
                        if (controller.email!.isNotEmpty) {
                          controller.callSendOTPOnEmailAPI();
                        } else {
                          controller.callSendOTPOnMobileNo();
                        }
                      }
                    },
                  ),
                  CommonWidget.getFieldSpacer(height: 15.0),
                ],
              ),
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

