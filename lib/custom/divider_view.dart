import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/style/app_theme.dart';

class DividerView extends StatelessWidget {
  const DividerView({
    Key? key,
    this.color,
    this.width,
    this.height,
  }) : super(key: key);

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? Get.width,
        height: height ?? 1,
        color: color ?? AppColor.appDividerColor);
  }
}
