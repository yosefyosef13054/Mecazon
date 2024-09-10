import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mecazone/custom/custom_marquee_widget.dart';
import 'package:mecazone/model/Store/store_list_data_model.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/constants.dart';

class StoreTile extends StatelessWidget {
  final StoreList? storeData;
  final VoidCallback? onClick;

  const StoreTile({Key? key, this.storeData, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 260,
        decoration: BoxDecoration(
            color: AppColor.appWhiteColor,
            borderRadius: BorderRadius.circular(CARD_RADIUS_NORMAL),
            border: Border.all(
                color: AppColor.appBlackColor.withOpacity(0.25),
                width: 0.5)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (storeData!.storeManagementImagesView!.isEmpty || storeData!.storeManagementImagesView!.first.storeImage!.isEmpty)
                  ? SvgPicture.asset(
                    AssetsHelper.getSVGIcon("ic_logo.svg"),
                    height: 120,
                    width: MediaQuery.of(context).size.width * 0.45,
                  )
                  : Stack(alignment: Alignment.topRight, children: [
                CachedNetworkImage(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 120,
                  imageUrl: storeData?.storeManagementImagesView?.first.storeImage! ?? '',
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  progressIndicatorBuilder:(context, url, downloadProgress) => Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 120,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(CARD_RADIUS_NORMAL)),
                    ),
                    child: Center(child: CircularProgressIndicator(value: downloadProgress.progress,color: AppColor.appLightOrangeColor,)),
                  ),
                  errorWidget: (context, url, error) => SvgPicture.asset(
                    AssetsHelper.getSVGIcon("ic_logo.svg"),
                    height: MediaQuery.of(context).size.width * 0.45,
                    width: 120,
                  ),
                ),
                Visibility(
                    visible: CommonWidget.user?.profileTypeId == USER_TYPE_1056_CUSTOMER,
                    child: Padding(
                        padding: const EdgeInsets.all(SMALL_PADDING),
                        child: InkWell(
                            onTap: () {
                              onClick!();
                            },
                            child: SvgPicture.asset(
                                AssetsHelper.getSVGIcon(storeData?.isWishListed == true ? 'ic_wishlist_fill.svg' : 'ic_wishlist.svg'),
                                height: 18.0,
                                colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn)
                            )
                        )
                    )
                )
              ]),
              CommonWidget.getFieldSpacer(height: 15.0),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColor.appWhiteColor),
                          elevation: MaterialStateProperty.all(0.0),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  width: 1.0,
                                  color: AppColor.appPrimaryColor),
                            ),
                          )),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CustomMarqueeWidget(
                                child: Center(
                                  child: Text(
                                    storeData!.storeName ?? "",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: Fonts.regularTextStyle.copyWith(
                                      color: AppColor.appPrimaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SvgPicture.asset(
                              AssetsHelper.getSVGIcon('ic_radio_fill.svg'),
                              height: 18.0,
                            )
                          ]))),
              // CommonWidget.getFieldSpacer(height: 8.0),
            ]));
  }
}
