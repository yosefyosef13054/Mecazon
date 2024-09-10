import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/custom/button_view.dart';
import 'package:mecazone/custom/direction_view_rtl.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/view/Login/login_controller.dart';
import 'package:mecazone/helper/navigator_helper.dart';
import 'package:mecazone/model/country_data_model.dart';
import 'package:mecazone/view/Register/register_screen.dart';
import 'package:mecazone/view/ForgotPassword/forgot_password_screen.dart';
import 'package:mecazone/custom/custom_textfield.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/dropdown_search_helper.dart';
import 'package:mecazone/helper/regex.dart';
import 'package:mecazone/helper/shared_pref.dart';
import 'package:mecazone/helper/validation_helper.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class LoginScreen extends GetView<LoginController> {
  static const route = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DirectionViewRTL(
        child: Scaffold(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: MAIN_PADDING, vertical: MAIN_PADDING),
                child: Form(
                    key: controller.formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CommonWidget.getFieldSpacer(height: 40.0),
                          SvgPicture.asset(
                            AssetsHelper.getSVGIcon("ic_logo.svg"),
                            height: 120,
                            width: 120,
                          ),

                          CommonWidget.getFieldSpacer(height: 30.0),
                          SizedBox(
                            width: screenWidth,
                            child: Text(
                              'welcomeBack'.translate(),
                              textAlign: TextAlign.center,
                              style: context.theme.textTheme.labelLarge,
                            ),
                          ),

                          CommonWidget.getFieldSpacer(height: 15.0),
                          SizedBox(
                            width: screenWidth,
                            child: Text(
                              "loginToYourAccount".translate(),
                              textAlign: TextAlign.center,
                              style: context.theme.textTheme.bodyLarge,
                            ),
                          ),
                          CommonWidget.getFieldSpacer(height: 30.0),

                          /// : LOGIN TYPE - EMAIL , MOBILE
                          LayoutBuilder(
                            builder: (context, constraints) => Obx(
                              () =>  Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: constraints.maxWidth * 0.48,
                                    height: 45,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        controller.rxIsLoginType(LOGIN_TYPE_1);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:MaterialStateProperty.all(controller.rxIsLoginType.value ==LOGIN_TYPE_1? context.theme.canvasColor: context.theme.unselectedWidgetColor),
                                          elevation:MaterialStateProperty.all(0.0),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              side: BorderSide(
                                                  width: 1.0,
                                                  color: controller.rxIsLoginType.value ==LOGIN_TYPE_1? context.theme.primaryColorDark: context.theme.unselectedWidgetColor),
                                            ),
                                          )),
                                      icon: SvgPicture.asset(
                                        AssetsHelper.getSVGIcon('ic_email.svg'),
                                        height: 18.0,
                                        colorFilter: ColorFilter.mode(controller.rxIsLoginType.value ==LOGIN_TYPE_1? context.theme.primaryColorDark: context.theme.canvasColor,BlendMode.srcIn)
                                      ),
                                      label: Text(
                                        "email".translate(),
                                        style:
                                        Fonts.regularTextStyle.copyWith(
                                          color: controller.rxIsLoginType.value ==LOGIN_TYPE_1? context.theme.primaryColorDark: context.theme.primaryColorLight,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(width: constraints.maxWidth * 0.02),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.48,
                                    height: 45,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        controller
                                            .rxIsLoginType(LOGIN_TYPE_2);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              controller.rxIsLoginType.value ==LOGIN_TYPE_2? context.theme.canvasColor: context.theme.unselectedWidgetColor),
                                          elevation:
                                          MaterialStateProperty.all(0.0),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              side: BorderSide(
                                                  width: 1.0,
                                                  color: controller.rxIsLoginType.value ==LOGIN_TYPE_2? context.theme.primaryColorDark: context.theme.unselectedWidgetColor),
                                            ),
                                          )),
                                      icon: SvgPicture.asset(
                                        AssetsHelper.getSVGIcon(
                                            'ic_call.svg'),
                                        height: 18.0,
                                        colorFilter: ColorFilter.mode(controller.rxIsLoginType.value == LOGIN_TYPE_2 ? context.theme.primaryColorDark : context.theme.primaryColorLight,BlendMode.srcIn)
                                      ),
                                      label: Text(
                                        "mobile".translate(),
                                        style:
                                        Fonts.regularTextStyle.copyWith(
                                          color: controller.rxIsLoginType.value == LOGIN_TYPE_2? context.theme.primaryColorDark: context.theme.primaryColorLight,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          CommonWidget.getFieldSpacer(height: 15.0),

                          Obx(
                            () => Visibility(
                                visible: controller.rxIsLoginType.value ==LOGIN_TYPE_1,
                                replacement: Row(
                                  children: [
                                    SizedBox(
                                      width: 95.0,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownSearch<CountryData>(
                                          enabled: false,
                                          validator: (value) => controller.rxIsLoginType.value ==LOGIN_TYPE_2 && controller.mobileNoController.text.trim().isEmpty
                                              ? ValidationHelper.checkMobileNoValidation(context, controller.mobileNoController.text,validationMsg: "")
                                              : null,
                                          popupProps: PopupProps.bottomSheet(
                                            showSearchBox: true,
                                            title: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(
                                                          10.0),
                                                      topRight:
                                                      Radius.circular(
                                                          10.0)),
                                                  color:
                                                  AppColor.appWhiteColor,
                                                ),
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    SMALL_PADDING),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 50.0,
                                                child: Row(children: [
                                                  InkWell(
                                                    onTap: NavigatorHelper
                                                        .remove,
                                                    child: SizedBox(
                                                      width: 35.0,
                                                      height: 35.0,
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            SMALL_PADDING),
                                                        child:
                                                        SvgPicture.asset(
                                                          AssetsHelper.getSVGIcon('ic_back.svg'),
                                                          height: 30.0,
                                                          width: 30.0,
                                                          colorFilter: ColorFilter.mode(AppColor.appBlackColor,BlendMode.srcIn)
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Center(
                                                          child: Padding(
                                                              padding: const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                  MAIN_PADDING),
                                                              child: Text(
                                                                'chooseCountry'
                                                                    .translate(),
                                                                textAlign:
                                                                TextAlign
                                                                    .center,
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                style: Fonts
                                                                    .cardTitleTextStyle
                                                                    .copyWith(
                                                                    color:
                                                                    context.theme.primaryColorDark),
                                                              ))))
                                                ])),
                                            searchFieldProps: TextFieldProps(
                                              style: context.theme.textTheme.headlineSmall,
                                              controller: controller
                                                  .countrySearchController,
                                              decoration: DropDownSearchHelper.getBottomSheetSearchFieldDecoration(
                                                  hintText: "searchCountry",
                                                  hasFocused: controller.nodes[3].hasFocus
                                              ),
                                            ),
                                            bottomSheetProps: DropDownSearchHelper.getBottomSheetProps(),
                                          ),
                                          selectedItem: controller.selectedCountry.value,
                                          dropdownButtonProps:
                                          DropDownSearchHelper.getDropDownButtonProps(),
                                          dropdownDecoratorProps:
                                          DropDownSearchHelper.getDropDownDecoratorProps(context,hasFocused: controller.nodes[3].hasFocus),
                                          dropdownBuilder:(context, selectedItem) {
                                            return SizedBox(
                                              height: 35.0,
                                              child: Center(
                                                child: Text(
                                                  selectedItem != null
                                                      ? "+${selectedItem.countryCode}"
                                                      : " + ",
                                                  style: context.theme.textTheme.headlineMedium,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          },
                                          items: controller.lstCountry,
                                          onChanged: (CountryData? data) {
                                            controller.selectedCountry(data);
                                          },
                                          itemAsString: (CountryData? c) =>
                                          " +${c!.countryCode!} ${c.countryName!}",
                                        ),
                                      ),
                                    ),
                                    CommonWidget.getFieldSpacer(width: 5.0),
                                    Expanded(
                                        child: CustomTextField(
                                            tecController:
                                            controller.mobileNoController,
                                            focusNode: controller.nodes[1],
                                            textInputType:
                                            TextInputType.number,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  12),
                                              FilteringTextInputFormatter
                                                  .allow(Regex.onlyDigits)
                                            ],
                                            prefixIcon: "ic_call.svg",
                                            hintText:
                                            "enterMobileNo".translate(),
                                            validator: (value) => controller.mobileNoController.text.trim().isEmpty ||
                                                controller.emailController.text.trim().isEmpty ||
                                                value?.trim().isEmpty == true
                                                ? ValidationHelper.checkMobileNoValidation(context, value ?? '')
                                                : null
                                        ))
                                  ],
                                ),
                                child: CustomTextField(
                                  tecController: controller.emailController,
                                  focusNode: controller.nodes[0],
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(100)
                                  ],
                                  hintText: "enterEmailID".translate(),
                                  prefixIcon: "ic_email.svg",
                                  validator: (value) =>
                                      ValidationHelper.checkEmailValidation(
                                          context, value!),
                                )),
                          ),
                          CommonWidget.getFieldSpacer(height: 15.0),

                          CustomTextField(
                            tecController: controller.passwordController,
                            focusNode: controller.nodes[2],
                            isPassword: true,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                              FilteringTextInputFormatter.deny(RegExp(r'\s'))
                            ],
                            prefixIcon: 'ic_password.svg',
                            hintText: "enterPassword".translate(),
                            validator: (value) =>ValidationHelper.checkBlankValidation(context, value!, "passwordValidation"),
                            textInputAction: TextInputAction.done,
                            enableSuggestions: false,
                            isShowSuffixIcon: true,
                          ),
                          CommonWidget.getFieldSpacer(height: 15.0),

                          SizedBox(
                            width: screenWidth,
                            child: Text(
                              "agreeToTheTermsOfService".translate(),
                              textAlign: TextAlign.center,
                              style: context.theme.textTheme.bodyLarge,
                            ),
                          ),

                          CommonWidget.getFieldSpacer(height: 30.0),
                          ButtonView(
                            buttonTextName: "login".translate(),
                            color: context.theme.primaryColorDark,
                            borderColor: context.theme.primaryColorDark,
                            rxIsShowLoader: controller.rxIsShowLoader,
                            onPressed: () {
                              if (!controller.rxIsShowLoader.value) {
                                SharedPref.savePreferenceValue(
                                    kPrefKeyPassword,
                                    controller.passwordController.text
                                        .trim());
                                controller.signIn();
                              }
                            },
                          ),

                          CommonWidget.getFieldSpacer(height: 30.0),
                          ButtonView(
                            buttonTextName: "forgotPassword".translate(),
                            color: context.theme.scaffoldBackgroundColor,
                            height: 30.0,
                            borderColor: context.theme.scaffoldBackgroundColor,
                            style: Fonts.buttonStyle.copyWith(
                                color: context.theme.primaryColorDark,
                                fontSize: 14.0),
                            onPressed: () {
                              Get.toNamed(ForgotPasswordScreen.route);
                            },
                          ),

                          CommonWidget.getFieldSpacer(height: 30.0),

                          SizedBox(
                              width: screenWidth,
                              height: appbarHeight,
                              child: InkWell(
                                  radius: 0.0,
                                  onTap: () =>
                                      Get.toNamed(RegisterScreen.route),
                                  child: RichText(
                                    text: TextSpan(
                                        text:
                                        "dontHaveAnAccount".translate(),
                                        style: context.theme.textTheme.bodyLarge,
                                        children: [
                                          TextSpan(
                                              text:" ${"register".translate()}",
                                              style: Fonts.cardTextStyle.copyWith(color: context.theme.primaryColorDark))
                                        ]),
                                    textAlign: TextAlign.center,
                                  )))
                        ])))));
  }
}
