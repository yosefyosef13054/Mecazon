import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/view/ForgotPassword/reset_password_controller.dart';
import 'package:mecazone/custom/custom_textfield.dart';
import 'package:mecazone/custom/button_view.dart';
import 'package:mecazone/custom/direction_view_rtl.dart';
import 'package:mecazone/helper/alert_helper.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/navigator_helper.dart';
import 'package:mecazone/helper/validation_helper.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class ResetPasswordScreen extends  GetView<ResetPasswordController>{
  static const route = '/ResetPassword';
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size(Get.width, kToolbarHeight),
          child: const _LocalAppBAr(),
        ),
        body: DirectionViewRTL(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING, vertical: MAIN_PADDING),
            child: Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "createNewPassword".translate(),
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.labelLarge,
                  ),
                  CommonWidget.getFieldSpacer(height: 40.0),

                  /// : PASSWORD FIELD
                  CustomTextField(
                    tecController: controller.passwordController,
                    focusNode: controller.nodes[0],
                    isPassword: true,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                      FilteringTextInputFormatter.deny(RegExp(r'\s'))
                    ],
                    prefixIcon: 'ic_password.svg',
                    hintText: "enterPassword".translate(),
                    validator: (value) => ValidationHelper.checkBlankValidation(
                        context, value!, "passwordValidation"),
                    enableSuggestions: false,
                    isShowSuffixIcon: true,
                  ),
                  CommonWidget.getFieldSpacer(height: 15.0),

                  /// : CONFIRM PASSWORD  FIELD
                  CustomTextField(
                    tecController: controller.confirmPasswordController,
                    focusNode: controller.nodes[1],
                    isPassword: true,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                      FilteringTextInputFormatter.deny(RegExp(r'\s'))
                    ],
                    prefixIcon: 'ic_password.svg',
                    hintText: "enterConfirmPassword".translate(),
                    validator: (value) => ValidationHelper.checkConfirmPasswordValidation(context,value!, controller.confirmPasswordController.text),
                    textInputAction: TextInputAction.done,
                    enableSuggestions: false,
                    isShowSuffixIcon: true,
                  ),

                  Obx(
                    () => Center(
                      child: Theme(
                        data: ThemeData(unselectedWidgetColor: context.theme.primaryColorLight),
                        child: ListTileTheme(
                          horizontalTitleGap: 0,
                          child: CheckboxListTile(
                              value: controller.rxIsRememberMe.value,
                              activeColor: AppColor.appPrimaryColor,
                              tileColor: context.theme.scaffoldBackgroundColor,
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: InkWell(
                                  onTap: () async {
                                    controller.rememberPassword();
                                  },
                                  child: Text(
                                      "rememberMe".translate(),
                                      style: context.theme.textTheme.bodyLarge
                                  )
                              ),
                              onChanged: (val) async {
                                controller.rememberPassword();
                              }),
                        ),
                      ),
                    ),
                  ),

                  CommonWidget.getFieldSpacer(height: 30.0),
                  ButtonView(
                    buttonTextName: "continue".translate(),
                    color: AppColor.appPrimaryColor,
                    borderColor: AppColor.appPrimaryColor,
                    rxIsShowLoader: controller.rxIsShowLoader,
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        if (controller.passwordController.text.toString() != controller.confirmPasswordController.text.toString()) {
                          AlertHelper.showToast("newPasswordAndConfirmPasswordValidation".translate());
                        } else if (!controller.rxIsShowLoader.value) {
                          controller.callResetPasswordAPI();
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

class _LocalAppBAr extends StatelessWidget {
  const _LocalAppBAr({
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