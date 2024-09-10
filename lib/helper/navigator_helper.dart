import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mecazone/utils/constants.dart';

class NavigatorHelper {
  static goTo(Widget widget, {Function? callback}) {
    Get.to(widget)?.then((value) {
      if (callback != null && value != null) {
        callback(value);
      }
    });
  }

  static replace(Widget widget, {Function? callback}) {
    Get.off(() => widget)?.then((value) {
      if (callback != null && value != null) {
        callback(value);
      }
    });
  }

  static void remove({bool? value}) {
    Get.back();
  }

  //*PUSH WITH ANIMATION
  static addWithAnimation(Widget widget,
      {Function? callback, PageTransitionType? pageTransitionType}) {
    navigatorKey.currentState!
        .push(
      PageTransition(
          duration: const Duration(milliseconds: 100),
          type: pageTransitionType ?? PageTransitionType.fade,
          child: widget),
    )
        .then((value) {
      if (callback != null && value != null) {
        callback(value);
      }
    });
  }

  //*PUSH WITH Replacement
  static replaceWithAnimation(Widget widget, {Function? callback}) {
    navigatorKey.currentState!
        .pushReplacement(
      PageTransition(
          duration: const Duration(milliseconds: 2000),
          type: PageTransitionType.fade,
          child: widget),
    )
        .then((value) {
      if (callback != null && value != null) {
        callback(value);
      }
    });
  }

  static void removeAllAndOpen(Widget widget) {
    navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );
  }

  static void openDialog(Widget widget, {Function? callback}) {
    navigatorKey.currentState!
        .push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, animation, _) {
        return widget;
      },
    ))
        .then((value) {
      if (callback != null) {
        callback(value);
      }
    });
  }

  static void openBottomSheet(BuildContext context, Widget widget,
      {Function? callback}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return widget;
        });
  }

  static void openBottomSheet2(BuildContext context, Widget widget,
      {Function? callback}) {
    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return widget;
        });
  }
}
