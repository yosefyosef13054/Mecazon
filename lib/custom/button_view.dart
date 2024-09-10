import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/constants.dart';

class ButtonView extends StatelessWidget {
  const ButtonView(
      {Key? key,
      this.buttonTextName,
      this.onPressed,
      this.width,
      this.margin,
      this.color,
      this.height,
      this.style,
      this.borderRadius,
      this.borderColor,
      this.rxIsShowLoader})
      : super(key: key);

  final String? buttonTextName;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final double? borderRadius;
  final TextStyle? style;
  final double? margin;
  final Color? color;
  final Color? borderColor;
  // final ValueNotifier<bool>? vnIsShowLoader;
  final RxBool? rxIsShowLoader;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width * 0.9,
        height: height ?? 45,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(borderRadius ?? CARD_CURVE_RADIUS),
          border: Border.all(color: borderColor ?? AppColor.appPrimaryColor),
          color: color ?? AppColor.appPrimaryColor,
        ),
        child: Center(
          child: (rxIsShowLoader != null)
              ? Obx(
                ()=> Visibility(
                visible: rxIsShowLoader!.value,
                replacement: Text(
                  buttonTextName!,
                  style: style ?? Fonts.buttonStyle,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  backgroundColor: context.theme.scaffoldBackgroundColor,
                  valueColor:
                  AlwaysStoppedAnimation(AppColor.appBlackColor),
                ),
              )
          )
              : Text(
                  buttonTextName!,
                  style: style ?? Fonts.buttonStyle,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
    );
  }
}
