import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/view/Request/request_detail_controller.dart';
import 'package:mecazone/helper/alert_helper.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/navigator_helper.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/custom/divider_view.dart';

class RequestDetailScreen extends GetView<RequestDetailController> {
  static const route = '/RequestDetailScreen';
  const RequestDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
        onWillPop: () async {
          Get.back(result: true);
          return true;
        },
        child: Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          appBar: _AppBar(context, controller),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Visibility(
              visible: controller.vnIsShowLoader.value,
              replacement: Visibility(
                visible: controller.requestDetailsDataModel != null,
                replacement: Center(
                  child: Text("dataNoAvailable".translate()),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING, vertical: SMALL_PADDING),
                  child: LayoutBuilder(
                    builder: (p0, constraints) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            controller.requestDetailsDataModel?.result!.productRequestDetails!.productName ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: context.theme.textTheme.displayLarge
                        ),
                        CommonWidget.getFieldSpacer(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              WidgetSpan(
                                child: SvgPicture.asset(
                                  AssetsHelper.getSVGIcon('ic_location.svg'),
                                  height: 20.0,
                                  colorFilter: ColorFilter.mode(context.theme.primaryColor, BlendMode.srcIn)
                                ),
                              ),
                              WidgetSpan(child: CommonWidget.getFieldSpacer(width: 5)),
                              TextSpan(
                                text: controller.requestDetailsDataModel!.result!.productRequestDetails!.productName,
                                style: Fonts.regularTextStyle.copyWith(color: AppColor.appPrimaryColor),
                              )
                            ])),
                            RichText(
                              text: TextSpan(children: [
                              WidgetSpan(
                                child: SvgPicture.asset(
                                  AssetsHelper.getSVGIcon('ic_clock.svg'),
                                  height: 20.0,
                                  colorFilter: ColorFilter.mode(context.theme.primaryColorLight, BlendMode.srcIn),
                                ),
                              ),
                              WidgetSpan(child: CommonWidget.getFieldSpacer(width: 5)),
                              TextSpan(
                                text: controller.requestDetailsDataModel!.result!.productRequestDetails!.createdOn,
                                style: context.theme.textTheme.bodyMedium,
                              )
                            ])),
                          ],
                        ),
                        CommonWidget.getFieldSpacer(height: 20),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColor.appWhiteColor,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: AppColor.appDividerColor, width: 1)),
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
                                        "brand".translate(),
                                        style: Fonts.regularLabelTextStyle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.60,
                                      child: Text(
                                        controller.requestDetailsDataModel!.result!.productRequestDetails!.brandName!,
                                        style: Fonts.regularTextStyle.copyWith(
                                          fontFamily: 'AppSemiBold',
                                        ),
                                        textDirection: TextDirection.rtl,
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
                                        "model".translate(),
                                        style: Fonts.regularLabelTextStyle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.60,
                                      child: Text(
                                        controller.requestDetailsDataModel!.result!.productRequestDetails!.modelName!,
                                        style: Fonts.regularTextStyle.copyWith(
                                          fontFamily: 'AppSemiBold',
                                        ),
                                        textDirection: TextDirection.rtl,
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
                                        "manufacturer".translate(),
                                        style: Fonts.regularLabelTextStyle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.60,
                                      child: Text(
                                        controller.requestDetailsDataModel!.result!.productRequestDetails!.mfrName!,
                                        style: Fonts.regularTextStyle.copyWith(
                                          fontFamily: 'AppSemiBold',
                                        ),
                                        textDirection: TextDirection.rtl,
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
                                        "year".translate(),
                                        style: Fonts.regularLabelTextStyle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.60,
                                      child: Text(
                                        controller.requestDetailsDataModel!.result!.productRequestDetails!.year.toString(),
                                        style: Fonts.regularTextStyle.copyWith(
                                            fontFamily: 'AppSemiBold',
                                        ),
                                        textDirection: TextDirection.rtl,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        /// :  CALL
                        CommonWidget.getFieldSpacer(height: 15.0),
                        Text(
                            "call".translate(),
                            overflow: TextOverflow.ellipsis,
                            style: context.theme.textTheme.displayLarge
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: SMALL_PADDING),
                          child: InkWell(
                            onTap: (){
                              AlertHelper.callOnPhone(controller.requestDetailsDataModel!.result!.productRequestDetails!.phoneNumber!);
                            },
                            child: Text(
                                controller.requestDetailsDataModel!.result!.productRequestDetails!.phoneNumber ?? "-",
                                style: context.theme.textTheme.bodySmall
                            ),
                          ),
                        ),

                        CommonWidget.getFieldSpacer(height: 15.0),
                        /// : DESCRIPTION
                        Text(
                            "description".translate(),
                            overflow:
                            TextOverflow.ellipsis,
                            style: context.theme.textTheme.displayLarge
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: SMALL_PADDING),
                          child: Text(
                              controller.requestDetailsDataModel!.result!.productRequestDetails!.description ?? "",
                              style: context.theme.textTheme.bodySmall
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  backgroundColor: AppColor.appPrimaryColor,
                  valueColor: AlwaysStoppedAnimation(AppColor.appWhiteColor),
                ),
              ),
            ),
          ),
        )));
  }
}

class _AppBar extends AppBar {
  _AppBar(BuildContext context, RequestDetailController controller)
      : super(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.appPrimaryColor,
          // Status bar color
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
              "requestDetails".translate(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appWhiteColor),
            ),
          ),
        );
}
