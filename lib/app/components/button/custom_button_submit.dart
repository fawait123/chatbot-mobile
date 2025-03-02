import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/styles/style_color.dart';
import '../../core/styles/style_text.dart';

class CustomButtonSubmit extends StatelessWidget {
  final String title;
  final bool isDisabled;
  final void Function() onPressed;
  final int height;
  const CustomButtonSubmit(
      {super.key,
      required this.title,
      required this.isDisabled,
      required this.onPressed,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? () {} : onPressed,
      child: Text(
        title,
        style:
            CustomText.Bold(fontSize: 18.0, colorText: CustomColor.whiteColor),
      ),
      style: ButtonStyle(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevation: MaterialStateProperty.all<double>(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        )),
        textStyle: MaterialStateProperty.all<TextStyle>(
            CustomText.Bold(fontSize: 18.0, colorText: CustomColor.whiteColor)),
        foregroundColor:
            MaterialStateProperty.all<Color>(CustomColor.whiteColor),
        backgroundColor: MaterialStateProperty.all<Color>(isDisabled
            ? CustomColor.primaryColor.withOpacity(0.5)
            : CustomColor.primaryColor),
        fixedSize: MaterialStateProperty.all<Size?>(
            Size(Get.width, Get.height / height)),
      ),
    );
  }
}
