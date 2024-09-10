import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/custom/direction_view_rtl.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/navigator_helper.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/tiles/subcategories_tile.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/view/Category/subcateory_controller.dart';

class SubCategoryListScreen extends GetView<SubCategoryController>{
  static const route = '/SubCategoryListScreen';
  const SubCategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubCategoryController>();
    return DirectionViewRTL(
      child: Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          resizeToAvoidBottomInset: false,
          appBar: _AppBar(context,controller),
          body: SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Obx(() => Visibility(
                  visible: controller.vnIsShowLoader.value && controller.lstSubCategory.isEmpty,
                  replacement: controller.lstSubCategory.isNotEmpty
                      ? Stack(
                        children: [
                          Padding(
                            padding: controller.vnIsShowLoader.value ? const EdgeInsets.only(bottom: 50.0) : EdgeInsets.zero,
                            child: ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: SMALL_PADDING_15,
                                vertical: SMALL_PADDING_15),
                            itemCount: controller.lstSubCategory.length,
                            controller: controller.scrollController,
                            itemBuilder: (BuildContext ctx, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    controller.onClickSubCategory(index);
                                  },
                                  child: SubCategoriesTile(
                                     subCategory: controller.lstSubCategory[index],
                                  ),
                                ),
                              );
                            }
                  ),
                          ),
                          Visibility(
                            visible: controller.vnIsShowLoader.value,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                                backgroundColor: AppColor.appPrimaryColor,
                                valueColor: AlwaysStoppedAnimation(AppColor.appWhiteColor),
                              ),
                            ),
                          )
                        ],
                      )
                      : Center(child:Text("dataNoAvailable".translate())),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      backgroundColor: AppColor.appPrimaryColor,
                      valueColor:
                      AlwaysStoppedAnimation(AppColor.appWhiteColor),
                    ),
                  )
              ))
          )
      ),
    );
  }
}

class _AppBar extends AppBar {
  _AppBar(BuildContext context,SubCategoryController controller)
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
        controller.title,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appWhiteColor),
      ),
    ),
  );
}