import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/custom/button_view.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/navigator_helper.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/localization/language_settings.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class DialogHelper {
  static showMonthYearPickerDialog(
      BuildContext context, Function(DateTime) callback) {
    showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColor.appPrimaryColor,
            colorScheme: ColorScheme.light(primary: AppColor.appPrimaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value.toString().isNotEmpty) {
        callback(value!);
      }
    });
  }

  static showYearPickerDialog(BuildContext context, DateTime selectedYear,
      Function(DateTime) callback) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
            child: Text(buildTranslate(context, 'year'),
                style: Fonts.cardTitleTextStyle
                    .copyWith(color: AppColor.appPrimaryColor))),
        // titlePadding: EdgeInsets.symmetric(vertical: SMALL_PADDING),
        contentPadding: const EdgeInsets.symmetric(vertical: SMALL_PADDING),
        contentTextStyle: Fonts.editTextLabelStyle,
        content: SizedBox(
          height: 300,
          width: 300,
          child: Theme(
            data: ThemeData.light().copyWith(
              primaryColor: AppColor.appPrimaryColor,
              colorScheme: ColorScheme.light(primary: AppColor.appPrimaryColor),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: YearPicker(
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
              selectedDate: selectedYear,
              onChanged: (value) {
                selectedYear = value;
                if (value.toString().isNotEmpty) {
                  NavigatorHelper.remove(value: true);
                  callback(value);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  static showConfirmDialogAlert(BuildContext context,
      {
      String? dialogTitle = "",
      String? dialogDesc,
      String? positiveBtnText,
      String? negativeBtnText,
      String? icon,
      bool isDisplayIcon = false,
      Function? callback}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          titlePadding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: SMALL_PADDING),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidget.getFieldSpacer(height: 30.0),

              Visibility(
                visible: isDisplayIcon,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: SMALL_PADDING_15),
                  child: Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                        color: AppColor.appWhiteColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            width: 2.0, color: AppColor.appPrimaryColor)),
                    child: Center(
                      child: SvgPicture.asset(
                        AssetsHelper.getSVGIcon(icon ?? 'ic_store.svg'),
                        height: 25.0,
                        width: 25.0,
                        colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn)
                      ),
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: dialogTitle!.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: SMALL_PADDING_15),
                  child: Text(
                    dialogTitle,
                    style: context.theme.textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              Text(
                dialogDesc ?? "",
                style: context.theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: SMALL_PADDING),
          actionsPadding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: SMALL_PADDING),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonView(
                  width: MediaQuery.of(context).size.width * 0.35,
                  buttonTextName:
                      buildTranslate(context, negativeBtnText ?? ""),
                  style:
                      Fonts.buttonStyle.copyWith(color: AppColor.appTextColor),
                  color: AppColor.appWhiteColor,
                  borderColor: AppColor.appButtonGreyColor,
                  onPressed: () {
                    Navigator.pop(context);
                    if (callback != null) callback(false);
                  },
                ),
                CommonWidget.getFieldSpacer(width: 5.0),
                ButtonView(
                  width: MediaQuery.of(context).size.width * 0.35,
                  buttonTextName:
                      buildTranslate(context, positiveBtnText ?? ""),
                  color: AppColor.appPrimaryColor,
                  borderColor: AppColor.appPrimaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                    if (callback != null) callback(true);
                  },
                )
              ],
            ),
            CommonWidget.getFieldSpacer(),
          ],
        );
      },
    );
  }

  static showGetDialog({
    String? dialogTitle = "",
    String? dialogDesc,
    String? positiveBtnText,
    String? negativeBtnText,
    String? icon,
    bool isDisplayIcon = false,
    Function? callback}){
    Get.defaultDialog(
      backgroundColor: Get.context!.theme.scaffoldBackgroundColor,
      radius: 15.0,
      titlePadding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: SMALL_PADDING),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonWidget.getFieldSpacer(height: 30.0),

          Visibility(
            visible: isDisplayIcon,
            child: Padding(
              padding: const EdgeInsets.only(bottom: SMALL_PADDING_15),
              child: Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                    color: AppColor.appWhiteColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        width: 2.0, color: AppColor.appPrimaryColor)),
                child: Center(
                  child: SvgPicture.asset(
                      AssetsHelper.getSVGIcon(icon ?? 'ic_store.svg'),
                      height: 25.0,
                      width: 25.0,
                      colorFilter: ColorFilter.mode(AppColor.appPrimaryColor, BlendMode.srcIn)
                  ),
                ),
              ),
            ),
          ),

          Visibility(
            visible: dialogTitle!.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(bottom: SMALL_PADDING_15),
              child: Text(
                dialogTitle,
                style: Get.context!.theme.textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Text(
            dialogDesc ?? "",
            style: Get.context!.theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: SMALL_PADDING, vertical: SMALL_PADDING),

      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonView(
              width: Get.width * 0.35,
              buttonTextName: "negativeBtnText".translate(),
              style:
              Fonts.buttonStyle.copyWith(color: AppColor.appTextColor),
              color: AppColor.appWhiteColor,
              borderColor: AppColor.appButtonGreyColor,
              onPressed: () {
                Get.back();
                if (callback != null) callback(false);
              },
            ),
            CommonWidget.getFieldSpacer(width: 5.0),
            ButtonView(
              width: Get.width * 0.35,
              buttonTextName:"positiveBtnText".translate(),
              color: AppColor.appPrimaryColor,
              borderColor: AppColor.appPrimaryColor,
              onPressed: () {
                Get.back();
                if (callback != null) callback(true);
              },
            )
          ],
        ),
        CommonWidget.getFieldSpacer(),
      ],

    );
  }
}
