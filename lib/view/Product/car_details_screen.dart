import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/custom/divider_view.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/navigator_helper.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/view/Product/car_details_controller.dart';

class CarDetailsScreen extends GetView<CarDetailsController>{
  const CarDetailsScreen({super.key});
  static const route = '/CarDetailsScreen';

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
        onWillPop: () async {
          Get.back(result: true);
          return true;
        },
        child: Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          appBar: _AppBar(context),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Visibility(
              visible: controller.vnIsShowLoader.value,
              replacement: Visibility(
                visible: controller.carDetails != null,
                replacement: Center(
                  child: Text("dataNoAvailable".translate()),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING, vertical: SMALL_PADDING),
                  child: LayoutBuilder(
                    builder: (p0, constraints) => Container(
                      decoration: BoxDecoration(
                          color: AppColor.appWhiteColor,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: AppColor.appDividerColor, width: 1)
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
                                    "brand".translate(),
                                    style: Fonts.regularLabelTextStyle,
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.60,
                                  child: Text(
                                    controller.carDetails!.vehicleDetails!.manuName!,
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
                                    controller.carDetails!.vehicleDetails!.modelName!.firstCapitalize(),
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
                                    "modelType".translate(),
                                    style: Fonts.regularLabelTextStyle,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.60,
                                  child: Text(
                                    controller.carDetails!.vehicleDetails!.typeName!.firstCapitalize(),
                                    style: Fonts.regularTextStyle.copyWith(
                                      fontFamily: 'AppSemiBold',
                                    ),
                                    maxLines: 2,
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
                                    "typeNumber".translate(),
                                    style: Fonts.regularLabelTextStyle,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.60,
                                  child: Text(
                                    controller.carDetails!.vehicleDetails!.typeNumber!.toString(),
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
                                    "brakeSystem".translate(),
                                    style: Fonts.regularLabelTextStyle,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.60,
                                  child: Text(
                                    controller.carDetails!.vehicleDetails!.brakeSystem!.firstCapitalize(),
                                    style: Fonts.regularTextStyle.copyWith(
                                      fontFamily: 'AppSemiBold',
                                    ),
                                    maxLines: 2,
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
                                    "constructionType".translate(),
                                    style: Fonts.regularLabelTextStyle,
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.60,
                                  child: Text(
                                    controller.carDetails!.vehicleDetails!.constructionType!.firstCapitalize(),
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
                                    "motorType".translate(),
                                    style: Fonts.regularLabelTextStyle,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.60,
                                  child: Text(
                                    controller.carDetails!.vehicleDetails!.motorType!.firstCapitalize(),
                                    style: Fonts.regularTextStyle.copyWith(
                                      fontFamily: 'AppSemiBold',
                                    ),
                                    maxLines: 2,
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
                                    "cylinder".translate(),
                                    style: Fonts.regularLabelTextStyle,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.60,
                                  child: Text(
                                    controller.carDetails!.vehicleDetails!.cylinder!.toString(),
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
                                    "fuelType".translate(),
                                    style: Fonts.regularLabelTextStyle,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.60,
                                  child: Text(
                                    controller.carDetails!.vehicleDetails!.fuelType!.firstCapitalize(),
                                    style: Fonts.regularTextStyle.copyWith(
                                      fontFamily: 'AppSemiBold',
                                    ),
                                    maxLines: 2,
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
                                    "valves".translate(),
                                    style: Fonts.regularLabelTextStyle,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.60,
                                  child: Text(
                                    controller.carDetails!.vehicleDetails!.valves!.toString(),
                                    style: Fonts.regularTextStyle.copyWith(
                                      fontFamily: 'AppSemiBold',
                                    ),
                                    textDirection: TextDirection.rtl,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            CommonWidget.getFieldSpacer()

                          ],
                        ),
                      ),
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
        "carDetails".translate(),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appWhiteColor),
      ),
    ),
  );
}
