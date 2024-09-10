import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/custom/custom_marquee_widget.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/view/Product/product_search_screen.dart';
import 'package:mecazone/view/Store/edit_store_screen.dart';
import 'package:mecazone/view/Store/store_details_controller.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/tiles/product_tile.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class StoreDetailsScreen extends GetView<StoreDetailsController>{
  static const route = '/StoreDetailsScreen';
  const StoreDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        return true;
      },
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: _AppBar(context,controller),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Obx(
            () => Visibility(
              visible: controller.vnIsShowLoader.value,
              replacement: Visibility(
                visible: controller.storeDetailsDataModel.value.storeName != "",
                replacement: Center(
                  child: Text("dataNoAvailable".translate()),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: MAIN_PADDING,
                        vertical: SMALL_PADDING),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// :  BANNER
                        controller.bannerList.isNotEmpty
                            ? bannerLayout(context)
                            : const SizedBox(),

                        CommonWidget.getFieldSpacer(height: 15.0),

                        /// :  STORE NAME
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                  controller.storeDetailsDataModel.value.storeName ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: context.theme.textTheme.displayLarge
                              ),
                            ),
                            CommonWidget.getFieldSpacer(width: 2.0),
                            Visibility(
                              visible: CommonWidget.user?.profileTypeId == USER_TYPE_1057_PROFESSIONAL,
                              child: CommonWidget.getActiveStatus(
                                  context,
                                  controller.storeDetailsDataModel.value.isActive ?? false
                              ),
                            )
                          ],
                        ),
                        CommonWidget.getFieldSpacer(height: 15.0),

                        Visibility(
                          visible: CommonWidget.user?.profileTypeId == USER_TYPE_1057_PROFESSIONAL && controller.storeDetailsDataModel.value.subscriptionName !="",
                          child: Row(
                            children: [
                              Text(
                                  "subscription".translate(),
                                  overflow: TextOverflow.ellipsis,
                                  style: context.theme.textTheme.bodyLarge),
                              CommonWidget.getFieldSpacer(width: 4.0),
                              Container(
                                height: 35,
                                width: 80.0,
                                decoration: BoxDecoration(
                                    borderRadius:BorderRadius.circular(10.0),
                                    color: context.theme.primaryColor
                                ),
                                child: Center(
                                  child: Text(
                                    controller.storeDetailsDataModel.value.subscriptionName ?? "",
                                    style: context.theme.textTheme.bodySmall?.copyWith(fontSize: 14,color:context.theme.scaffoldBackgroundColor),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        CommonWidget.getFieldSpacer(height: CommonWidget.user?.profileTypeId == USER_TYPE_1057_PROFESSIONAL && controller.storeDetailsDataModel.value.subscriptionName != ""? 15.0: 0.0),

                        /// :  AFFECTED CAR BRANDS
                        Visibility(
                          visible: controller.storeDetailsDataModel.value.storeManagementBrandsView != null,
                          child: Text(
                              "affectedCarBrands".translate(),
                              overflow: TextOverflow.ellipsis,
                              style: context.theme.textTheme.displayLarge
                          ),
                        ),
                        Visibility(
                            visible: controller.storeDetailsDataModel.value.storeManagementBrandsView !=
                                null,
                            child: CommonWidget.getFieldSpacer(height: controller.storeDetailsDataModel.value.storeManagementBrandsView !=null? 4.0: 15.0)),
                        Visibility(
                          visible: controller.storeDetailsDataModel.value.storeManagementBrandsView !=
                              null,
                          replacement: const SizedBox(),
                          child: GridView.builder(
                              padding: const EdgeInsets.only(
                                  right: SMALL_PADDING),
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 35.0,
                              ),
                              itemCount: controller.storeDetailsDataModel.value.storeManagementBrandsView?.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return Row(
                                  children: [
                                    SizedBox(
                                      height: 12,
                                      width: 12,
                                      child: SvgPicture.asset(
                                        AssetsHelper.getSVGIcon("ic_done.svg"),
                                      ),
                                    ),
                                    CommonWidget.getFieldSpacer(width: 8.0),
                                    Expanded(
                                      child: CustomMarqueeWidget(
                                        child: Text(
                                            controller.storeDetailsDataModel.value.storeManagementBrandsView?[index].brandName ?? "",
                                            overflow:TextOverflow.ellipsis,
                                            style: context.theme.textTheme.bodyLarge
                                        ),
                                      ),
                                    ),
                                    CommonWidget.getFieldSpacer(width: 4.0),
                                  ],
                                );
                              }),
                        ),
                        CommonWidget.getFieldSpacer(height: controller.storeDetailsDataModel.value.storeManagementBrandsView !=null? 15.0: 0.0),

                        /// :  ADDRESS
                        Visibility(
                          visible: controller.storeDetailsDataModel.value.address != null,
                          replacement: const SizedBox(),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: context.theme.canvasColor),
                            padding: const EdgeInsets.symmetric(
                                horizontal: SMALL_PADDING,
                                vertical: SMALL_PADDING_12
                            ),
                            child: ListTile(
                              onTap: () {},
                              leading: CircleAvatar(
                                backgroundColor:
                                context.theme.canvasColor,
                                maxRadius: 25.0,
                                child: SvgPicture.asset(
                                    AssetsHelper.getSVGIcon('ic_location_fill.svg'),
                                    height: 20.0,
                                    width: 20.0,
                                    colorFilter: ColorFilter.mode(context.theme.primaryColor, BlendMode.srcIn)
                                ),
                              ),
                              minVerticalPadding: 0.0,
                              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: -4.0),
                              horizontalTitleGap: 0.0,
                              title: Text(
                                "address".translate(),
                                style: context.theme.textTheme.bodyMedium?.copyWith(fontFamily: 'AppSemiBold'),
                              ),
                              subtitle: Text(
                                "${controller.storeDetailsDataModel.value.address} ${controller.storeDetailsDataModel.value.provinceName} ${controller.storeDetailsDataModel.value.municipalityName} " ,
                                style: context.theme.textTheme.bodySmall?.copyWith(fontSize: 14),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        CommonWidget.getFieldSpacer(height: controller.storeDetailsDataModel.value.address != ""? 8.0: 0.0),

                        /// :  MOBILE NO
                        Visibility(
                          visible: controller.storeDetailsDataModel.value.storeManagementPhoneNumber !=null &&controller.storeMobileNo == null &&controller.storeMobileNo!.isNotEmpty,
                          replacement: const SizedBox(),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                // border: Border.all(width: 1.0,color: context.theme.primaryColor),
                                color: context.theme.canvasColor),
                            padding: const EdgeInsets.symmetric(
                                horizontal: SMALL_PADDING,
                                vertical: SMALL_PADDING_12),
                            child: ListTile(
                              onTap: () {},
                              leading: CircleAvatar(
                                backgroundColor:
                                context.theme.canvasColor,
                                maxRadius: 25.0,
                                child: SvgPicture.asset(
                                  AssetsHelper.getSVGIcon('ic_call2.svg'),
                                  height: 20.0,
                                  width: 20.0,
                                  colorFilter: ColorFilter.mode(context.theme.primaryColor, BlendMode.srcIn),
                                ),
                              ),
                              minVerticalPadding: 0.0,
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: -4.0),
                              horizontalTitleGap: 0.0,
                              title: Text(
                                "phoneNumber".translate(),
                                style: context.theme.textTheme.bodyMedium?.copyWith(fontFamily: 'AppSemiBold'),
                              ),
                              subtitle: Text(
                                controller.storeMobileNo ?? "",
                                style: context.theme.textTheme.bodySmall?.copyWith(fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        CommonWidget.getFieldSpacer(height: controller.storeDetailsDataModel.value.storeManagementPhoneNumber != null? 8.0: 0.0),

                        /// :  TOTAL VISIT & WISH LIST
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text("total".translate(),
                                    overflow: TextOverflow.ellipsis,
                                    style: context.theme.textTheme.displayLarge?.copyWith(fontSize: 16.0)),
                                CommonWidget.getFieldSpacer(width: 4.0),
                                Text(
                                    "${controller.storeDetailsDataModel.value.visitCount} ${"visits".translate()}",
                                    overflow: TextOverflow.ellipsis,
                                    style: context.theme.textTheme.bodyLarge)
                              ],
                            ),
                            Visibility(
                                visible: CommonWidget.user?.profileTypeId == USER_TYPE_1056_CUSTOMER,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    controller.callAddStoreWishListAPI();
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          context.theme.scaffoldBackgroundColor),
                                      elevation:
                                      MaterialStateProperty.all(0.0)),
                                  icon: SvgPicture.asset(
                                    AssetsHelper.getSVGIcon(controller.vnIsStoreWishListed.value? 'ic_wishlist_fill.svg': 'ic_wishlist.svg'),
                                    height: 18.0,
                                    colorFilter: ColorFilter.mode(controller.vnIsStoreWishListed.value ? context.theme.primaryColor: context.theme.primaryColor, BlendMode.srcIn),
                                  ),
                                  label: Text(
                                      controller.vnWishlistCount.value == 0 ? "" : controller.vnWishlistCount.value.toString(),
                                      style: context.theme.textTheme.bodyMedium
                                  ),
                                )
                            )
                          ],
                        ),
                        CommonWidget.getFieldSpacer(height: 8.0),

                        /// :  DESCRIPTION & ALL PRODUCTS STORE
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: context.theme.unselectedWidgetColor),
                          height: 50.0,
                          child: LayoutBuilder(
                            builder: (p0, p1) => Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.vnIsTabChange.value = true;
                                  },
                                  child: Container(
                                    width: p1.maxWidth * 0.50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        color: controller.vnIsTabChange.value
                                            ? context.theme.primaryColor
                                            : context.theme.unselectedWidgetColor),
                                    child: Center(
                                      child: Text(
                                          "description".translate(),
                                          overflow:
                                          TextOverflow.ellipsis,
                                          style: context.theme.textTheme.bodyLarge?.copyWith(
                                              color: controller.vnIsTabChange.value? context.theme.scaffoldBackgroundColor: context.theme.primaryColorLight)),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.vnIsTabChange.value = false;
                                  },
                                  child: Container(
                                    width: p1.maxWidth * 0.50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: controller.vnIsTabChange.value? context.theme.unselectedWidgetColor: context.theme.primaryColor
                                    ),
                                    child: Center(
                                      child: Text(
                                          "allProducts".translate(),
                                          overflow: TextOverflow.ellipsis,
                                          style: context.theme.textTheme.bodyLarge?.copyWith(color: controller.vnIsTabChange.value? context.theme.primaryColorLight: context.theme.scaffoldBackgroundColor)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        CommonWidget.getFieldSpacer(height: 15.0),

                        tabLayout(context)
                      ],
                    ),
                  ),
                ),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  backgroundColor: context.theme.primaryColor,
                  valueColor: AlwaysStoppedAnimation(context.theme.scaffoldBackgroundColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bannerLayout(BuildContext context){
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            pageSnapping: true,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 1.0,
            enlargeFactor: 0.5,
            aspectRatio: 16 / 9,
            animateToClosest: true,
            initialPage: controller.vnCurrentBannerIndex.value.toInt(),
            onPageChanged: (index, value) {
              controller.vnCurrentBannerIndex.value = index.toDouble();
            },
          ),
          items: controller.bannerList.map((item) => InkWell(
            onTap: () {},
            child: SizedBox(
              width: screenWidth,
              child: ClipRRect(
                borderRadius:BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl:
                  item.storeImage ?? '',
                  alignment:
                  Alignment.center,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) =>
                      Center(
                          child: Container(
                            color: Colors.grey
                                .withAlpha(20),
                          )
                      ),
                ),
              ),
            ),
          ),
          )
              .toList(),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 5,
          child: DotsIndicator(
            dotsCount: controller.bannerList.length,
            position: controller.vnCurrentBannerIndex.value,
            onTap: (position) {
              // vnCurrentBannerIndex.value = position ;
            },
            decorator: DotsDecorator(
              size: const Size(12.0, 5.0),
              activeSize: const Size(25.0, 5.0),
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(5.0)),
              activeShape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(5.0)),
              color: context.theme.scaffoldBackgroundColor.withOpacity(0.50),
              activeColor: context.theme.scaffoldBackgroundColor,
            ),
          ),
        )
      ],
    );
  }

  Widget tabLayout(BuildContext context){
    return Visibility(
      visible: controller.vnIsTabChange.value,
      replacement: Column(
        children: [

          Visibility(
            visible: controller.storeDetailsDataModel.value.id != null && CommonWidget.user!.profileTypeId == USER_TYPE_1057_PROFESSIONAL,
            child: InkWell(
              onTap: () {
                Get.toNamed(ProductSearchScreen.route);
              },
              child: Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: context.theme.primaryColor)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          AssetsHelper.getSVGIcon('ic_add.svg'),
                          height: 25.0,
                          width: 25.0,
                          colorFilter: ColorFilter.mode(context.theme.primaryColor,BlendMode.srcIn)
                      ),
                      CommonWidget.getFieldSpacer(width: 15.0),
                      Flexible(
                        child: CustomMarqueeWidget(
                          child: Text(
                            'addYourProduct'.translate(),
                            style: context.theme.textTheme.bodyMedium?.copyWith(
                                color: AppColor.appPrimaryColor
                            ),
                          ),
                        ),
                      )
                    ],
                  )
              ),
            ),
          ),

          CommonWidget.getFieldSpacer(height: 15.0),

          Visibility(
            visible: controller.lstStoreProducts.isNotEmpty,
            replacement: Center(
                child: Text("productNoAvailable".translate())),
            child: Column(
              children: [
                Visibility(
                  visible: controller.storeDetailsDataModel.value.storeTotalProductCounts != 0,
                  child: Row(
                    children: [
                      Text(
                          "total".translate(),
                          overflow:TextOverflow.ellipsis,
                          style: context.theme.textTheme.displayLarge?.copyWith(fontSize: 16.0)),
                      CommonWidget.getFieldSpacer(width: 4.0),
                      Text(
                          "${controller.storeDetailsDataModel.value.storeTotalProductCounts} ${"product".translate()}",
                          overflow:TextOverflow.ellipsis,
                          style: context.theme.textTheme.bodyLarge
                      )
                    ],
                  ),
                ),
                Visibility(
                    visible: controller.storeDetailsDataModel.value.storeTotalProductCounts !=0,
                    child: CommonWidget.getFieldSpacer(height: 15.0)),
                GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: MediaQuery.of(context).size.width *0.45,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: controller.lstStoreProducts.length,
                    itemBuilder:(BuildContext ctx, index) {
                      return InkWell(
                        onTap: () {},
                        child: ProductTile(
                          storeProducts:controller.lstStoreProducts[index],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
      child: Text(
          controller.storeDetailsDataModel.value.description ?? "",
          style: context.theme.textTheme.bodySmall
      ),
    );
  }

}

class _AppBar extends AppBar {
  _AppBar(BuildContext context,StoreDetailsController controller)
      : super(
    automaticallyImplyLeading: false,
    backgroundColor: context.theme.primaryColor, // Status bar color
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
    centerTitle: true,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING),
      child: Text(
        "storeDetails".translate(),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appWhiteColor),
      ),
    ),
    actions: [
      Obx(
        () => Visibility(
          visible: controller.storeDetailsDataModel.value.id != null && CommonWidget.user!.profileTypeId == USER_TYPE_1057_PROFESSIONAL,
          child: Padding(
            padding: const EdgeInsets.only(left: SMALL_PADDING, right: MAIN_PADDING),
            child: InkWell(
              onTap: () {
                Get.toNamed(
                  EditStoreScreen.route,
                  arguments: {
                    'storeId': controller.storeId
                  }
                )?.then((value){
                  if(value){
                    controller.callGetStoreDetailsAPI();
                  }
                });
              },
              child: SvgPicture.asset(
                AssetsHelper.getSVGIcon('ic_edit.svg'),
                colorFilter: ColorFilter.mode(AppColor.appWhiteColor, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ),
      Visibility(
        visible: controller.storeDetailsDataModel.value.id != null,
        child: Padding(
          padding: const EdgeInsets.only(left: SMALL_PADDING, right: MAIN_PADDING),
          child: InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              AssetsHelper.getSVGIcon('ic_share.svg'),
              colorFilter: ColorFilter.mode(AppColor.appWhiteColor, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    ],
  );
}