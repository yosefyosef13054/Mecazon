import 'package:flutter/material.dart';

class DirectionViewRTL extends StatelessWidget {
  final Widget? child;

  const DirectionViewRTL({Key? key, @required this.child})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          (Localizations.maybeLocaleOf(context)?.languageCode.contains('ar') ??
                  false)
              ? TextDirection.rtl
              : TextDirection.ltr,
      child: child!,
    );
  }
}
