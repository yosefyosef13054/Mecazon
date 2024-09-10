import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/custom/direction_view_rtl.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/view/Brand/brand_controller.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/navigator_helper.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/tiles/brands_tile.dart';
import 'package:mecazone/utils/constants.dart';

class BrandListScreen extends GetView<BrandController>{
  static const route = '/BrandScreen';
  const BrandListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DirectionViewRTL(
      child: Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          resizeToAvoidBottomInset: false,
          appBar: _AppBar(context),
          body: SingleChildScrollView(
              child: Container(
                color: AppColor.appWhiteColor,
                height: screenHeight,
                width: screenWidth,
                child: Obx(
                      () => Visibility(
                    visible: controller.vnIsShowLoader.value,
                    replacement: controller.lstBrand.isNotEmpty
                        ? GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15,vertical: SMALL_PADDING_15),
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 50,
                          crossAxisSpacing: SMALL_PADDING_12,
                          mainAxisSpacing: SMALL_PADDING_12,
                        ),
                        itemCount: controller.lstBrand.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                            onTap: () {},
                            child: BrandsTile(
                              brand: controller.lstBrand[index],
                            ),
                          );
                        })
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
          )
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
          NavigatorHelper.remove(value: true);
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
        "brands".translate(),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appWhiteColor),
      ),
    ),
  );
}