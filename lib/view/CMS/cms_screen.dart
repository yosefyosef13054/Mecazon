import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/view/CMS/cms_controller.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/constants.dart';

class CMSScreen extends GetView<CMSController>{

  static const route = '/CMSScreen';
  const CMSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: _AppBar(context,controller),
      body: SizedBox(
        height: screenHeight,
        child: Obx(
          () => Visibility(
              visible: controller.isShowLoader.value,
              replacement: Visibility(
                visible: controller.htmlContents.value.isNotEmpty,
                child: InAppWebView(
                  initialData: InAppWebViewInitialData(
                    data:  controller.htmlContents.value
                  ),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      mediaPlaybackRequiresUserGesture:false,
                      javaScriptEnabled: true,
                      useShouldInterceptAjaxRequest: true,
                      javaScriptCanOpenWindowsAutomatically:true,
                    ),
                    ios: IOSInAppWebViewOptions(),
                    android: AndroidInAppWebViewOptions(
                        domStorageEnabled: true,
                        databaseEnabled: true,
                        clearSessionCache: true,
                        thirdPartyCookiesEnabled: true,
                        allowFileAccess: true,
                        geolocationEnabled: true,
                        allowContentAccess: true
                    ),
                  ),
                  onWebViewCreated: (InAppWebViewController webController){
                     controller.webViewController = webController;
                  }
                ),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: AppColor.appPrimaryColor,
                  backgroundColor: AppColor.appBlackColor,
                ),
              )
          ),
        ),
      ),
    );
  }
}

class _AppBar extends AppBar {
  _AppBar(BuildContext context,CMSController controller)
      : super(
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
        controller.titleName!,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: Fonts.cardTitleTextStyle
            .copyWith(color: AppColor.appWhiteColor),
      ),
    ),
  );
}
