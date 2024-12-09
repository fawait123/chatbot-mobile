import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/styles/style_color.dart';
import '../../core/styles/style_text.dart';

class CustomSnackbarHelper {
  static showSnackbarDefault({required String title,required String description}) {
    if (Get.isDialogOpen!) Get.back();
    if (Get.isSnackbarOpen) Get.back();
    Get.snackbar(
      '$title',
      '$description',
      titleText: Text('$title', style: CustomText.Medium(fontSize: 16.0, colorText: CustomColor.blackColor),),
      messageText: Text('$description', style: CustomText.Regular(fontSize: 14.0, colorText: CustomColor.blackColor),),
      isDismissible: true,
      colorText: CustomColor.blackColor,
      snackPosition: SnackPosition.TOP,
      forwardAnimationCurve: Curves.easeInOut,
      reverseAnimationCurve: Curves.easeOut,
      // backgroundColor: CustomColor.primaryColor
    );
  }
}