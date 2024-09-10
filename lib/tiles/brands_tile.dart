import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mecazone/custom/custom_marquee_widget.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/model/Product/brand_data_model.dart';

class BrandsTile extends StatelessWidget {
  final BrandList? brand;

  const BrandsTile({Key? key, this.brand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.appWhiteColor,
          borderRadius: BorderRadius.circular(CARD_RADIUS_NORMAL),
          border: Border.all(color: AppColor.appBlackColor.withOpacity(0.25), width: 0.5)),
      child: Padding(
          padding: const EdgeInsets.all(SMALL_PADDING),
          child: Center(
              child: Row(
                children: [
                  CachedNetworkImage(
                    height: 45,
                    width: 40,
                    imageUrl: brand?.strProfilePicture ?? "",
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>Container(
                      height: 45,
                      width: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: AppColor.appLightOrangeColor
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => SizedBox(
                      height: 45,
                      width: 40,
                      child: Center(
                          child: Container(color: Colors.grey.withAlpha(20))
                      ),
                    ),
                  ),
                  CommonWidget.getFieldSpacer(width: 5.0),
                  Flexible(
                    child: CustomMarqueeWidget(
                      child: Text(
                        brand?.brandName ?? "",
                        textAlign: TextAlign.center,
                        style: Fonts.regularLabelTextStyle.copyWith(fontSize: 15),
                      ),
                    ),
                  )
                ],
              )
          )
      ),
    );
  }
}