import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mecazone/view/Login/login_screen.dart';
import 'package:mecazone/custom/button_view.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/localization/language_settings.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class ApprovalScreen extends StatelessWidget {
  const ApprovalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING, vertical: MAIN_PADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonWidget.getFieldSpacer(height: 40.0),
            SvgPicture.asset(
              AssetsHelper.getSVGIcon("ic_logo.svg"),
              height: 120,
              width: 120,
            ),
            CommonWidget.getFieldSpacer(height: 30.0),
            SizedBox(
              width: screenWidth,
              child: Text(
                buildTranslate(context, "adminApprovalPendingDesc"),
                textAlign: TextAlign.center,
                style: context.theme.textTheme.labelLarge,
              ),
            ),
            CommonWidget.getFieldSpacer(height: 30.0),

            ButtonView(
              buttonTextName: buildTranslate(context, "backToLogin"),
              color: AppColor.appPrimaryColor,
              borderColor: AppColor.appPrimaryColor,
              onPressed: () {
                Get.offAllNamed(LoginScreen.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
