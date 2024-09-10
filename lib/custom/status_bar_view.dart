import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarView extends StatelessWidget {

  final Widget? child;
  final bool? isLight;

  const StatusBarView({Key? key, required this.child, this.isLight}) : assert(child != null), super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isLightStatusBar= isLight ?? false;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isLightStatusBar?SystemUiOverlayStyle.light:SystemUiOverlayStyle.dark,
      child: child!,
    );
  }
}