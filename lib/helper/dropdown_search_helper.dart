import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/custom/divider_view.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/localization/language_settings.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/borders.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class DropDownSearchHelper {
  static getDropDownButtonProps() {
    return DropdownButtonProps(
        style: ButtonStyle(
            backgroundColor:MaterialStateProperty.all(Get.context!.theme.unselectedWidgetColor),
            elevation: MaterialStateProperty.all(0.0),
            side: MaterialStateProperty.all(BorderSide.none),
            iconSize: MaterialStateProperty.all(5.0),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: const BorderSide(width: 0, color: Colors.white),
              ),
            )
        )
    );
  }

  static getDropDownDecoratorProps(BuildContext context,
      {bool hasFocused = false}) {
    return DropDownDecoratorProps(
        textAlign: TextAlign.center,
        dropdownSearchDecoration: InputDecoration(
            filled: true,
            fillColor: hasFocused
                ? Get.context!.theme.canvasColor
                : Get.context!.theme.unselectedWidgetColor,
            hintText: buildTranslate(context, "searchProvince"),
            hintStyle: Get.context!.theme.textTheme.headlineSmall,
            errorStyle: Get.context!.theme.textTheme.labelSmall,
            contentPadding: const EdgeInsets.fromLTRB(5.0, 5.0, 2.0, 5.0),
            focusedBorder: Borders.focusBorder,
            focusedErrorBorder: Borders.focusBorder,
            enabledBorder: Borders.enableBorder,
            disabledBorder: Borders.disableBorder,
            errorBorder: Borders.errorBorder));
  }

  static getBottomSheetProps() {
    return BottomSheetProps(
      backgroundColor: Get.context!.theme.scaffoldBackgroundColor,
      elevation: 5.0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))
      ),
    );
  }

  static getBottomSheetSearchFieldDecoration({String hintText="",String? suffixIcon,bool hasFocused = false}) {
    return InputDecoration(
        filled: true,
        fillColor: hasFocused
            ? Get.context!.theme.canvasColor
            : Get.context!.theme.unselectedWidgetColor,
        hintText: hintText.translate(),
        hintStyle: Get.context!.theme.textTheme.headlineSmall,
        errorStyle: Get.context!.theme.textTheme.labelSmall,
        errorMaxLines: 2,
        contentPadding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(top: 15,left: 5,right: 0,bottom: 15),
          child: SvgPicture.asset(
              AssetsHelper.getSVGIcon(suffixIcon ?? 'ic_research.svg'),
              colorFilter: ColorFilter.mode(hasFocused
                  ? Get.context!.theme.primaryColor
                  : Get.context!.theme.primaryColorLight, BlendMode.srcIn
              )
          ),
        ),
        focusedBorder: Borders.focusBorder,
        focusedErrorBorder: Borders.focusBorder,
        enabledBorder: Borders.enableBorder,
        disabledBorder: Borders.disableBorder,
        errorBorder: Borders.errorBorder
    );
  }

  static getBottomSheetHeaderLayout({String titleName = ""}) {
    return Column(
      children: [
        CommonWidget.getFieldSpacer(),
        DividerView(
          width: 35.0,
          height: 4.0,
          color: AppColor.appDividerColor,
        ),
        CommonWidget.getFieldSpacer(),
        Row(
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
                      colorFilter: ColorFilter.mode( Get.context!.theme.primaryColorLight, BlendMode.srcIn)
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING),
                  child: Text(
                    titleName.translate(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Get.context!.theme.textTheme.displayLarge?.copyWith(color: Get.context!.theme.primaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
