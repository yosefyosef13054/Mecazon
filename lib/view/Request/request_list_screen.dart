import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/custom/button_view.dart';
import 'package:mecazone/custom/custom_marquee_widget.dart';
import 'package:mecazone/custom/divider_view.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/view/Request/add_request_screen.dart';
import 'package:mecazone/view/Request/edit_request_screen.dart';
import 'package:mecazone/view/Request/request_list_controller.dart';
import 'package:mecazone/helper/alert_helper.dart';
import 'package:mecazone/helper/dialog_helper.dart';
import 'package:mecazone/custom/direction_view_rtl.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/tiles/request_product_tile.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/view/Request/request_details_screen.dart';

class RequestListScreen extends GetView<RequestListController> {
  static const route = '/RequestListScreen';
  const RequestListScreen({Key? key}) : super(key: key);

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
            appBar: PreferredSize(
                preferredSize: Size(Get.width, kToolbarHeight*2),
                child: _LocalAppBar(controller)
            ),
            body: TabBarView(
              controller: controller.tabController,
              children: [_getCurrentRequestView(), _getPastRequestView()],
            )
        ),
      ),
    );
  }

  /// : GET TAB VIEW - REQUEST PRODUCT
  Widget _getCurrentRequestView() {
    return SizedBox(
      // color: AppColor.appWhiteColor,
      height: screenHeight,
      width: screenWidth,
      child: Obx(
        () => Visibility(
          visible: controller.vnIsShowLoader.value && controller.lstCurrentRequest.isEmpty,
          replacement: controller.lstCurrentRequest.isNotEmpty
              ? Stack(
                  children: [
                    Padding(
                      padding: controller.vnIsShowLoader.value ? const EdgeInsets.only(bottom: 50.0) : EdgeInsets.zero,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15, vertical: SMALL_PADDING_15),
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          controller: controller.currentScrollController,
                          itemCount: controller.lstCurrentRequest.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: SMALL_PADDING),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(RequestDetailScreen.route, arguments: controller.lstCurrentRequest[index].id);
                                },
                                child: RequestProductTile(
                                  requestProductData: controller.lstCurrentRequest[index],
                                  isShowEdit: true,
                                  onDeleteClick: () {
                                    controller.callDeleteRequestAPI();
                                  },
                                  onEditClick: () {
                                    Get.toNamed(
                                        EditRequestScreen.route,
                                        arguments: controller.lstCurrentRequest[index]
                                    )?.then((value){
                                      if(value){
                                        controller.callGetRequestListAPI(counter: 0);
                                      }
                                    });
                                  },
                                ),
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

  /// : GET TAB VIEW - REQUEST STORE
  Widget _getPastRequestView() {
    return SizedBox(
      // color: AppColor.appWhiteColor,
      height: screenHeight,
      width: screenWidth,
      child: Obx(
        () => Visibility(
          visible: controller.vnIsShowLoader.value && controller.lstPastRequest.isEmpty,
          replacement: controller.lstPastRequest.isNotEmpty
              ? Stack(
                  children: [
                    Padding(
                      padding: controller.vnIsShowLoader.value ? const EdgeInsets.only(bottom: 50.0) : EdgeInsets.zero,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING_15, vertical: SMALL_PADDING_15),
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          controller: controller.pastScrollController,
                          itemCount: controller.lstPastRequest.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: SMALL_PADDING),
                              child: InkWell(
                                onTap: () {},
                                child: RequestProductTile(requestProductData: controller.lstPastRequest[index], isShowEdit: false),
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
}

// ignore: must_be_immutable
class _LocalAppBar extends StatelessWidget {
  late RequestListController controller;
  _LocalAppBar(this.controller);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
                colorFilter: ColorFilter.mode(AppColor.appWhiteColor, BlendMode.srcIn)
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING),
        child: Text(
          "myRequests".translate(),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Fonts.cardTitleTextStyle.copyWith(color: AppColor.appWhiteColor),
        ),
      ),
      actions: [
        Visibility(
          visible: CommonWidget.user!.profileTypeId == USER_TYPE_1056_CUSTOMER,
          child: Padding(
            padding:  const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: SMALL_PADDING_12),
            child: InkWell(
              onTap: () {
                if(controller.isRequestLimitOver.value){
                  Get.toNamed(AddRequestScreen.route)?.then((value) {
                    if(value){
                      controller.callGetRequestListAPI(isCurrent: true, counter: 0);
                    }
                  });
                }
                else{
                  DialogHelper.showConfirmDialogAlert(
                      context,
                      dialogTitle: "maximumRequest".translate(),
                      dialogDesc: "${"maxRequestDesc1".translate()}${controller.totalRequestLimit.toString()}${"maxRequestDesc2".translate()}",
                      positiveBtnText: "contactUs",
                      negativeBtnText: "cancel",
                      icon: 'ic_store.svg',
                      callback: (val) {
                        if (val == true) {
                          AlertHelper.callOnPhone("+919876543210");
                        }
                      });
                }
              },
              child: Container(
                  width: 95,
                  padding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: AppColor.appWhiteColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.add,
                        color: AppColor.appWhiteColor,
                        size: 20.0,
                      ),
                      Text('add'.translate())
                    ],
                  )),
            ),
          ),
        ),
        Visibility(
          visible: CommonWidget.user!.profileTypeId == USER_TYPE_1057_PROFESSIONAL,
          child: Padding(
            padding:  const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: SMALL_PADDING),
            child: InkWell(
              onTap: () {
                showProductBrandBottomSheet();
              },
              child: SvgPicture.asset(
                  AssetsHelper.getSVGIcon('ic_filter.svg'),
                  height: 20.0,
                  width: 20.0,
                  colorFilter: ColorFilter.mode(AppColor.appWhiteColor, BlendMode.srcIn)
              ),
            ),
          ),
        ),
      ],
      bottom: TabBar(
        controller: controller.tabController,
        indicatorColor: AppColor.appWhiteColor,
        labelStyle: Fonts.editTextLabelStyle.copyWith(color: AppColor.appWhiteColor),
        tabs: [
          Tab(text: "current".translate()),
          Tab(text: "past".translate()),
        ],
      ),
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
          maxChildSize: 0.80,
          expand: false,
          builder: (context, scrollController) => Column(
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
                          padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING),
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
              DividerView(
                width: screenWidth,
                height: 1.0,
                color: AppColor.appDividerColor,
              ),
              Expanded(
                child: controller.lstBrand.isNotEmpty
                    ? Obx(
                      () => ListView.builder(
                      itemCount: controller.lstBrand.length,
                      controller: scrollController,
                      itemBuilder: (context, index) => Container(
                          height: 50.0,
                          width: screenWidth,
                          padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING),
                          child: InkWell(
                            onTap: () {
                              controller.lstBrand[index].isSelected!(!controller.lstBrand[index].isSelected!.value);
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
                )
                    : Center(child: Text("dataNoAvailable".translate())),
              ),
              SizedBox(
                height: appbarHeight,
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonView(
                      buttonTextName: "clearAll".translate(),
                      width: screenWidth * 0.45,
                      color: AppColor.appWhiteColor,
                      borderColor: context.theme.unselectedWidgetColor,
                      style: Fonts.buttonStyle.copyWith(color: AppColor.appBlackColor),
                      onPressed: () {
                        controller.onCancelAll();
                        Navigator.of(Get.context!).pop();
                      },
                    ),
                    CommonWidget.getFieldSpacer(width: 0.5),
                    ButtonView(
                      buttonTextName: "apply".translate(),
                      width: screenWidth * 0.45,
                      color: AppColor.appPrimaryColor,
                      borderColor: AppColor.appPrimaryColor,
                      rxIsShowLoader: controller.vnIsShowLoader,
                      onPressed: () {
                        controller.onFilterApply(isFromFilter: true);
                        Navigator.of(Get.context!).pop();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

}
