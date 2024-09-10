import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mecazone/custom/custom_marquee_widget.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/model/Wishlist/wishlist_store_data_model.dart';

class WishlistStoreTile extends StatelessWidget {
  final WishListStoreList? wishlistStoreData;
  final VoidCallback? onClick;

  const WishlistStoreTile({Key? key, this.wishlistStoreData, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.width * 0.50,
          decoration: BoxDecoration(
              color: AppColor.appWhiteColor,
              borderRadius: BorderRadius.circular(CARD_RADIUS_NORMAL),
              border: Border.all(color: AppColor.appBlackColor.withOpacity(0.25), width: 0.5)),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    if (wishlistStoreData!.images!.isEmpty ||
                        wishlistStoreData!.images!.first.storeImage!.isEmpty)
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.width * 0.32,
                        child: SvgPicture.asset(
                          AssetsHelper.getSVGIcon("ic_logo.svg"),
                          height: 120,
                          width: 120,
                        ),
                      )
                    else
                      CachedNetworkImage(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.width * 0.32,
                        imageUrl:
                            wishlistStoreData?.images?.first.storeImage ?? '',
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        progressIndicatorBuilder:(context, url, downloadProgress) => Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.width * 0.32,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(CARD_RADIUS_NORMAL)),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: AppColor.appLightOrangeColor
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.width * 0.32,
                          child: SvgPicture.asset(
                            AssetsHelper.getSVGIcon("ic_logo.svg"),
                            height: 120,
                            width: 120,
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(SMALL_PADDING),
                      child: InkWell(
                        onTap: () {
                          onClick!();
                        },
                        child: SvgPicture.asset(
                            AssetsHelper.getSVGIcon('ic_wishlist_fill.svg'),
                            height: 18.0,
                            colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn)
                        ),
                      ),
                    )
                  ],
                ),
                CommonWidget.getFieldSpacer(height: 15.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.appWhiteColor),
                        elevation: MaterialStateProperty.all(0.0),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                width: 1.0, color: AppColor.appPrimaryColor),
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
                                wishlistStoreData!.storeName ?? "",
                                textAlign: TextAlign.center,
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
                        ),
                      ],
                    ),
                  ),
                ),
                CommonWidget.getFieldSpacer(height: 8.0),
              ]
          ),
        )
      ],
    );
  }
}
