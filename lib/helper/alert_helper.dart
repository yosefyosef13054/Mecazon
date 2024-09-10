import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/style/app_theme.dart';

class AlertHelper {
  static showToast(String msg) {
    Get.snackbar(
      "",
      msg,
      messageText: Text(
          msg,
          style: Get.context!.theme.textTheme.bodyLarge?.copyWith(color: AppColor.appWhiteColor)
      ),
      titleText: const SizedBox(),
      duration: const Duration(seconds: 2),
      backgroundColor: AppColor.appPrimaryColor,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(SMALL_PADDING),
    );
  }

  static Future<void> callOnPhone(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

}
