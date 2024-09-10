import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/custom/button_view.dart';
import 'package:mecazone/custom/direction_view_rtl.dart';
import 'package:mecazone/view/Register/register_controller.dart';
import 'package:mecazone/helper/dialog_helper.dart';
import 'package:mecazone/view/Login/login_screen.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/custom/custom_textfield.dart';
import 'package:mecazone/helper/shared_pref.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/dropdown_search_helper.dart';
import 'package:mecazone/helper/navigator_helper.dart';
import 'package:mecazone/helper/regex.dart';
import 'package:mecazone/helper/validation_helper.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/model/country_data_model.dart';

/// :  The focus node need some Fixing thank you for cheking
class RegisterScreen extends GetView<RegisterController> {
  static const route = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  //ALl Declaration should be inside a controller

  @override
  Widget build(BuildContext context) {
    return DirectionViewRTL(
      child: Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          appBar: PreferredSize(
              preferredSize: Size(Get.width, kToolbarHeight),
              child: const _LocalAppBAr()),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(MAIN_PADDING),
            child: Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    "createYourAccount".translate(),
                    textAlign: TextAlign.center,
                    style: context.theme.textTheme.labelLarge,
                  ),
                  CommonWidget.getFieldSpacer(height: 40.0),

                  /// : FIRST NAME
                  CustomTextField(
                    tecController: controller.firstNameController,
                    focusNode: controller.nodes[0],
                    inputFormatters: [LengthLimitingTextInputFormatter(100)],
                    hintText: 'enterFirstName'.translate(),
                    prefixIcon: "ic_profile.svg",
                    validator: (value) => ValidationHelper.checkBlankValidation(context, value!, "firstNameValidation"),
                  ),
                  CommonWidget.getFieldSpacer(height: 15.0),

                  /// : LAST NAME
                  CustomTextField(
                    tecController: controller.lastNameController,
                    focusNode: controller.nodes[1],
                    inputFormatters: [LengthLimitingTextInputFormatter(100)],
                    hintText: "enterLastName".translate(),
                    prefixIcon: "ic_profile.svg",
                    // validator: (value) =>ValidationHelper.checkBlankValidation(context, value!, "lastNameValidation"),
                  ),
                  CommonWidget.getFieldSpacer(height: 15.0),

                  /// : EMAIL
                  CustomTextField(
                      tecController: controller.emailController,
                      focusNode: controller.nodes[3],
                      //?INPUT FORMATTER IS Common it should be a defualt values
                      inputFormatters: [LengthLimitingTextInputFormatter(100)],
                      hintText: "enterEmailID".translate(),
                      prefixIcon: "ic_email.svg",
                      validator: (value) => (controller.mobileNoController.text.trim().isEmpty &&
                          controller.emailController.text.trim().isEmpty) || (value?.trim().isNotEmpty == true)
                          ? ValidationHelper.checkEmailValidation(context, value ?? '')
                          : null
                      ),
                  CommonWidget.getFieldSpacer(height: 15.0),

                  /// : MOBILE NO
                  Row(
                    children: [
                      SizedBox(
                        width: 95.0,
                        child: DropdownButtonHideUnderline(
                          child: DropdownSearch<CountryData>(
                            enabled: false,
                            validator: (value) =>
                                controller.emailController.text.trim().isEmpty && controller.mobileNoController.text.isEmpty
                                    ? ValidationHelper.checkMobileNoValidation(context, controller.mobileNoController.text, validationMsg: "")
                                    : null ,
                            popupProps: PopupProps.bottomSheet(
                              showSearchBox: true,
                              title: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0)),
                                    color: AppColor.appWhiteColor,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: SMALL_PADDING),
                                  width: MediaQuery.of(context).size.width,
                                  height: 50.0,
                                  child: Row(children: [
                                    InkWell(
                                      onTap: NavigatorHelper.remove,
                                      child: SizedBox(
                                        width: 35.0,
                                        height: 35.0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: SMALL_PADDING),
                                          child: SvgPicture.asset(
                                            AssetsHelper.getSVGIcon('ic_back.svg'),
                                            height: 30.0,
                                            width: 30.0,
                                            colorFilter: ColorFilter.mode(AppColor.appBlackColor, BlendMode.srcIn)
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Center(
                                            child: Padding(
                                                padding:const EdgeInsets.symmetric(horizontal:MAIN_PADDING),
                                                child: Text(
                                                  'chooseCountry'.translate(),
                                                  textAlign: TextAlign.center,
                                                  overflow:TextOverflow.ellipsis,
                                                  style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appPrimaryColor)
                                                )
                                            )
                                        )
                                    )
                                  ])),
                              searchFieldProps: TextFieldProps(
                                style: context.theme.textTheme.headlineSmall,
                                controller: controller.countrySearchController,
                                decoration: DropDownSearchHelper.getBottomSheetSearchFieldDecoration(
                                    hintText: "searchCountry",
                                    hasFocused: controller.nodes[4].hasFocus
                                ),
                              ),
                              bottomSheetProps:DropDownSearchHelper.getBottomSheetProps(),
                            ),
                            selectedItem: controller.selectedCountry.value,
                            dropdownButtonProps:DropDownSearchHelper.getDropDownButtonProps(),
                            dropdownDecoratorProps:DropDownSearchHelper.getDropDownDecoratorProps(context,hasFocused: controller.nodes[2].hasFocus),
                            dropdownBuilder: (context, selectedItem) {
                              return SizedBox(
                                //Why the height??
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
                              //?SetState or we are using Getx?
                              /*setState(() {
                                selectedCountry = data!;
                              })*/
                              controller.selectedCountry(data);
                            },
                            itemAsString: (CountryData? c) => " +${c!.countryCode!} ${c.countryName!}",
                          ),
                        ),
                      ),
                      CommonWidget.getFieldSpacer(width: 5.0),
                      Expanded(
                        child: CustomTextField(
                          tecController: controller.mobileNoController,
                          focusNode: controller.nodes[4],
                          textInputType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(12),
                            FilteringTextInputFormatter.allow(Regex.onlyDigits)
                          ],
                          prefixIcon: "ic_call.svg",
                          hintText: "enterMobileNo".translate(),
                          validator: (value) => (controller.mobileNoController.text.trim().isEmpty &&
                              controller.emailController.text.trim().isEmpty) || (value?.trim().isNotEmpty == true)
                              ? ValidationHelper.checkMobileNoValidation(context, value ?? '')
                              : null
                        ),
                      )
                    ],
                  ),
                  CommonWidget.getFieldSpacer(height: 15.0),

                  /// : PASSWORD FIELD
                  CustomTextField(
                    tecController: controller.passwordController,
                    focusNode: controller.nodes[5],
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
                    focusNode: controller.nodes[6],
                    isPassword: true,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                      FilteringTextInputFormatter.deny(RegExp(r'\s'))
                    ],
                    prefixIcon: 'ic_password.svg',
                    hintText: "enterConfirmPassword".translate(),
                    validator: (value) =>
                        ValidationHelper.checkConfirmPasswordValidation(context,
                            value!, controller.confirmPasswordController.text),
                    textInputAction: TextInputAction.done,
                    enableSuggestions: false,
                    isShowSuffixIcon: true,
                  ),
                  CommonWidget.getFieldSpacer(height: 15.0),

                  /// : PROFILE TYPE
                  //?NO NEED FOR LAYOUT BUILDER THIS ONLY FOR THE MOBILE BRO!!!!
                  LayoutBuilder(
                    builder: (context, constraints) => Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Builder(builder: (context) {
                              final isCUSTOMER =
                                  controller.rxProfileType.value ==
                                      USER_TYPE_1056_CUSTOMER;
                              return SizedBox(
                                width: constraints.maxWidth * 0.48,
                                height: 45,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    controller
                                        .rxProfileType(USER_TYPE_1056_CUSTOMER);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(isCUSTOMER
                                              ? context.theme.canvasColor
                                              : context.theme.unselectedWidgetColor),
                                      elevation: MaterialStateProperty.all(0.0),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: BorderSide(
                                              width: 1.0,
                                              color: isCUSTOMER
                                                  ? context.theme.primaryColorDark
                                                  : context.theme.unselectedWidgetColor),
                                        ),
                                      )),
                                  icon: SvgPicture.asset(
                                    AssetsHelper.getSVGIcon('ic_arrow_online.svg'),
                                    height: 18.0,
                                    colorFilter: ColorFilter.mode(isCUSTOMER? context.theme.primaryColorDark: context.theme.primaryColorLight, BlendMode.srcIn)
                                  ),
                                  label: Text(
                                    "customer".translate(),
                                    style: Fonts.regularTextStyle.copyWith(
                                      color: controller.rxProfileType.value ==
                                              USER_TYPE_1056_CUSTOMER
                                          ? context.theme.primaryColorDark
                                          : context.theme.primaryColorLight,
                                    ),
                                  ),
                                ),
                              );
                            }),
                            CommonWidget.getFieldSpacer(
                                width: constraints.maxWidth * 0.02),
                            /// :  common Extract the widget
                            //THIS BUTTON IS Repetitive
                            SizedBox(
                              width: constraints.maxWidth * 0.48,
                              height: 45,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  DialogHelper.showConfirmDialogAlert(context,
                                      dialogDesc: "accountDialogDescription".translate(),
                                      positiveBtnText: "confirm",
                                      negativeBtnText: "cancel",
                                      isDisplayIcon: true,
                                      icon: 'ic_store.svg', callback: (val) {
                                    if (val == true) {
                                      controller.rxProfileType(USER_TYPE_1057_PROFESSIONAL);
                                    }
                                  });
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        controller.rxProfileType.value == USER_TYPE_1057_PROFESSIONAL
                                            ? context.theme.canvasColor
                                            : context.theme.unselectedWidgetColor),
                                    elevation: MaterialStateProperty.all(0.0),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            width: 1.0,
                                            color: controller .rxProfileType.value == USER_TYPE_1057_PROFESSIONAL
                                                ? context.theme.primaryColorDark
                                                : context.theme.unselectedWidgetColor),
                                      ),
                                    )),
                                icon: SvgPicture.asset(
                                  AssetsHelper.getSVGIcon('ic_store.svg'),
                                  height: 18.0,
                                  colorFilter: ColorFilter.mode(controller.rxProfileType.value == USER_TYPE_1057_PROFESSIONAL ? context.theme.primaryColorDark : context.theme.primaryColorLight, BlendMode.srcIn)
                                ),
                                label: Text(
                                  "professional".translate(),
                                  style: Fonts.regularTextStyle.copyWith(
                                    color: controller.rxProfileType.value == USER_TYPE_1057_PROFESSIONAL ? context.theme.primaryColorDark : context.theme.primaryColorLight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  CommonWidget.getFieldSpacer(height: 30.0),

                  /// : NEXT BUTTON
                  ButtonView(
                    buttonTextName: "next".translate(),
                    color: context.theme.primaryColorDark,
                    borderColor: context.theme.primaryColorDark,
                    //*IT SHOULD NOT BE RX!!!!! Rx is sub for Object you should pass an object and get the value from RX!!!!!
                    rxIsShowLoader: controller.rxIsShowLoader,
                    onPressed: () {
                      if (controller.rxIsShowLoader.isFalse) {
                        SharedPref.savePreferenceValue(kPrefKeyPassword,controller.confirmPasswordController.text.trim());
                        controller.signUp();
                      }
                    },
                  ),
                  CommonWidget.getFieldSpacer(height: 30.0),

                  SizedBox(
                    width: screenWidth,
                    height: appbarHeight,
                    child: InkWell(
                      radius: 0.0,
                      onTap: () {
                        NavigatorHelper.removeAllAndOpen(const LoginScreen());
                      },
                      child: SizedBox(
                        width: screenWidth,
                        child: RichText(
                          text: TextSpan(
                              text: "alreadyHaveAnAccount".translate(),
                              style: context.theme.textTheme.bodyLarge,
                              children: [
                                TextSpan(
                                    text:
                                    " ${"login".translate()}",
                                    style: Fonts.cardTextStyle.copyWith(
                                        color: context.theme.primaryColorDark))
                              ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  /// : REGISTER API CALL
  //MOVE TO CONTROLLER
  /*_callSignUpAPI() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState!.validate()) {
      rxIsShowLoader.value = true;

      Map<String, String> params = {
        "FirstName": tecFirstNameController.text.trim().toString(),
        "LastName": tecLastNameController.text.trim().toString(),
        "Email": tecEmailController.text.trim().toString(),
        "Phone": tecMobileNoController.text.trim().toString(),
        "Password": tecPasswordController.text.trim().toString(),
        "ConfirmPassword": tecConfirmPasswordController.text.trim().toString(),
        "ProfileType": rxProfileType.value == USER_TYPE_1056_CUSTOMER
            ? USER_TYPE_1056_CUSTOMER.toString()
            : USER_TYPE_1057_PROFESSIONAL.toString(),
        "CountryId": selectedCountry?.countryId!.toString() ?? "",
        "Otp": "",
        "PairId": "",
        "CreatedBy": "0",
      };

      APIResponse? apiResponse = await UserController.register(params);
      rxIsShowLoader.value = false;

      if (apiResponse != null) {
        if (apiResponse.success! == true) {
          if (tecEmailController.text.isNotEmpty &&
              tecMobileNoController.text.isNotEmpty) {
            NavigatorHelper.goTo(OTPVerificationScreen(
              email: tecEmailController.text,
              mobileNo: tecMobileNoController.text,
              userId: apiResponse.result!.user!.id,
              countryCode: selectedCountry!.countryCode,
            ));
          } else {
            NavigatorHelper.goTo(VerificationScreen(
              otpSentByText: tecEmailController.text.trim().isNotEmpty
                  ? tecEmailController.text
                  : tecMobileNoController.text,
              email: tecEmailController.text,
              mobileNo: tecMobileNoController.text,
              userId: apiResponse.result!.user!.id,
              countryCode: selectedCountry!.countryCode,
              isFromRegister: true,
            ));
          }
        }
      }
    } else {}
  }*/
  /// : CALL GET  COUNTRY DATA API

  //?NEED TO BE REMOVED
  /*_callCountryDataAPI() async {
    // vnIsShowLoader.value = true;

    APIResponse? apiResponse = await CMSController.getCountryData();
    // vnIsShowLoader.value = false;

    if (apiResponse != null) {
      if (apiResponse.success! == true &&
          apiResponse.result!.countryList!.isNotEmpty) {
        setState(() {
          // lstCountry!.clear();
          lstCountry.addAll(apiResponse.result!.countryList!);
          if (lstCountry.isNotEmpty) {
            selectedCountry = lstCountry.first;
          }
        });
      }
    }
  }*/
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
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            InkWell(
                onTap: Get.back,
                child: SvgPicture.asset(
                    AssetsHelper.getSVGIcon('ic_back_round.svg'),
                    height: 40.0,
                    width: 40.0)
            )
          ])),
      backgroundColor: context.theme.scaffoldBackgroundColor,
    );
  }
}
