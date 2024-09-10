import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mecazone/model/Wishlist/wishlist_product_data_model.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/constants.dart';

class WishlistProductTile extends StatelessWidget {
  final WishlistProductList? wishlistProductData;
  final VoidCallback? onClick;

  const WishlistProductTile({Key? key, this.wishlistProductData, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.width * 0.45,
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
                    if (wishlistProductData!.image!.isEmpty || wishlistProductData!.image!.first.image!.isEmpty)
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
                        imageUrl: wishlistProductData?.image?.first.image ?? '',
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        progressIndicatorBuilder: (context, url, downloadProgress) => Container(
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
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    wishlistProductData!.productName ?? "",
                    style: Fonts.regularTextStyle,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
              ]
          ),
        )
      ],
    );
  }
}
