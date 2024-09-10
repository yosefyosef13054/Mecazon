import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mecazone/helper/assets_helper.dart';
import 'package:mecazone/localization/language_settings.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';

class BoardingTile extends StatelessWidget {
  final String? iconName;
  final String? titleName;
  final String? subDescription;
  final bool? isLastIndex;
  final VoidCallback? callback;

  const BoardingTile(
      {Key? key,
      this.iconName,
      this.titleName,
      this.subDescription,
      this.isLastIndex,
      this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.50,
            width: constraints.maxWidth,
            child: SvgPicture.asset(
              AssetsHelper.getSVGIcon(iconName!),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.50,
            width: constraints.maxWidth,
            child: Padding(
              padding: const EdgeInsets.all(MAIN_PADDING),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonWidget.getFieldSpacer(),
                  Text(buildTranslate(context, titleName!),
                      style: Fonts.cardTitleTextStyle,
                      textAlign: TextAlign.center),
                  CommonWidget.getFieldSpacer(),
                  Text(buildTranslate(context, subDescription!),
                      style: Fonts.cardLabelTextStyle,
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
