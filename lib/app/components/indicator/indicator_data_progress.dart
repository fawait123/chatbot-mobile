import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../core/styles/style_color.dart';
import '../../core/styles/style_text.dart';

class IndicatorDataProgress {
  static showLoading() {
    if (Get.isDialogOpen!) Get.back();
    if (Get.isSnackbarOpen) Get.back();
    Get.dialog(
      useSafeArea: true,
      barrierDismissible: false,
      Dialog(
        backgroundColor: CustomColor.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(24),
            GetPlatform.isIOS
                ? CupertinoActivityIndicator(
                    color: CustomColor.primaryColor,
                    radius: 20,
                  )
                : CircularProgressIndicator(
                    backgroundColor: CustomColor.whiteColor,
                    color: CustomColor.primaryColor,
                  ),
            const Gap(8),
            Text(
              "Loading...",
              style: CustomText.Regular(
                  fontSize: 14.0, colorText: CustomColor.blackColor),
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }

  static showLoadingDownload() {
    if (Get.isDialogOpen!) Get.back();
    if (Get.isSnackbarOpen) Get.back();
    Get.dialog(
      useSafeArea: true,
      barrierDismissible: false,
      Dialog(
        backgroundColor: CustomColor.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(24),
            GetPlatform.isIOS
                ? CupertinoActivityIndicator(
                    color: CustomColor.primaryColor,
                    radius: 20,
                  )
                : CircularProgressIndicator(
                    backgroundColor: CustomColor.whiteColor,
                    color: CustomColor.primaryColor,
                  ),
            const Gap(8),
            Text(
              "Download...",
              style: CustomText.Regular(
                  fontSize: 14.0, colorText: CustomColor.blackColor),
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
