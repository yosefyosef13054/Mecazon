import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/model/Store/store_details_data_model.dart';

class ProductTile extends StatelessWidget {
  final StoreProducts? storeProducts;

  const ProductTile({Key? key, this.storeProducts}) : super(key: key);

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
              border: Border.all(
                  color: AppColor.appBlackColor.withOpacity(0.25), width: 0.5)),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (storeProducts!.productImagesView!.isEmpty ||
                    storeProducts!.productImagesView!.first.image!.isEmpty)
                    ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.32,
                  height: MediaQuery.of(context).size.width * 0.32,
                  child: SvgPicture.asset(
                    AssetsHelper.getSVGIcon("ic_logo.svg"),
                    height: 120,
                    width: 120,
                  ),
                )
                    : CachedNetworkImage(
                  width: MediaQuery.of(context).size.width * 0.32,
                  height: MediaQuery.of(context).size.width * 0.32,
                  imageUrl:
                  storeProducts?.productImagesView?.first.image ?? '',
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) => Container(
                    width: MediaQuery.of(context).size.width * 0.32,
                    height: MediaQuery.of(context).size.width * 0.32,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(CARD_RADIUS_NORMAL)),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                    width: MediaQuery.of(context).size.width * 0.32,
                    height: MediaQuery.of(context).size.width * 0.32,
                    child: SvgPicture.asset(
                      AssetsHelper.getSVGIcon("ic_logo.svg"),
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    storeProducts!.productName ?? "",
                    style: Fonts.regularTextStyle,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
              ]),
        )
      ],
    );
  }
}
