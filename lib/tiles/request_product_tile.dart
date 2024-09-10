import 'package:flutter/material.dart';
import 'package:mecazone/custom/button_view.dart';
import 'package:mecazone/custom/custom_marquee_widget.dart';
import 'package:mecazone/model/Request/request_data_model.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/localization/language_settings.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/constants.dart';

class RequestProductTile extends StatelessWidget {
  final ProductRequestList? requestProductData;
  final VoidCallback? onDeleteClick, onEditClick;
  final bool isShowEdit;

  const RequestProductTile(
      {Key? key,
      this.requestProductData,
      this.onDeleteClick,
      this.onEditClick,
      this.isShowEdit = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColor.appWhiteColor,
          borderRadius: BorderRadius.circular(CARD_RADIUS_NORMAL),
          border: Border.all(color: AppColor.appBlackColor.withOpacity(0.25), width: 0.5)),
      child: Padding(
        padding: const EdgeInsets.all(SMALL_PADDING_12),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomMarqueeWidget(
                child: Text(
                  requestProductData!.productName ?? "",
                  style: Fonts.regularTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              CommonWidget.getFieldSpacer(height: SMALL_PADDING),
              CustomMarqueeWidget(
                child: Text(
                    "${requestProductData!.brandName}, ${requestProductData!.modelName}, ${requestProductData!.year}",
                    style: Fonts.regularSmallTextStyle),
              ),
              CommonWidget.getFieldSpacer(height: SMALL_PADDING),
              Text(
                requestProductData!.description ?? "",
                maxLines: 3,
                style: Fonts.regularSmallTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
              Visibility(
                  visible: isShowEdit,
                  child: CommonWidget.getFieldSpacer(height: SMALL_PADDING)),
              Visibility(
                visible: isShowEdit,
                child: LayoutBuilder(
                  builder: (p0, p1) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ButtonView(
                        width: p1.maxWidth * 0.47,
                        borderRadius: CARD_RADIUS_NORMAL,
                        buttonTextName: buildTranslate(context, "delete"),
                        style: Fonts.buttonStyle.copyWith(
                          color: AppColor.appPrimaryColor,
                          fontSize: 14.0,
                          fontFamily: "AppRegular",
                        ),
                        color: AppColor.appWhiteColor,
                        borderColor: AppColor.appPrimaryColor,
                        onPressed: () {
                          // Get.back();
                          onDeleteClick!();
                        },
                      ),
                      CommonWidget.getFieldSpacer(width: p1.maxWidth * 0.05),
                      ButtonView(
                        width: p1.maxWidth * 0.47,
                        borderRadius: CARD_RADIUS_NORMAL,
                        buttonTextName: buildTranslate(context, "editRequest"),
                        style: Fonts.buttonStyle.copyWith(
                          fontSize: 14.0,
                          fontFamily: "AppRegular",
                        ),
                        color: AppColor.appPrimaryColor,
                        borderColor: AppColor.appPrimaryColor,
                        onPressed: () {
                          // Get.back();
                          onEditClick!();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
