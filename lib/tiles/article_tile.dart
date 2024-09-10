import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/model/TecDoc/Response/get_article_model.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class ArticleTile extends StatelessWidget {
  final ArticlesList? article;
  const ArticleTile({Key? key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 110,
      decoration: BoxDecoration(
          color: AppColor.appWhiteColor,
          borderRadius: BorderRadius.circular(CARD_RADIUS_NORMAL),
          border: Border.all(color: AppColor.appBlackColor.withOpacity(0.25), width: 0.5)
      ),
      // padding: const EdgeInsets.all(8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            article!.articleImagesList!.isNotEmpty ?
            article!.articleImagesList!.first.imageURL100!.isEmpty
                ? SvgPicture.asset(
              AssetsHelper.getSVGIcon("ic_logo.svg"),
              height: 110,
              width: 110,
              fit: BoxFit.fill,
            )
                : ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(CARD_RADIUS_NORMAL),
                    bottomLeft: Radius.circular(CARD_RADIUS_NORMAL)
                  ),
                  child: CachedNetworkImage(
                      width: 110,
                      height: 110,
                      imageUrl: article!.articleImagesList!.first.imageURL100!,
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
                          height: 110,
                          width: 110,
                        fit: BoxFit.fill,

                      ),
                    ),
                )
            : SvgPicture.asset(
              AssetsHelper.getSVGIcon("ic_logo.svg"),
              height: 110,
              width: 110,
              fit: BoxFit.fill,

            ),

            CommonWidget.getFieldSpacer(width: 8.0),

            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article!.mfrName ?? "",
                      style: Fonts.cardTextStyle,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      "${"articleNumber".translate()} : ${article!.articleNumber}",
                      style: Fonts.regularSmallTextStyle,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}