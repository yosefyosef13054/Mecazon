import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mecazone/custom/divider_view.dart';
import 'package:mecazone/utils/common_widget.dart';
import 'package:mecazone/utils/constants.dart';
import 'package:mecazone/localization/language_settings.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/style/fonts.dart';
import 'package:mecazone/utils/log.dart';

class ImagePickerBottomSheet extends StatefulWidget {
  final Function? callBackImages;
  const ImagePickerBottomSheet({Key? key, this.callBackImages})
      : super(key: key);

  @override
  State<ImagePickerBottomSheet> createState() => _ImagePickerBottomSheetState();
}

class _ImagePickerBottomSheetState extends State<ImagePickerBottomSheet> {
  Future<void> pickImage(int index) async {
    try {
      if (index == 1) {
        XFile? pickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        Log.debug("picked file = ${pickedFile!.path.toString()}");
        if (pickedFile.path.isNotEmpty) {
          widget.callBackImages!(pickedFile);
        }
      } else {
        XFile? pickedFile =
            await ImagePicker().pickImage(source: ImageSource.camera);
        Log.debug("picked file = ${pickedFile!.path.toString()}");
        if (pickedFile.path.isNotEmpty) {
          widget.callBackImages!(pickedFile);
        }
      }
    } on PlatformException catch (e) {
      Log.debug("Exception = ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.appWhiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(CARD_RADIUS_NORMAL),
              topRight: Radius.circular(CARD_RADIUS_NORMAL))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(SMALL_PADDING),
            child: Center(
              child: DividerView(
                width: 50.0,
                height: 1.0,
                color: AppColor.appPrimaryColor,
              ),
            ),
          ),
          /// : GALLERY
          ElevatedButton.icon(
            onPressed: () {
              pickImage(1);
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(AppColor.appWhiteColor),
              elevation: MaterialStateProperty.all(0.0),
            ),
            icon: Icon(Icons.photo_camera_back,
                size: 25.0, color: AppColor.appBlackColor),
            label: Text(buildTranslate(context, "gallery"),
                style: Fonts.regularTextStyle),
          ),
          DividerView(
            width: screenWidth,
            height: 1.0,
            color: AppColor.appDividerColor,
          ),
          /// : CAMERA
          ElevatedButton.icon(
            onPressed: () {
              pickImage(0);
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColor.appWhiteColor),
                elevation: MaterialStateProperty.all(0.0)),
            icon: Icon(Icons.camera_alt_rounded,
                size: 25.0, color: AppColor.appBlackColor),
            label: Text(buildTranslate(context, "camera"),
                style: Fonts.regularTextStyle),
          ),
          CommonWidget.getFieldSpacer(height: 10.0),
        ],
      ),
    );
  }
}
