import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/custom/custom_marquee_widget.dart';
import 'package:mecazone/custom/custom_textfield.dart';
import 'package:mecazone/custom/direction_view_rtl.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/view/Home/home_controller.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/view/Category/category_screen.dart';
import 'package:mecazone/view/Brand/brand_list_screen.dart';
import 'package:mecazone/custom/button_view.dart';
import 'package:mecazone/custom/divider_view.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/tiles/home_categories_tile.dart';
import 'package:mecazone/view/Product/car_details_screen.dart';

class HomeScreen extends GetView<HomeController> {
  static const route = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DirectionViewRTL(
      child: Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
              preferredSize: Size(Get.width, kToolbarHeight),
              child: const _LocalAppBar()),
          body: Container(
            color: context.theme.scaffoldBackgroundColor,
            height: screenHeight,
            width: screenWidth,
            child: Obx(() => Visibility(
              visible: controller.vnIsShowLoader.value,
              replacement: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// :  HOME BANNER
                          controller.homeBannerList.isNotEmpty
                              ? Padding(
                            padding: const EdgeInsets.only(left: SMALL_PADDING_15,right: SMALL_PADDING_15,top: MAIN_PADDING,bottom: SMALL_PADDING),
                            child: CustomMarqueeWidget(
                              child: Text(
                                  "offerOfTheDay".translate(),
                                  overflow: TextOverflow.ellipsis,
                                  style: context.theme.textTheme.displayLarge
                              ),
                            ),
                          )
                              : const SizedBox(),

                          controller.homeBannerList.isNotEmpty
                              ? homeBannerListLayout(context)
                              : const SizedBox(),

                          /// :  ADD NEW CAR LIST
                          Visibility(
                            visible: controller.noOfCarsAddedByUser < 3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: SMALL_PADDING_15,
                                  vertical: SMALL_PADDING),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(15.0),
                                    border: Border.all(
                                        width: 1.0,
                                        color: AppColor.appPrimaryColor),
                                    color: context.theme.canvasColor
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: SMALL_PADDING,
                                    vertical: SMALL_PADDING_12),
                                child: ListTile(
                                  onTap: () {
                                    controller.fnBrand.value = true;
                                    showProductBrandBottomSheet();
                                  },
                                  leading: CircleAvatar(
                                    backgroundColor:AppColor.appLightOrangeColor,
                                    maxRadius: 40.0,
                                    child: SvgPicture.asset(
                                        AssetsHelper.getSVGIcon('ic_add.svg'),
                                        height: 25.0,
                                        width: 25.0,
                                        colorFilter: ColorFilter.mode(AppColor.appPrimaryColor,BlendMode.srcIn)
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                                      side: BorderSide(color: AppColor.appPrimaryColor,width: 1.0)
                                  ),
                                  tileColor: AppColor.appLightOrangeColor,
                                  minVerticalPadding: 0.0,
                                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                  contentPadding:const EdgeInsets.symmetric(horizontal: -4.0, vertical: -4.0),
                                  horizontalTitleGap: 0.0,
                                  title: Text(
                                    "addYourCar".translate(),
                                    style: context.textTheme.bodyMedium?.copyWith(
                                        fontFamily: 'AppSemiBold'
                                    ),
                                  ),
                                  subtitle: Text(
                                      "addYourCarDesc".translate(),
                                      style: context.textTheme.bodySmall?.copyWith(
                                          fontSize: 14
                                      )
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (controller.homeCarList.isEmpty)
                            CommonWidget.getFieldSpacer(),
                          if (controller.homeCarList.isNotEmpty)
                            homeCarListLayout(context),

                          /// :  BRANDS LIST
                          if (controller.homeBrandList.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: SMALL_PADDING_15,
                                  vertical: SMALL_PADDING),
                              child: SizedBox(
                                width: screenWidth,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: CustomMarqueeWidget(
                                        child: Text("brands".translate(),
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                            Fonts.cardTitleTextStyle),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(BrandListScreen.route);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: SMALL_PADDING),
                                        child: Text("viewAll".translate(),
                                            overflow: TextOverflow.ellipsis,
                                            style: Fonts
                                                .regularLabelTextStyle),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (controller.homeBrandList.isNotEmpty)
                            brandListLayout(context),
                          if (controller.homeBrandList.isNotEmpty)
                            CommonWidget.getFieldSpacer(),

                          /// :  CATEGORY LIST
                          if (controller.homeCategoryList.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: SMALL_PADDING_15,
                                  vertical: SMALL_PADDING),
                              child: SizedBox(
                                width: screenWidth,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: CustomMarqueeWidget(
                                        child: Text(
                                            "topSellingCategories".translate(),
                                            overflow: TextOverflow.ellipsis,
                                            style: context.theme.textTheme.displayLarge
                                        ),
                                      ),
                                    ),
                                    /*Visibility(
                                          visible: false,
                                          child: InkWell(
                                            onTap: () {
                                              Get.toNamed(CategoryListScreen.route);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: SMALL_PADDING),
                                              child: Text("viewAll".translate(),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: context.theme.textTheme.bodyLarge
                                              ),
                                            ),
                                          ),
                                        ),*/
                                  ],
                                ),
                              ),
                            ),
                          if (controller.homeCategoryList.isNotEmpty)
                            categoryListLayout(context)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  backgroundColor: AppColor.appPrimaryColor,
                  valueColor: AlwaysStoppedAnimation(AppColor.appBlackColor),
                ),
              ),
            )),
          ),
          bottomNavigationBar: bottomNavigationBarLayout(context)
      ),
    );
  }

  /// : BOTTOM NAVIGATION BAR LAYOUT
  Widget bottomNavigationBarLayout(BuildContext context){
    return Container(
      height: appbarHeight * 1.2,
      decoration: BoxDecoration(
        color: context.theme.unselectedWidgetColor,
      ),
      child: Obx(
        () => Center(
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            elevation: 0.0,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            backgroundColor: context.theme.bottomNavigationBarTheme.backgroundColor,
            selectedItemColor: context.theme.bottomNavigationBarTheme.selectedItemColor,
            unselectedItemColor: context.theme.bottomNavigationBarTheme.unselectedItemColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetsHelper.getSVGIcon('ic_home.svg'),
                  colorFilter: ColorFilter.mode(context.theme.bottomNavigationBarTheme.unselectedItemColor  ?? AppColor.appBlackColor, BlendMode.srcIn),
                  height: 30.0,
                  width: 30.0,
                ),
                activeIcon: SvgPicture.asset(
                  AssetsHelper.getSVGIcon('ic_home_fill.svg'),
                  colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn),
                  height: 30.0,
                  width: 30.0,
                ),
                label: "home".translate(),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetsHelper.getSVGIcon('ic_store.svg'),
                  colorFilter: ColorFilter.mode(context.theme.bottomNavigationBarTheme.unselectedItemColor  ?? AppColor.appBlackColor, BlendMode.srcIn),
                  height: 30.0,
                  width: 30.0,
                ),
                activeIcon: SvgPicture.asset(
                  AssetsHelper.getSVGIcon('ic_store_fill.svg'),
                  colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn),
                  height: 30.0,
                  width: 30.0,
                ),
                label: "stores".translate(),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetsHelper.getSVGIcon(CommonWidget.user?.profileTypeId == USER_TYPE_1056_CUSTOMER ? 'ic_request.svg' : 'ic_note.svg'),
                  colorFilter: ColorFilter.mode(context.theme.bottomNavigationBarTheme.unselectedItemColor  ?? AppColor.appBlackColor, BlendMode.srcIn),
                  height: 30.0,
                  width: 30.0,
                ),
                activeIcon: SvgPicture.asset(
                  AssetsHelper.getSVGIcon(CommonWidget.user?.profileTypeId == USER_TYPE_1056_CUSTOMER ? 'ic_request_fill.svg' : 'ic_note.svg'),
                  colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn),
                  height: 30.0,
                  width: 30.0,
                ),
                label: "requests".translate(),
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    AssetsHelper.getSVGIcon('ic_menu.svg'),
                    colorFilter: ColorFilter.mode(context.theme.bottomNavigationBarTheme.unselectedItemColor  ?? AppColor.appBlackColor, BlendMode.srcIn),
                    height: 22.0,
                    width: 22.0,
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    AssetsHelper.getSVGIcon('ic_menu.svg'),
                    colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn),
                    height: 22.0,
                    width: 22.0,
                  ),
                ),
                label: "menu".translate(),
              ),
            ],
            currentIndex: controller.vnCurrentNavigationIndex.value,
            onTap: controller.navigationTapped,
          ),
        ),
      ),
    );
  }

  /// : HOME BANNER LAYOUT
  Widget homeBannerListLayout(BuildContext context){
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            pageSnapping: true,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration:const Duration(milliseconds: 800),
            viewportFraction: 1.0,
            enlargeFactor: 0.5,
            aspectRatio: 16 / 9,
            animateToClosest: true,
            initialPage: controller.vnCurrentBannerIndex.value.toInt(),
            onPageChanged: (index, value) {
              controller.vnCurrentBannerIndex.value = index.toDouble();
            },
          ),
          items: controller.homeBannerList
              .map(
                (item) => InkWell(
              onTap: () {},
              child: SizedBox(
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal:SMALL_PADDING_15,
                      vertical: SMALL_PADDING
                  ),
                  child: ClipRRect(
                    borderRadius:BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl:
                      item.strProfilePicture ??'',
                      alignment:
                      Alignment.center,
                      fit: BoxFit.fill,
                      errorWidget: (context,
                          url, error) =>
                          SizedBox(
                            child: Center(
                                child: Container(
                                  color: Colors.grey
                                      .withAlpha(20),
                                )),
                          ),
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
          bottom: 25,
          child: DotsIndicator(
            dotsCount:controller.homeBannerList.length,
            position: controller.vnCurrentBannerIndex.value,
            onTap: (position) {},
            decorator: DotsDecorator(
              size: const Size(12.0, 5.0),
              activeSize: const Size(25.0, 5.0),
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5.0)),
              activeShape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5.0)),
              color: AppColor.appWhiteColor.withOpacity(0.50),
              activeColor: AppColor.appWhiteColor,
            ),
          ),
        )
      ],
    );
  }

  /// : HOME CAR LAYOUT
  Widget homeCarListLayout(BuildContext context){
    return ListView.builder(
      itemCount: controller.homeCarList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: SMALL_PADDING_15,
            vertical: SMALL_PADDING),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: SMALL_PADDING),
                child: Obx(() => Visibility(
                  visible: controller.vnIsShowLoader.value,
                  replacement: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: AppColor.appPrimaryColor,
                      size: 35.0,
                    ),
                    onPressed: () {
                      controller.callDeleteCarAPI(context, index);
                    },
                  ),
                  child:CircularProgressIndicator(
                    strokeWidth: 3.0,
                    backgroundColor: AppColor.appPrimaryColor,
                    valueColor: AlwaysStoppedAnimation(AppColor.appBlackColor),
                  ),
                )),
              )
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(15.0),
                color: context.theme.primaryColorLight.withOpacity(0.03)
            ),
            padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING,vertical: SMALL_PADDING),
            child: ListTile(
              onTap: () {
                Get.toNamed(
                    CarDetailsScreen.route,
                    arguments:{
                      'carId': controller.homeCarList[index].modelTypeId
                    }
                );
              },
              leading: CachedNetworkImage(
                width: 80,
                height: 80,
                imageUrl: controller.homeCarList[index].image ?? '',
                alignment: Alignment.center,
                fit: BoxFit.contain,
                progressIndicatorBuilder:(context, url, downloadProgress) => Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(CARD_RADIUS_NORMAL)),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: AppColor.appLightOrangeColor,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => SizedBox(
                  width: 80,
                  height: 80,
                  child: SvgPicture.asset(
                    AssetsHelper.getSVGIcon("ic_logo.svg"),
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
              tileColor: context.theme.primaryColorLight,
              minVerticalPadding: 0.0,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: -4.0,
                  vertical: 0.0),
              horizontalTitleGap: 6.0,
              title: Text(
                controller.homeCarList[index].brandName!,
                // textAlign: TextAlign.center,
                style: context.theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: 'AppSemiBold'
                ),
              ),
              subtitle: Text(
                controller.homeCarList[index].modelName!,
                style: context.theme.textTheme.bodySmall?.copyWith(fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// : HOME BRAND LAYOUT
  Widget brandListLayout(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 0, vertical: SMALL_PADDING),
      child: SizedBox(
        height: appbarHeight * 0.99,
        child: ListView.builder(
          padding: const EdgeInsets.only(
              left: SMALL_PADDING_15,
              right: SMALL_PADDING_12),
          itemCount:
          controller.homeBrandList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(
                right: SMALL_PADDING_12),
            child: Container(
              // width : 100,
              decoration: BoxDecoration(
                  color: AppColor.appWhiteColor,
                  borderRadius:
                  BorderRadius.circular(
                      CARD_RADIUS_NORMAL),
                  border: Border.all(
                      color: AppColor.appBlackColor
                          .withOpacity(0.25),
                      width: 0.5)),
              child: Padding(
                  padding: const EdgeInsets.all(
                      SMALL_PADDING),
                  child: Center(
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            height: 45,
                            width: 40,
                            imageUrl: controller
                                .homeBrandList[
                            index]
                                .strProfilePicture ??
                                '',
                            alignment: Alignment.center,
                            fit: BoxFit.fill,
                            errorWidget:
                                (context, url, error) =>
                                SizedBox(
                                  height: 45,
                                  width: 40,
                                  child: Center(
                                      child: Container(
                                        color: Colors.grey
                                            .withAlpha(20),
                                      )),
                                ),
                          ),
                          CommonWidget.getFieldSpacer(
                              width: 5.0),
                          Text(
                            controller
                                .homeBrandList[
                            index]
                                .brandName ??
                                "",
                            textAlign: TextAlign.center,
                            style: Fonts
                                .regularLabelTextStyle
                                .copyWith(fontSize: 15),
                          )
                        ],
                      ))),
            ),
          ),
        ),
      ),
    );
  }

  /// : HOME CATEGORY LAYOUT
  Widget categoryListLayout(BuildContext context){
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15),
        itemCount: controller.homeCategoryList.length,
        itemBuilder: (BuildContext ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Get.toNamed(
                    CategoryListScreen.route,
                    arguments: {
                      'assemblyId' : controller.homeCategoryList[index].id
                    }
                );
              },
              child: HomeCategoriesTile(
                category: controller.homeCategoryList[index],
              ),
            ),
          );
        }
    );
  }

  /// : OPEN PRODUCT BRAND BOTTOM SHEET
  showProductBrandBottomSheet() {
    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: Get.context!.theme.scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
        DraggableScrollableSheet(
          minChildSize: 0.2,
          initialChildSize: 0.80,
          maxChildSize: 0.80,
          expand: false,
          builder: (context, scrollController) => StatefulBuilder(
            builder: (context, setState) => Obx(
               () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonWidget.getFieldSpacer(),
                  DividerView(
                    width: 35.0,
                    height: 4.0,
                    color: AppColor.appDividerColor,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                      color: AppColor.appWhiteColor,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: SizedBox(
                            width: 35.0,
                            height: 35.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                              child: SvgPicture.asset(
                                AssetsHelper.getSVGIcon('ic_back.svg'),
                                height: 30.0,
                                width: 30.0,
                                colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15),
                              child: Text(
                                "chooseBrand".translate(),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING,vertical: SMALL_PADDING),
                    child: CustomTextField(
                      tecController: controller.searchBrandController,
                      focusNode: controller.fnSearchBrand,
                      isSearchField: true,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100)
                      ],
                      hintText: "searchBrand".translate(),
                      isShowPrefixIcon: false,
                      isShowSuffixIcon: true,
                      suffixIcon: "ic_research.svg",
                      enableSuggestions: true,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      onEditingComplete: (val) {
                        FocusScope.of(Get.context!).requestFocus(FocusNode());
                        controller.callGetBrandListAPI();
                      },
                      onChanged: (val){
                        controller.callGetBrandListAPI();
                      },
                    ),
                  ),
                  DividerView(
                    width: screenWidth,
                    height: 1.0,
                    color: AppColor.appDividerColor,
                  ),
                  Expanded(
                    child: FutureBuilder<bool>(
                        future: controller.fnBrand.value ? controller.callGetBrandListAPI() : null,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                                backgroundColor: AppColor.appPrimaryColor,
                                valueColor: AlwaysStoppedAnimation(AppColor.appWhiteColor),
                              ),
                            );
                          } else {
                            return controller.lstBrand.isNotEmpty
                                ? Obx(
                                  () => Stack(
                                children: [
                                  Padding(
                                    padding: controller.bottomSheetLoader.value ? const EdgeInsets.only(bottom: 50.0) : EdgeInsets.zero,
                                    child: ListView.builder(
                                        itemCount: controller.lstBrand.length,
                                        controller: controller.brandScrollController,
                                        itemBuilder: (context, index) => Container(
                                            height: 50.0,
                                            width: screenWidth,
                                            padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15),
                                            child: InkWell(
                                              onTap: () {
                                                controller.fnModel.value = true;
                                                controller.onChangeBrand(index);
                                                showProductModelBottomSheet();
                                              },
                                              child: Obx(
                                                    () => Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomMarqueeWidget(
                                                        child: Text(
                                                          controller.lstBrand[index].brandName ?? "",
                                                          style: context.theme.textTheme.bodyLarge,
                                                          textAlign: TextAlign.start,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 4.0),
                                                      child: SvgPicture.asset(
                                                        controller.lstBrand[index].isSelected!.value
                                                            ? AssetsHelper.getSVGIcon('ic_radio_fill.svg')
                                                            : AssetsHelper.getSVGIcon('ic_radio.svg'),
                                                        height: 25.0,
                                                        width: 25.0,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ))
                                    ),
                                  ),

                                  Visibility(
                                    visible: controller.bottomSheetLoader.value,
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
                              ),
                            )
                                : Center(child: Text("dataNoAvailable".translate()));
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  /// : OPEN PRODUCT MODEL BOTTOM SHEET
  showProductModelBottomSheet() {
    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: Get.context!.theme.scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
        DraggableScrollableSheet(
          minChildSize: 0.2,
          initialChildSize: 0.80,
          maxChildSize: 0.80,
          expand: false,
          builder: (context, scrollController) => StatefulBuilder(
            builder: (context, setState) => Obx(
                () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonWidget.getFieldSpacer(),
                  DividerView(
                    width: 35.0,
                    height: 4.0,
                    color: AppColor.appDividerColor,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                      color: AppColor.appWhiteColor,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: SizedBox(
                            width: 35.0,
                            height: 35.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                              child: SvgPicture.asset(
                                AssetsHelper.getSVGIcon('ic_back.svg'),
                                height: 30.0,
                                width: 30.0,
                                colorFilter: ColorFilter.mode(AppColor.appBlackColor, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15),
                              child: Text(
                                "chooseModel".translate(),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING,vertical: SMALL_PADDING),
                    child: CustomTextField(
                      tecController: controller.searchModelController,
                      focusNode: controller.fnSearchModel,
                      isSearchField: true,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100)
                      ],
                      hintText: "searchModel".translate(),
                      isShowPrefixIcon: false,
                      isShowSuffixIcon: true,
                      suffixIcon: "ic_research.svg",
                      enableSuggestions: true,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      onEditingComplete: (val) {
                        FocusScope.of(Get.context!).requestFocus(FocusNode());
                        controller.callGetModelListAPI(brandId: controller.selectedBrand!.brandId.toString());
                      },
                      onChanged: (val){
                        controller.callGetModelListAPI(brandId: controller.selectedBrand!.brandId.toString());
                      },
                    ),
                  ),
                  DividerView(
                    width: screenWidth,
                    height: 1.0,
                    color: AppColor.appDividerColor,
                  ),
                  Expanded(
                    child: Visibility(
                      visible: controller.vnIsShowLoader.value,
                      replacement: Visibility(
                        visible: controller.lstModel.isNotEmpty,
                        replacement: Center(
                          child: Text("dataNoAvailable".translate()),
                        ),
                        child: Obx(
                              () => Stack(
                            children: [
                              Padding(
                                padding: controller.bottomSheetLoader.value ? const EdgeInsets.only(bottom: 50.0) : EdgeInsets.zero,
                                child: ListView.builder(
                                    itemCount: controller.lstModel.length,
                                    controller: controller.modelScrollController,
                                    itemBuilder: (context, index) => Container(
                                        height: 50.0,
                                        width: screenWidth,
                                        padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15),
                                        child: InkWell(
                                          onTap: () {
                                            controller.fnModelType.value = true;
                                            controller.onChangeModel(index);
                                            showProductModelTypeBottomSheet();
                                          },
                                          child: Obx(
                                                () => Row(
                                              children: [
                                                Expanded(
                                                  child: CustomMarqueeWidget(
                                                    child: Text(
                                                      controller.lstModel[index].modelName ?? "",
                                                      style: context.theme.textTheme.bodyLarge,
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: SvgPicture.asset(
                                                    controller.lstModel[index].isSelected!.value
                                                        ? AssetsHelper.getSVGIcon('ic_radio_fill.svg')
                                                        : AssetsHelper.getSVGIcon('ic_radio.svg'),
                                                    height: 25.0,
                                                    width: 25.0,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ))),
                              ),

                              Visibility(
                                visible: controller.bottomSheetLoader.value,
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
                ],
              ),
            ),
          ),
        )
    );
  }

  /// : OPEN PRODUCT MODEL TYPE BOTTOM SHEET
  showProductModelTypeBottomSheet() {
    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: Get.context!.theme.scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
        DraggableScrollableSheet(
          minChildSize: 0.2,
          initialChildSize: 0.80,
          maxChildSize: 0.80,
          expand: false,
          builder: (context, scrollController) => StatefulBuilder(
            builder: (context, setState) =>  Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonWidget.getFieldSpacer(),
                  DividerView(
                    width: 35.0,
                    height: 4.0,
                    color: AppColor.appDividerColor,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                      color: AppColor.appWhiteColor,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: SizedBox(
                            width: 35.0,
                            height: 35.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                              child: SvgPicture.asset(AssetsHelper.getSVGIcon('ic_back.svg'),
                                  height: 30.0, width: 30.0, colorFilter: ColorFilter.mode(AppColor.appBlackColor, BlendMode.srcIn)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15),
                              child: Text(
                                "chooseModelType".translate(),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING,vertical: SMALL_PADDING),
                    child: CustomTextField(
                      tecController: controller.searchModelTypeController,
                      focusNode: controller.fnSearchModelType,
                      isSearchField: true,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100)
                      ],
                      hintText: "searchModelType".translate(),
                      isShowPrefixIcon: false,
                      isShowSuffixIcon: true,
                      suffixIcon: "ic_research.svg",
                      enableSuggestions: true,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      onEditingComplete: (val) {
                        FocusScope.of(Get.context!).requestFocus(FocusNode());
                        controller.callGetModelTypeListAPI(modelId: controller.selectedModel!.modelId.toString());
                        // controller.onSearchModelType("");
                      },
                      onChanged: (val){
                        controller.callGetModelTypeListAPI(modelId: controller.selectedModel!.modelId.toString());
                        // controller.onSearchModelType("");
                      },
                    ),
                  ),
                  DividerView(
                    width: screenWidth,
                    height: 1.0,
                    color: AppColor.appDividerColor,
                  ),
                  Expanded(
                    child: Visibility(
                      visible: controller.vnIsShowLoader.value,
                      replacement: Visibility(
                        visible: controller.lstModelType.isNotEmpty,
                        replacement: Center(
                          child: Text("dataNoAvailable".translate()),
                        ),
                        child: ListView.builder(
                            itemCount: controller.lstModelType.length,
                            controller: scrollController,
                            itemBuilder: (context, index) => Container(
                                height: 50.0,
                                width: screenWidth,
                                padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15),
                                child: InkWell(
                                  onTap: () {
                                    controller.onChangeModelType(index);
                                  },
                                  child: Obx(
                                        () => Row(
                                      children: [
                                        Expanded(
                                          child: CustomMarqueeWidget(
                                            child: Text(
                                              "${controller.lstModelType[index].typeName}",
                                              style: context.theme.textTheme.bodyLarge,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 4.0),
                                          child: SvgPicture.asset(
                                            controller.lstModelType[index].isSelected!.value
                                                ? AssetsHelper.getSVGIcon('ic_radio_fill.svg')
                                                : AssetsHelper.getSVGIcon('ic_radio.svg'),
                                            height: 25.0,
                                            width: 25.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ))),
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
                  SizedBox(
                    height: appbarHeight,
                    width: screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ButtonView(
                          buttonTextName: "cancel".translate(),
                          width: screenWidth * 0.45,
                          color: AppColor.appWhiteColor,
                          borderColor: context.theme.unselectedWidgetColor,
                          style: Fonts.buttonStyle.copyWith(color: AppColor.appBlackColor),
                          onPressed: () {
                            Get.back();
                            Get.back();
                            Get.back();
                          },
                        ),
                        CommonWidget.getFieldSpacer(width: 0.5),
                        ButtonView(
                          buttonTextName: "add".translate(),
                          width: screenWidth * 0.45,
                          color: AppColor.appPrimaryColor,
                          borderColor: AppColor.appPrimaryColor,
                          rxIsShowLoader: controller.vnIsShowLoader,
                          onPressed: () {
                            /// :  ADD NEW CAR API CALL
                            controller.checkValidationForAddNewCar(context);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}

class _LocalAppBar extends GetView<HomeController> {
  const _LocalAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      primary: true,
      automaticallyImplyLeading: false,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      titleSpacing: 0.0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15, vertical: SMALL_PADDING),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0)),
          tileColor: Get.isDarkMode ? context.theme.primaryColorLight : context.theme.unselectedWidgetColor,
          onTap: () {

          },
          horizontalTitleGap: 4.0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 15,left: 5,right: 0,bottom: 15),
            child: SvgPicture.asset(
                AssetsHelper.getSVGIcon('ic_research.svg'),
                colorFilter: ColorFilter.mode(Get.isDarkMode ? context.theme.unselectedWidgetColor : context.theme.primaryColorLight, BlendMode.srcIn)
            ),
          ),
          title: Text(
            "search".translate(),
            style: Fonts.editTextHintStyle,
            overflow: TextOverflow.ellipsis
          ),
        ),
      ),
    );
  }
}
