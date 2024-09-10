import 'package:flutter/material.dart';
import 'package:mecazone/style/app_theme.dart';

class Borders {
  static OutlineInputBorder border = OutlineInputBorder(
    borderSide:
    BorderSide(color: AppColor.appDividerColor.withOpacity(0.5), width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static OutlineInputBorder focusBlueBorder = OutlineInputBorder(
    borderSide:
    BorderSide(color: AppColor.appDividerColor.withOpacity(0.5), width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static OutlineInputBorder focusBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColor.appFocusBorderColor, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static OutlineInputBorder enableBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColor.appUnFocusBorderColor, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static OutlineInputBorder disableBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColor.appUnFocusBorderColor, width: 0),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColor.appRedColor, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  static UnderlineInputBorder borderWhite =
  const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white));

  static UnderlineInputBorder borderGrey = UnderlineInputBorder(
      borderSide: BorderSide(color: AppColor.appDividerColor));

  static UnderlineInputBorder focusGrey = UnderlineInputBorder(
      borderSide: BorderSide(color: AppColor.appDividerColor));

  static UnderlineInputBorder enableGrey = UnderlineInputBorder(
      borderSide: BorderSide(color: AppColor.appDividerColor));

  static UnderlineInputBorder disableGrey = UnderlineInputBorder(
      borderSide: BorderSide(color: AppColor.appDividerColor));
}