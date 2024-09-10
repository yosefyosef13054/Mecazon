import 'package:flutter/material.dart';
import 'package:mecazone/model/Common/notification_data_model.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/constants.dart';

class NotificationTile extends StatelessWidget {
  final NotificationList? notification;
  const NotificationTile({Key? key, this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.appWhiteColor,
          borderRadius: BorderRadius.circular(CARD_RADIUS_NORMAL),
          border: Border.all(color: AppColor.appBlackColor.withOpacity(0.25), width: 0.5)
      ),
      child: ListTile(
        onTap: () {

        },
        leading: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: CircleAvatar(
            backgroundColor:
            AppColor.appLightOrangeColor,
            maxRadius: 30.0,
            child: Text(
              notification?.title?[0].toUpperCase() ?? "M",
              style: Fonts.regularTextStyle.copyWith(
                  fontFamily: 'AppSemiBold',
                  color: AppColor.appPrimaryColor
              ),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            side: BorderSide(
                color: AppColor.appPrimaryColor,
                width: 1.0)
        ),
        tileColor: AppColor.appLightOrangeColor,
        minVerticalPadding: 0.0,
        visualDensity: const VisualDensity(horizontal: 0, vertical: 0.0),
        contentPadding: const EdgeInsets.symmetric(horizontal: -4.0, vertical: 0.0),
        horizontalTitleGap: 4.0,
        title: Text(
          notification?.title ?? "",
          style: Fonts.regularTextStyle.copyWith(
            fontFamily: 'AppSemiBold',
            color: AppColor.appPrimaryColor
          ),
        ),
        subtitle: Text(
          notification?.description ?? "",
          style: Fonts.regularSmallTextStyle.copyWith(fontSize: 14),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
