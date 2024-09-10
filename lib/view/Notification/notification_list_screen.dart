import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/view/Notification/notification_list_controller.dart';
import 'package:mecazone/custom/direction_view_rtl.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/tiles/notification_tile.dart';
import 'package:mecazone/utils/constants.dart';

class NotificationListScreen extends GetView<NotificationListController>{
  static const route = '/NotificationListScreen';
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DirectionViewRTL(
      child: WillPopScope(
        onWillPop: () async {
          Get.back(result: true);
          return true;
        },
        child: Scaffold(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            appBar: _AppBar(context),
            body: SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Obx(
                    () => Visibility(
                  visible: controller.vnIsShowLoader.value && controller.lstNotification.isEmpty,
                  replacement: controller.lstNotification.isNotEmpty
                      ? Stack(
                    children: [
                      Padding(
                        padding: controller.vnIsShowLoader.value
                            ? const EdgeInsets.only(bottom: 50.0)
                            : EdgeInsets.zero,
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15,vertical: SMALL_PADDING_15),
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            controller: controller.scrollController,
                            itemCount: controller.lstNotification.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: SMALL_PADDING),
                                child: NotificationTile(
                                    notification: controller.lstNotification[index]
                                ),
                              );
                            }),
                      ),
                      Visibility(
                        visible: controller.vnIsShowLoader.value,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: CircularProgressIndicator(
                            strokeWidth: 3.0,
                            backgroundColor: AppColor.appPrimaryColor,
                            valueColor:
                            AlwaysStoppedAnimation(AppColor.appWhiteColor),
                          ),
                        ),
                      )
                    ],
                  )
                      : Center(child: Text("dataNoAvailable".translate())),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      backgroundColor: AppColor.appPrimaryColor,
                      valueColor: AlwaysStoppedAnimation(AppColor.appWhiteColor),
                    ),
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }
}

class _AppBar extends AppBar {
  _AppBar(BuildContext context)
      : super(
    automaticallyImplyLeading: false,
    backgroundColor: AppColor.appPrimaryColor,
    // Status bar color
    titleSpacing: 0.0,
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Get.back(result: true);
        },
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
          child: SvgPicture.asset(
            AssetsHelper.getSVGIcon('ic_back.svg'),
            height: 25.0,
            colorFilter: ColorFilter.mode(AppColor.appWhiteColor, BlendMode.srcIn),
            width: 25.0,
          ),
        ),
      ),
    ),
    centerTitle: true,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING),
      child: Text(
        "notifications".translate(),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appWhiteColor),
      ),
    ),
  );
}