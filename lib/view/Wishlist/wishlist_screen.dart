import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/view/Store/store_details_screen.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/view/Wishlist/wishlist_controller.dart';
import 'package:mecazone/custom/direction_view_rtl.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/tiles/wishlist_product_tile.dart';
import 'package:mecazone/tiles/wishlist_store_tile.dart';

class WishlistScreen extends GetView<WishListController>{
  static const route = '/WishlistScreen';
  const WishlistScreen({Key? key}) : super(key: key);

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
            appBar: _AppBar(context,controller),
            body: TabBarView(
              controller: controller.tabController,
              children: [_getWishlistProductView(), _getWishlistStoreView()],
            )
        ),
      ),
    );
  }

  /// : GET TAB VIEW - WISHLIST PRODUCT
  Widget _getWishlistProductView() {
    return Container(
      color: Get.context!.theme.scaffoldBackgroundColor,
      height: screenHeight,
      width: screenWidth,
      child: Obx(
        () => Visibility(
          visible: controller.vnIsShowLoader.value && controller.lstWishlistProduct.isEmpty,
          replacement: controller.lstWishlistProduct.isNotEmpty
              ? Stack(
            children: [
              Padding(
                padding: controller.vnIsShowLoader.value
                    ? const EdgeInsets.only(bottom: 50.0)
                    : EdgeInsets.zero,
                child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SMALL_PADDING_15,
                        vertical: SMALL_PADDING_15),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    controller: controller.productScrollController,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: screenWidth * 0.50,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: controller.lstWishlistProduct.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onTap: () {

                        },
                        child: WishlistProductTile(
                          wishlistProductData: controller.lstWishlistProduct[index],
                          onClick: () {
                            controller.callRemoveProductWishListAPI(index: index);
                          },
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
    );
  }

  /// : GET TAB VIEW - WISHLIST STORE
  Widget _getWishlistStoreView() {
    return Container(
      color: Get.context!.theme.scaffoldBackgroundColor,
      height: screenHeight,
      width: screenWidth,
      child: Obx(
        () => Visibility(
          visible: controller.vnIsShowLoader.value && controller.lstWishlistStore.isEmpty,
          replacement: controller.lstWishlistStore.isNotEmpty
              ? Stack(
            children: [
              Padding(
                padding: controller.vnIsShowLoader.value
                    ? const EdgeInsets.only(bottom: 50.0)
                    : EdgeInsets.zero,
                child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15,vertical: SMALL_PADDING_15),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    controller: controller.storeScrollController,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: screenWidth * 0.50,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: controller.lstWishlistStore.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                              StoreDetailsScreen.route,
                              arguments: {
                                'storeId': controller.lstWishlistStore[index].storeId
                              }
                          )?.then((value){
                            if(value){
                              controller.callGetWishlistStoreListAPI(counter: 0);
                            }
                          });
                        },
                        child: WishlistStoreTile(
                          wishlistStoreData: controller.lstWishlistStore[index],
                          onClick: () {
                            controller.callRemoveStoreWishListAPI(index: index);
                          },
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
    );
  }

}

class _AppBar extends AppBar {
  _AppBar(BuildContext context,WishListController controller)
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
          padding:
          const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
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
        "myWishlist".translate(),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: Fonts.cardTitleTextStyle
            .copyWith(color: AppColor.appWhiteColor),
      ),
    ),
    bottom: TabBar(
      controller: controller.tabController,
      indicatorColor: AppColor.appWhiteColor,
      labelStyle: Fonts.editTextLabelStyle.copyWith(color: AppColor.appWhiteColor),
      tabs: [
        Tab(text: "product".translate()),
        Tab(text: "store".translate()),
      ],
    ),
  );
}
