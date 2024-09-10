import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/model/Home/home_data_model.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class HomeCategoriesTile extends StatelessWidget {
  final HomeCategoryList? category;

  const HomeCategoriesTile({Key? key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: AppColor.appWhiteColor,
        borderRadius: BorderRadius.circular(CARD_RADIUS_NORMAL),
        border: Border.all(
            color: AppColor.appBlackColor.withOpacity(0.25),
            width: 0.5
        )
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            category!.strImage!.isEmpty
                ? SvgPicture.asset(
                  AssetsHelper.getSVGIcon("ic_logo.svg"),
                  height: 95,
                  width: 95,
                )
                : CachedNetworkImage(
              width: 95,
              height: 95,
              imageUrl: category!.strImage ?? '',
              alignment: Alignment.center,
              fit: BoxFit.contain,
              progressIndicatorBuilder:
                  (context, url, downloadProgress) => Container(
                height: 95,
                width: 95,
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
                width: 95,
                height: 95,
                child: Center(
                    child: Container(
                      color: Colors.grey.withAlpha(20),
                    )),
              ),
            ),

            CommonWidget.getFieldSpacer(width: 8.0),

            Expanded(
              flex: 1,
              child: Text(
                category!.shortCutName ?? "",
                style: Fonts.cardTextStyle,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ]),
    );
  }
}