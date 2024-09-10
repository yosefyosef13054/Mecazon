import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:get/get.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/helper/shared_pref.dart';
import 'package:mecazone/view/Home/home_screen.dart';
import 'package:mecazone/view/Login/login_screen.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/helper/notification.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool requireConsent = true;
  var permGranted = "granted", permDenied = "denied", permUnknown = "unknown", permProvisional = "provisional";
  Future<String>? permissionStatusFuture;

  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';

  @override
  void initState() {
    super.initState();
    getCheckNotificationPermStatus();
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();
    startTime();
    // firebaseMessaging.streamCtlr.stream.listen(_changeData);
    // firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    // firebaseMessaging.titleCtlr.stream.listen(_changeTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: AppColor.appWhiteColor,
        child: Center(
          child: SvgPicture.asset(
            AssetsHelper.getSVGIcon("ic_splashlogo.svg"),
            // width: MediaQuery.of(context).size.width * 0.7,
          ),
        ),
      ),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, navigationPage);
  }

  void navigationPage() async {
    var isLoginOrNot = await SharedPref.readPreferenceValue(isLogin, PrefEnum.BOOL);
    bool isFirstTimeOrNot = await SharedPref.readPreferenceValue(isFirstTime, PrefEnum.BOOL);
    if (isFirstTimeOrNot) {
      if (isLoginOrNot) {
        Get.offAllNamed(HomeScreen.route);
      } else {
        Get.toNamed(LoginScreen.route);
      }
    } else {
      SharedPref.savePreferenceValue(isFirstTime, true);
      Get.toNamed(LoginScreen.route);
    }
  }

  Future<String> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus().then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return permDenied;
        case PermissionStatus.granted:
          return permGranted;
        case PermissionStatus.unknown:
          return permUnknown;
        default:
          return "";
      }
    });
  }

// _changeData(String msg) => setState(() => notificationData = msg);
// _changeBody(String msg) => setState(() => notificationBody = msg);
// _changeTitle(String msg) => setState(() => notificationTitle = msg);

}
