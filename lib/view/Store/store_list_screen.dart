import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/view/Store/add_store_screen.dart';
import 'package:mecazone/view/Store/store_controller.dart';
import 'package:mecazone/view/Store/store_details_screen.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/custom/direction_view_rtl.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/tiles/store_tile.dart';

class  StoreListScreen extends GetView<StoreController>{

  static const route = '/StoreListScreen';
  const StoreListScreen({super.key});

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
            resizeToAvoidBottomInset: false,
            appBar: _AppBar(context),
            body: SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Obx(
                    () => Visibility(
                  visible: controller.vnIsShowLoader.value && controller.lstStore.isEmpty,
                  replacement: controller.lstStore.isNotEmpty
                      ? Stack(
                    children: [
                      Padding(
                        padding: controller.vnIsShowLoader.value ? const EdgeInsets.only(bottom: 50.0) : EdgeInsets.zero,
                        child: GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15,vertical: SMALL_PADDING_15),
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            controller: controller.scrollController,
                            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent:
                              MediaQuery.of(context).size.width * 0.50,
                              childAspectRatio: 1 / 1,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: controller.lstStore.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(
                                      StoreDetailsScreen.route,
                                      arguments: {
                                        'storeId': controller.lstStore[index].id
                                      }
                                  )?.then((value) {
                                    controller.callGetStoreListAPI(counter: 0);
                                  });
                                },
                                child: StoreTile(
                                  storeData: controller.lstStore[index],
                                  onClick: () {
                                    controller.addToWishList(index);
                                  },
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
            colorFilter: ColorFilter.mode(AppColor.appWhiteColor, BlendMode.srcIn),
          ),
        ),
      ),
    ),
    actions: [
      Visibility(
        visible: false,
        child: InkWell(
          onTap: () {
            Get.toNamed(AddStoreScreen.route);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
            child: SvgPicture.asset(
              AssetsHelper.getSVGIcon('ic_add.svg'),
              height: 25.0,
              width: 25.0,
              colorFilter: ColorFilter.mode(AppColor.appWhiteColor, BlendMode.srcIn),
            ),
          ),
        ),
      )
    ],
    centerTitle: true,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING),
      child: Text(
        "store".translate(),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appWhiteColor),
      ),
    ),
  );
}
