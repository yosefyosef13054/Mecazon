import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/model/Product/sub_category_data_model.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class SubCategoriesTile extends StatelessWidget {
  final SubCategoryList? subCategory;

  const SubCategoriesTile({Key? key, this.subCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: 95,
      decoration: BoxDecoration(
        color: AppColor.appWhiteColor,
          borderRadius: BorderRadius.circular(CARD_RADIUS_NORMAL),
          border: Border.all(color: AppColor.appBlackColor.withOpacity(0.25), width: 0.5)
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            subCategory!.strProfilePicture!.isEmpty
                ? SvgPicture.asset(
              AssetsHelper.getSVGIcon("ic_logo.svg"),
              height: 95,
              width: 95,
            )
                : ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(CARD_RADIUS_NORMAL),
                      bottomLeft: Radius.circular(CARD_RADIUS_NORMAL)
                  ),
                  child: CachedNetworkImage(
                      width: 95,
                      height: 95,
                      imageUrl: subCategory!.strProfilePicture ?? '',
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder:(context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: AppColor.appLightOrangeColor,
                            ),
                      ),
                      errorWidget: (context, url, error) => SvgPicture.asset(
                          AssetsHelper.getSVGIcon("ic_logo.svg"),
                          height: 95,
                          width: 95,
                      ),
                  ),
                ),

            CommonWidget.getFieldSpacer(width: 8.0),

            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  subCategory!.categoryName ?? "",
                  style: Fonts.cardTextStyle,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ),
          ]
      ),
    );
  }
}