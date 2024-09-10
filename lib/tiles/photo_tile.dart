import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mecazone/style/app_theme.dart';
import 'package:mecazone/utils/constants.dart';

class PhotoTile extends StatelessWidget {
  const PhotoTile(
      {Key? key, this.imageName, this.onPressed, this.isRemoveOption = true})
      : super(key: key);

  final Function? onPressed;
  final String? imageName;
  final bool isRemoveOption;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            imageName!.startsWith("http")
                ? CachedNetworkImage(
              height: 100,
              width: 120,
              imageUrl: imageName!,
              alignment: Alignment.center,
              fit: BoxFit.fill,
              progressIndicatorBuilder: (context, url, downloadProgress) =>Container(
                height: 100,
                width: 120,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Center(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: AppColor.appLightOrangeColor
                  ),
                ),
              ),
              errorWidget: (context, url, error) => SizedBox(
                height: 100,
                width: 120,
                child: Center(
                    child: Container(color: Colors.grey.withAlpha(20))
                ),
              ),
            )
                : Image.file(
                    File(imageName!),
                    height: 100,
                    width: 120,
                    fit: BoxFit.fill,
                  ),
            if (isRemoveOption == true)
              Padding(
                padding: const EdgeInsets.all(SMALL_PADDING),
                child: InkWell(
                  onTap: () {
                    onPressed!();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.appPrimaryColor,
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.close,
                        size: 10, color: AppColor.appWhiteColor),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
