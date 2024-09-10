import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/view/Profile/edit_profile_controller.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/custom/custom_textfield.dart';
import 'package:mecazone/custom/button_view.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/regex.dart';
import 'package:mecazone/helper/validation_helper.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/constants.dart';

class EditProfileScreen extends GetView<EditProfileController>{

  static const route = '/EditProfileScreen';
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColor.appPrimaryColor,
        ),
        child: Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          appBar: PreferredSize(
            preferredSize: Size(Get.width, kToolbarHeight),
            child: const _LocalAppBar(),
          ),
          body: SizedBox(
            height: screenHeight,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15, vertical: SMALL_PADDING),
              child: Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// : FIRST NAME
                    CustomTextField(
                      tecController: controller.firstNameController,
                      focusNode: controller.nodes[0],
                      inputFormatters: [LengthLimitingTextInputFormatter(100)],
                      hintText: 'enterFirstName'.translate(),
                      prefixIcon: "ic_profile.svg",
                      validator: (value) => ValidationHelper.checkBlankValidation(
                          context, value!, "firstNameValidation"),
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
                        focusNode: controller.nodes[2],
                        inputFormatters: [LengthLimitingTextInputFormatter(100)],
                        hintText: "enterEmailID".translate(),
                        prefixIcon: "ic_email.svg",
                        validator: (value) => controller.mobileNoController.text.trim().isEmpty ||
                            controller.emailController.text.trim().isEmpty || value?.trim().isEmpty == true
                            ? ValidationHelper.checkEmailValidation( context, value ?? '')
                            : null
                    ),
                    CommonWidget.getFieldSpacer(height: 15.0),

                    /// : MOBILE NO
                    CustomTextField(
                        tecController: controller.mobileNoController,
                        focusNode: controller.nodes[3],
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12),
                          FilteringTextInputFormatter.allow(Regex.onlyDigits)
                        ],
                        prefixIcon: "ic_call.svg",
                        hintText: "enterMobileNo".translate(),
                        validator: (value) => controller.mobileNoController.text.trim().isEmpty || controller.emailController.text.trim().isEmpty || value?.trim().isEmpty == true
                            ? ValidationHelper.checkMobileNoValidation(context, value ?? '')
                            : null
                    ),
                    CommonWidget.getFieldSpacer(height: 15.0),

                    /// : NEXT BUTTON
                    ButtonView(
                      buttonTextName: "save".translate(),
                      color: AppColor.appPrimaryColor,
                      borderColor: AppColor.appPrimaryColor,
                      rxIsShowLoader: controller.rxIsShowLoader,
                      onPressed: () {
                        if (controller.rxIsShowLoader.value != true) {
                          controller.callEditProfileAPI();
                        }
                      },
                    ),
                    CommonWidget.getFieldSpacer(height: 30.0),
                  ],
                ),
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
        backgroundColor: AppColor.appPrimaryColor, // Status bar color
        titleSpacing: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Get.back(result: false);
            },
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
              child: SvgPicture.asset(
                  AssetsHelper.getSVGIcon('ic_back.svg'),
                  height: 25.0,
                  width: 25.0,
                  colorFilter: ColorFilter.mode(AppColor.appWhiteColor, BlendMode.srcIn)
            ),
            ),
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING),
          child: Text(
            "editProfile".translate(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appWhiteColor),
          ),
        )
    );
  }
}