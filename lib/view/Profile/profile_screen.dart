import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/custom/button_view.dart';
import 'package:mecazone/helper/dialog_helper.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/view/Profile/edit_profile_screen.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/view/Profile/profile_controller.dart';
import 'package:mecazone/custom/divider_view.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';


class ProfileScreen extends GetView<ProfileController>{
  static const route = '/ProfileScreen';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColor.appPrimaryColor,
        ),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(Get.width, kToolbarHeight),
            child: _LocalAppBar(controller),
          ),
          body: Container(
            height: screenHeight,
            color: context.theme.unselectedWidgetColor,
            child: Obx(
              () => Visibility(
                visible: controller.rxIsShowLoader.value,
                replacement: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: SMALL_PADDING),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.appWhiteColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15, vertical: SMALL_PADDING),
                        child: LayoutBuilder(
                          builder: (context, constraints) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonWidget.getFieldSpacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: constraints.maxWidth * 0.40,
                                    child: Text(
                                      "name".translate(),
                                      style: Fonts.regularLabelTextStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.60,
                                    child: Text(
                                      ("${CommonWidget.user!.firstName}  ${CommonWidget.user!.lastName}"),
                                      style: Fonts.regularTextStyle,
                                      textDirection: TextDirection.rtl,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: SMALL_PADDING_15),
                                child: DividerView(
                                  width: constraints.maxWidth * 0.98,
                                  height: 1.0,
                                  color: AppColor.appDividerColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: constraints.maxWidth * 0.40,
                                    child: Text(
                                      "email".translate(),
                                      style: Fonts.regularLabelTextStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.60,
                                    child: Text(
                                      CommonWidget.user!.email ?? "",
                                      style: Fonts.regularTextStyle,
                                      textDirection: TextDirection.rtl,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: SMALL_PADDING_15),
                                child: DividerView(
                                  width: constraints.maxWidth * 0.98,
                                  height: 1.0,
                                  color: AppColor.appDividerColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: constraints.maxWidth * 0.40,
                                    child: Text(
                                      "mobile".translate(),
                                      style: Fonts.regularLabelTextStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.60,
                                    child: Text(
                                      CommonWidget.user!.phone ?? "",
                                      style: Fonts.regularTextStyle,
                                      textDirection: TextDirection.rtl,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),

                              if (CommonWidget.user!.profileTypeId == USER_TYPE_1057_PROFESSIONAL)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: SMALL_PADDING_15),
                                  child: DividerView(
                                    width: constraints.maxWidth * 0.98,
                                    height: 1.0,
                                    color: AppColor.appDividerColor,
                                  ),
                                ),
                              if (CommonWidget.user!.profileTypeId == USER_TYPE_1057_PROFESSIONAL)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: constraints.maxWidth * 0.40,
                                      child: Text(
                                        "status".translate(),
                                        style: Fonts.regularLabelTextStyle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.60,
                                      child: Text(
                                        (CommonWidget.user!.isActive == true) ? "active".translate() : "inactive".translate(),
                                        style: Fonts.regularTextStyle.copyWith(
                                        color:(CommonWidget.user!.isActive == true)? AppColor.appGreenColor: AppColor.appRedColor),
                                        textDirection: TextDirection.rtl,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                  ],
                                ),
                              if (CommonWidget.user!.profileTypeId == USER_TYPE_1057_PROFESSIONAL)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: SMALL_PADDING_15),
                                  child: DividerView(
                                    width: constraints.maxWidth * 0.98,
                                    height: 1.0,
                                    color: AppColor.appDividerColor,
                                  ),
                                ),
                              if (CommonWidget.user!.profileTypeId == USER_TYPE_1057_PROFESSIONAL)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: constraints.maxWidth * 0.40,
                                      child: Text(
                                        "certification".translate(),
                                        style: Fonts.regularLabelTextStyle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.60,
                                      child: Text(
                                        (CommonWidget.user!.isCertificate == true)
                                            ? "certifiedAccount".translate()
                                            : "        -          ",
                                        style: Fonts.regularTextStyle,
                                        textDirection: TextDirection.rtl,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              CommonWidget.getFieldSpacer(),
                            ],
                          ),
                        ),
                      ),

                      CommonWidget.getFieldSpacer(height: 30.0),
                      ButtonView(
                          buttonTextName: "disconnect".translate(),
                          color: context.theme.canvasColor,
                          borderColor: context.theme.canvasColor,
                          rxIsShowLoader: controller.rxIsShowLoader,
                          style: Fonts.buttonStyle.copyWith(color: AppColor.appPrimaryColor),
                          onPressed: () {
                            DialogHelper.showConfirmDialogAlert(context,
                                dialogDesc: "disconnectDesc".translate(),
                                positiveBtnText: "yes",
                                negativeBtnText: "no",
                                isDisplayIcon: true,
                                icon: 'ic_logout.svg',
                                callback: (val) {
                                  if (val == true) {
                                    controller.callDisconnectAPI();
                                  }
                                });
                          }
                      ),
                    ],
                  ),
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    backgroundColor: AppColor.appPrimaryColor,
                    valueColor: AlwaysStoppedAnimation(AppColor.appBlackColor),
                  ),
                ),
              )
            ),
          ),
        ),
      );
  }
}

// ignore: must_be_immutable
class _LocalAppBar extends StatelessWidget {
  late ProfileController controller;
  _LocalAppBar(this.controller);

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
            Get.back(result: true);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
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
          "profile".translate(),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appWhiteColor),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: SMALL_PADDING, right: MAIN_PADDING),
          child: InkWell(
            onTap: () {
              Get.toNamed(EditProfileScreen.route)?.then((value) {
                if(value == true) {
                  controller.callGetProfileDataAPI();
                }
              });
            },
            child: SvgPicture.asset(
                AssetsHelper.getSVGIcon('ic_edit.svg'),
                colorFilter: ColorFilter.mode(AppColor.appWhiteColor, BlendMode.srcIn)
            ),
          ),
        )
      ],
    );
  }
}

