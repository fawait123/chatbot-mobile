import 'package:apps_consultation_pregnant/app/core/styles/style_color.dart';
import 'package:apps_consultation_pregnant/app/core/styles/style_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class CustomBubbleMessage extends StatelessWidget {
  final String? message;
  final bool? isSender;
  final Color backgroundColor;
  final Color textColor;

  const CustomBubbleMessage({
    super.key,
    this.message,
    this.isSender,
    this.backgroundColor = const Color(0xfff4f4f4), // Light gray
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      text: "${message}",
      textStyle: CustomText.Regular(
          fontSize: 18.0,
          colorText:
              isSender! ? CustomColor.whiteColor: CustomColor.blackColor),
      color: backgroundColor,
      tail: true,
      isSender: isSender as bool,
    );
    // return ConstrainedBox(
    //   constraints: BoxConstraints(maxWidth: Get.width * 0.5),
    //   child: Container(
    //     padding: const EdgeInsets.all(16.0),
    //     decoration: BoxDecoration(
    //       color: backgroundColor,
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(15.0), // Adjust as needed
    //         topRight: Radius.circular(15.0),
    //         bottomLeft:
    //             isSender! ? Radius.circular(0.0) : Radius.circular(15.0),
    //         bottomRight:
    //             isSender! ? Radius.circular(15.0) : Radius.circular(0.0),
    //       ),
    //     ),
    //     child: Text(
    //       message!,
    //       textAlign: isSender! ? TextAlign.left : TextAlign.right,
    //       style: CustomText.Regular(
    //           fontSize: 14.0,
    //           colorText:
    //               isSender! ? CustomColor.blackColor : CustomColor.whiteColor),
    //     ),
    //   ),
    // );
  }
}
