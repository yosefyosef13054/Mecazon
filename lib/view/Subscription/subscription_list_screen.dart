import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/custom/custom_marquee_widget.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/view/Subscription/subscription_list_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/navigator_helper.dart';

class SubscriptionListScreen extends GetView<SubscriptionListController>{
  static const route = '/SubscriptionListScreen';
  const SubscriptionListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: _AppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15,vertical: SMALL_PADDING_15),
        child: PageView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: controller.lstSubscription.length,
          onPageChanged: (int page) {
            controller.onChangePage(page);
          },
          controller: controller.pageController,
          itemBuilder: (context, index) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: context.theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(CARD_RADIUS_NORMAL),
                        border: Border.all(color: context.theme.primaryColorLight.withOpacity(0.25), width: 1.0)
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15,vertical: SMALL_PADDING_15),
                          decoration: BoxDecoration(
                            color: context.theme.primaryColor,
                            borderRadius: BorderRadius.circular(CARD_RADIUS_NORMAL)
                          ),
                          height: 65,
                          width: screenWidth,
                          child: Center(
                            child: Text(
                              controller.lstSubscription[index].subscriptionName ?? "",
                              style: context.theme.textTheme.labelLarge?.copyWith(
                                  color: AppColor.appWhiteColor
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15,vertical: SMALL_PADDING_15),
                          child: Column(
                            children: [
                              CommonWidget.getFieldSpacer(height: 20),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: SvgPicture.asset(
                                        AssetsHelper.getSVGIcon("ic_done.svg"),
                                        colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn)
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(width: 8.0),
                                  Expanded(
                                    child: CustomMarqueeWidget(
                                      child: Text(
                                          "${"storageNb".translate()}${controller.lstSubscription[index].storageNb}",
                                          overflow:TextOverflow.ellipsis,
                                          style: context.theme.textTheme.bodyMedium
                                      ),
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(width: 4.0),
                                ],
                              ),

                              CommonWidget.getFieldSpacer(height: 20),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: SvgPicture.asset(
                                        AssetsHelper.getSVGIcon(controller.lstSubscription[index].priorityStore == true ? "ic_done.svg" : "ic_close.svg"),
                                        colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn)
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(width: 8.0),
                                  Expanded(
                                    child: CustomMarqueeWidget(
                                      child: Text(
                                          "priorityStore".translate(),
                                          overflow:TextOverflow.ellipsis,
                                          style: context.theme.textTheme.bodyMedium
                                      ),
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(width: 4.0),
                                ],
                              ),

                              CommonWidget.getFieldSpacer(height: 20),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: SvgPicture.asset(
                                        AssetsHelper.getSVGIcon(controller.lstSubscription[index].postRequest == true ? "ic_done.svg" : "ic_close.svg"),
                                        colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn)
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(width: 8.0),
                                  Expanded(
                                    child: CustomMarqueeWidget(
                                      child: Text(
                                          "postRequest".translate(),
                                          overflow:TextOverflow.ellipsis,
                                          style: context.theme.textTheme.bodyMedium
                                      ),
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(width: 4.0),
                                ],
                              ),

                              CommonWidget.getFieldSpacer(height: 20),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: SvgPicture.asset(
                                        AssetsHelper.getSVGIcon(controller.lstSubscription[index].certifiedStore == true ? "ic_done.svg" : "ic_close.svg"),
                                        colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn)
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(width: 8.0),
                                  Expanded(
                                    child: CustomMarqueeWidget(
                                      child: Text(
                                          "certifiedStore".translate(),
                                          overflow:TextOverflow.ellipsis,
                                          style: context.theme.textTheme.bodyMedium
                                      ),
                                    ),
                                  ),
                                  CommonWidget.getFieldSpacer(width: 4.0),
                                ],
                              ),
                              CommonWidget.getFieldSpacer(height: 20),

                              Visibility(
                                visible: controller.lstSubscription[index].planDetails!.isNotEmpty,
                                child: ListView.builder(
                                  itemCount:  controller.lstSubscription[index].planDetails!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, subIndex) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: SMALL_PADDING),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15,vertical: SMALL_PADDING_15),
                                      decoration: BoxDecoration(
                                        color: context.theme.primaryColor,
                                        borderRadius: BorderRadius.circular(CARD_RADIUS_NORMAL),
                                        // border: Border.all(color: AppColor.appBlackColor.withOpacity(0.25), width: 0.5)
                                      ),
                                      height: 65,
                                      child: ListTile(
                                        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: -4.0),
                                        horizontalTitleGap: 0.0,
                                        title: Text(
                                            "${controller.lstSubscription[index].planDetails![subIndex].name}  -  ${controller.lstSubscription[index].planDetails![subIndex].price}",
                                            style: context.theme.textTheme.displayMedium?.copyWith(
                                                color: AppColor.appWhiteColor
                                            )
                                        ),
                                        trailing:Icon(
                                          Icons.add_shopping_cart_outlined,
                                          color: AppColor.appWhiteColor,
                                          size: 25.0,
                                        ),
                                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              CommonWidget.getFieldSpacer(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Obx(
        () => DotsIndicator(
          dotsCount:controller.lstSubscription.length,
          position: controller.currentPageValue.value,
          onTap: (position) {

          },
          decorator: DotsDecorator(
            size: const Size(12.0, 5.0),
            activeSize: const Size(25.0, 5.0),
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5.0)),
            activeShape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5.0)),
            color: context.theme.primaryColorLight,
            activeColor: context.theme.primaryColor,
          ),
        ),
      ),
    );

  }
}

class _AppBar extends AppBar {
  _AppBar(BuildContext context)
      : super(
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
        "subscription".translate(),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appWhiteColor),
      ),
    ),
  );
}