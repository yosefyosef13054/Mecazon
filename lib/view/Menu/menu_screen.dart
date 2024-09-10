import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/navigator_helper.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/view/Language/language_screen.dart';
import 'package:mecazone/view/Menu/menu_controller.dart';
import 'package:mecazone/view/Notification/notification_list_screen.dart';
import 'package:mecazone/view/Profile/profile_screen.dart';
import 'package:mecazone/view/Request/request_list_screen.dart';
import 'package:mecazone/view/Store/store_list_screen.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/custom/divider_view.dart';
import 'package:mecazone/helper/dialog_helper.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/view/CMS/cms_screen.dart';
import 'package:mecazone/view/Subscription/subscription_list_screen.dart';
import 'package:mecazone/view/Wishlist/wishlist_screen.dart';

class MenuScreen extends GetView<MenusController>{
  static const route = '/MenuScreen';
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.appPrimaryColor,
      ),
      child: WillPopScope(
        onWillPop: () async {
          Get.back(result: true);
          return true;
        },
        child: Drawer(
          width: screenWidth,
          backgroundColor: context.theme.scaffoldBackgroundColor,
          child: SizedBox(
            height: screenHeight,
            child: Column(
              children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: AppColor.appPrimaryColor, // Status bar color
                  titleSpacing: 0.0,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        NavigatorHelper.remove(value: true);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: SMALL_PADDING),
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
                    padding:
                    const EdgeInsets.symmetric(horizontal: MAIN_PADDING),
                    child: Text(
                      "menu".translate(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appWhiteColor),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      /// : MY ACCOUNT MENU
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: SMALL_PADDING, vertical: SMALL_PADDING),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.appWhiteColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: SMALL_PADDING_15,
                              vertical: SMALL_PADDING),
                          child: LayoutBuilder(
                            builder: (context, constraints) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonWidget.getFieldSpacer(),
                                Text(
                                    "myAccount".translate(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Fonts.cardTitleTextStyle
                                ),
                                CommonWidget.getFieldSpacer(height: 5.0),
                                menuTileProfile(context, callBack: () {
                                  Get.toNamed(ProfileScreen.route);
                                }),
                                DividerView(
                                  width: constraints.maxWidth * 0.98,
                                  height: 1.0,
                                  color: AppColor.appDividerColor,
                                ),
                                if (CommonWidget.user!.profileTypeId == USER_TYPE_1056_CUSTOMER)
                                  menuTile(context,
                                      menuName: "myRequests",
                                      menuIcon: "ic_request.svg", callBack: () {
                                        Get.toNamed(RequestListScreen.route);
                                      }),
                                if (CommonWidget.user!.profileTypeId == USER_TYPE_1056_CUSTOMER)
                                  DividerView(
                                    width: constraints.maxWidth * 0.98,
                                    height: 1.0,
                                    color: AppColor.appDividerColor,
                                  ),
                                if (CommonWidget.user!.profileTypeId == USER_TYPE_1056_CUSTOMER)
                                  menuTile(context,
                                      menuName: "myWishlist",
                                      menuIcon: "ic_wishlist.svg",
                                      callBack: () {
                                        Get.toNamed(WishlistScreen.route);
                                      }),
                                if (CommonWidget.user!.profileTypeId == USER_TYPE_1056_CUSTOMER)
                                  DividerView(
                                    width: constraints.maxWidth * 0.98,
                                    height: 1.0,
                                    color: AppColor.appDividerColor,
                                  ),
                                if (CommonWidget.user!.profileTypeId == USER_TYPE_1056_CUSTOMER)
                                  menuTile(context,
                                      menuName: "myResearches",
                                      menuIcon: "ic_research.svg",
                                      callBack: () {}),
                                if (CommonWidget.user!.profileTypeId == USER_TYPE_1057_PROFESSIONAL)
                                  menuTile(context,
                                      menuName: "myStore",
                                      menuIcon: "ic_store.svg", callBack: () {
                                        Get.toNamed(StoreListScreen.route);
                                      }),
                                if (CommonWidget.user!.profileTypeId == USER_TYPE_1057_PROFESSIONAL)
                                  DividerView(
                                    width: constraints.maxWidth * 0.98,
                                    height: 1.0,
                                    color: AppColor.appDividerColor,
                                  ),
                                if (CommonWidget.user!.profileTypeId == USER_TYPE_1057_PROFESSIONAL)
                                  menuTile(context,
                                      menuName: "mySubscription",
                                      menuIcon: "ic_subscription.svg",
                                      callBack: () {
                                         Get.toNamed(
                                           SubscriptionListScreen.route
                                         );
                                      }
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// : GENERAL SETTING MENU
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: SMALL_PADDING),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.appWhiteColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15,vertical: SMALL_PADDING),
                          child: LayoutBuilder(
                            builder: (context, constraints) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonWidget.getFieldSpacer(),

                                Text(
                                    "generalSettings".translate(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Fonts.cardTitleTextStyle
                                ),
                                CommonWidget.getFieldSpacer(height: 5.0),

                                Obx(
                                      () => menuTile(
                                      context,
                                      menuName: "notifications",
                                      menuIcon: "ic_notification.svg",
                                      isShowSwitch: true,
                                      vnSwitch: controller.vnIsShowNotification.value,
                                      callBack: () {
                                        Get.toNamed(NotificationListScreen.route);
                                      },
                                      switchCallBack: (){
                                        controller.changeNotification();
                                      }),
                                ),

                                DividerView(
                                  width: constraints.maxWidth * 0.98,
                                  height: 1.0,
                                  color: AppColor.appDividerColor,
                                ),
                                // AppGlobal.getFieldSpacer(),

                                Obx(
                                      () => menuTile(
                                      context,
                                      menuName: "darkMode",
                                      menuIcon: "ic_theme.svg",
                                      isShowSwitch: true,
                                      vnSwitch: controller.vnIsDarkMode.value,
                                      callBack: () {

                                      },
                                      switchCallBack: (){
                                        controller.changeThemeMode();
                                      }
                                  ),
                                ),

                                DividerView(
                                  width: constraints.maxWidth * 0.98,
                                  height: 1.0,
                                  color: AppColor.appDividerColor,
                                ),

                                // AppGlobal.getFieldSpacer(),
                                menuTile(
                                    context,
                                    menuName: "language",
                                    menuIcon: "ic_lang.svg", callBack: () {
                                  Get.toNamed(
                                    LanguageScreen.route,
                                    arguments: {
                                      'isFromMenu':true
                                    }
                                  );
                                }
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// : OTHERS MENU
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: SMALL_PADDING, vertical: SMALL_PADDING),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.appWhiteColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: SMALL_PADDING_15,
                              vertical: SMALL_PADDING),
                          child: LayoutBuilder(
                            builder: (context, constraints) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonWidget.getFieldSpacer(),

                                Text(
                                    "others".translate(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Fonts.cardTitleTextStyle
                                ),
                                CommonWidget.getFieldSpacer(height: 5.0),

                                menuTile(context,
                                    menuName: "contactUs",
                                    menuIcon: "ic_email_fill.svg",
                                    callBack: () {
                                      Get.toNamed(
                                          CMSScreen.route,
                                          arguments: {
                                            'cmsTypeId': CMS_TYPE_ID_1100_CONTACT,
                                            'titleName': "contactUs".translate()
                                          }
                                      );
                                    }),
                                DividerView(
                                  width: constraints.maxWidth * 0.98,
                                  height: 1.0,
                                  color: AppColor.appDividerColor,
                                ),
                                // AppGlobal.getFieldSpacer(),
                                menuTile(context,
                                    menuName: "aboutUs",
                                    menuIcon: "ic_about.svg", callBack: () {
                                      Get.toNamed(
                                          CMSScreen.route,
                                          arguments: {
                                            'cmsTypeId': CMS_TYPE_ID_1099_ABOUT,
                                            'titleName': "aboutUs".translate()
                                          }
                                      );
                                    }),
                                DividerView(
                                  width: constraints.maxWidth * 0.98,
                                  height: 1.0,
                                  color: AppColor.appDividerColor,
                                ),

                                // AppGlobal.getFieldSpacer(),
                                menuTile(context,
                                    menuName: "privacyPolicy",
                                    menuIcon: "ic_privacy_policy.svg",
                                    callBack: () {
                                      Get.toNamed(
                                          CMSScreen.route,
                                          arguments: {
                                            'cmsTypeId': CMS_TYPE_ID_1101_PRIVACY_POLICY,
                                            'titleName': "privacyPolicy".translate()
                                          }
                                      );
                                    }),
                                DividerView(
                                  width: constraints.maxWidth * 0.98,
                                  height: 1.0,
                                  color: AppColor.appDividerColor,
                                ),

                                menuTile(context,
                                    menuName: "rateTheApp",
                                    menuIcon: "ic_rate.svg", callBack: () {
                                      DialogHelper.showConfirmDialogAlert(
                                          context,
                                          dialogTitle: "rateTheApp".translate(),
                                          dialogDesc: "rateDescription".translate(),
                                          positiveBtnText: "rateTheApp",
                                          negativeBtnText: "mayBeLater",
                                          isDisplayIcon: false,
                                          callback: (val) async {
                                            if(val){
                                              if(Platform.isAndroid){
                                                controller.openUrl(GOOGLE_STORE_LINK);
                                              }else{
                                                controller.openUrl(APPLE_STORE_LINK);
                                              }
                                            }
                                          });
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// : LOGOUT MENU
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: SMALL_PADDING),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.appWhiteColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15,vertical: SMALL_PADDING),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              menuTile(
                                  context,
                                  menuName: "logOut",
                                  menuIcon: "ic_logout.svg", callBack: () {
                                DialogHelper.showConfirmDialogAlert(context,
                                    dialogDesc: "logoutDesc".translate(),
                                    positiveBtnText: "yes",
                                    negativeBtnText: "no",
                                    isDisplayIcon: true,
                                    icon: 'ic_logout.svg', callback: (val) {
                                      if (val == true) {
                                        controller.appLogout(isFromLogout: true);
                                      }
                                    });
                              }),
                            ],
                          ),
                        ),
                      ),

                      CommonWidget.getFieldSpacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget menuTile(BuildContext context,
      {required String menuName,
        required String menuIcon,
        Function? callBack,
        Function? switchCallBack,
        bool isShowSwitch = false,
        bool vnSwitch = false}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        callBack!();
      },
      leading: Container(
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(
            color: AppColor.appLightOrangeColor,
            borderRadius: BorderRadius.circular(5.0)),
        child: Padding(
          padding: const EdgeInsets.all(SMALL_PADDING),
          child: SvgPicture.asset(
              AssetsHelper.getSVGIcon(menuIcon),
              colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn)
          ),
        ),
      ),
      title: Text(
          menuName.translate(),
          style: Fonts.regularLabelTextStyle.copyWith(
              fontFamily: "AppLight"
          ),
          /*style: context.theme.textTheme.bodyLarge?.copyWith(
              fontFamily: "AppLight"
          ),*/
      ),
      trailing: Visibility(
        visible: isShowSwitch,
        replacement: Padding(
          padding: const EdgeInsets.all(SMALL_PADDING),
          child: SvgPicture.asset(
            AssetsHelper.getSVGIcon("ic_next.svg"),
            colorFilter: ColorFilter.mode(AppColor.appBlackColor, BlendMode.srcIn),
          ),
        ),
        child: Switch(
          onChanged: (bool val) {
            switchCallBack!();
            // vnSwitch = !val;
          },
          value: vnSwitch,
          activeColor: AppColor.appGreenColor,
          activeTrackColor: AppColor.appGreenColor.withOpacity(0.5),
          inactiveThumbColor: AppColor.appButtonGreyColor,
          inactiveTrackColor: AppColor.appButtonGreyColor.withOpacity(0.5),
          splashRadius: 5.0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }

  Widget menuTileProfile(BuildContext context, {Function? callBack}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        callBack!();
      },
      leading: Container(
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(
            color: AppColor.appLightOrangeColor,
            borderRadius: BorderRadius.circular(5.0)),
        child: Padding(
          padding: const EdgeInsets.all(SMALL_PADDING),
          child: Visibility(
            visible: CommonWidget.user!.profilePicture!.isNotEmpty,
            replacement: SvgPicture.asset(
                AssetsHelper.getSVGIcon("ic_account.svg"),
                colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn)
            ),
            child: CachedNetworkImage(
              imageUrl: CommonWidget.user!.profilePicture!,
              alignment: Alignment.center,
              fit: BoxFit.fill,
              errorWidget: (context, url, error) => SvgPicture.asset(
                  AssetsHelper.getSVGIcon("ic_account.svg"),
                  colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn)
              ),
            ),
          ),
        ),
      ),
      title: Text(
        "${CommonWidget.user!.firstName!} ${CommonWidget.user!.lastName!}",
          style: Fonts.regularLabelTextStyle.copyWith(
              fontFamily: "AppLight"
          )
      ),
      trailing: Padding(
        padding: const EdgeInsets.all(SMALL_PADDING),
        child: SvgPicture.asset(
            AssetsHelper.getSVGIcon("ic_next.svg"),
            colorFilter: ColorFilter.mode(AppColor.appBlackColor, BlendMode.srcIn)
        ),
      ),
    );
  }

}
