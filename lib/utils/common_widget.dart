import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/string_helper.dart';
import 'package:mecazone/model/Common/settings_data_model.dart';
import 'package:mecazone/model/User/user_data_model.dart';
import 'package:mecazone/style/app_theme.dart';

class CommonWidget {
  static User? user;
  static CommonSettings? commonSettings;

  static Widget getFieldSpacer({double? height, double? width}) {
    return SizedBox(
      height: height ?? 10.0,
      width: width ?? 0.0,
    );
  }

  static Widget getActiveStatus(BuildContext context, bool status) {
    return Row(
      children: [
        CircleAvatar(
          radius: 5.0,
          backgroundColor:
          status ? AppColor.appGreenColor : context.theme.unselectedWidgetColor,
        ),
        getFieldSpacer(width: 2.0),
        Text(
            status ? "active".translate() : "inactive".translate(),
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.bodySmall
        )
      ],
    );
  }
}
