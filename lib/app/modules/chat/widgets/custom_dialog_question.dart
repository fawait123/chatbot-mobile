import 'dart:developer';

import 'package:apps_consultation_pregnant/app/modules/chat/controllers/chat_controller.dart';

import 'package:apps_consultation_pregnant/app/modules/chat/controllers/chat_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/styles/style_color.dart';
import '../../../core/styles/style_text.dart';

class CustomDialogQuestion {
  Future<void> showDialog() {
    if (Get.isDialogOpen!) Get.back();
    if (Get.isSnackbarOpen) Get.back();
    // ChatController chatController = Get.find<ChatController>();
    ChatController chatController = Get.put(ChatController());
    return Get.dialog(
      useSafeArea: true,
      barrierDismissible: true,
      // WillPopScope(
      //   child:
      Dialog(
        backgroundColor: CustomColor.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose question",
                  style: CustomText.Medium(
                      fontSize: 18.0, colorText: CustomColor.blackColor),
                ),
                Gap(15),
                DropdownButtonFormField2(
                  isExpanded: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(right: 16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: CustomColor.blackColor.withOpacity(0.35),
                            width: 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: CustomColor.primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: CustomColor.blackColor.withOpacity(0.35),
                            width: 1),
                        borderRadius: BorderRadius.circular(4),
                      )),
                  hint: Text(
                    'Choose question',
                    style: CustomText.Regular(
                      fontSize: 14.0,
                      colorText: CustomColor.blackColor.withOpacity(0.6),
                    ),
                  ),
                  items: chatController.questionList.map((question) {
                    return DropdownMenuItem(
                      value: '${question.description}',
                      child: Text(
                        '${question.description}',
                        style: CustomText.Regular(
                            fontSize: 14.0, colorText: CustomColor.blackColor),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    chatController.getTypeQuestion(type: value.toString());
                  },
                  onSaved: (value) {
                    chatController.getTypeQuestion(type: value.toString());
                  },
                  validator: (val) {
                    if (val == null || val.toString().isEmpty) {}
                  },
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: CustomColor.blackColor,
                    ),
                    iconSize: 18,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    elevation: 1,
                    decoration: BoxDecoration(
                      color: CustomColor.whiteColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(10),
                      thickness: MaterialStateProperty.all(6),
                      thumbVisibility: MaterialStateProperty.all(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 70,
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  ),
                ),
                Gap(15),
                InkWell(
                  onTap: () {
                    chatController.postQuestion();
                  },
                  child: Container(
                    height: 38,
                    decoration: BoxDecoration(
                        color: CustomColor.primaryColor,
                        borderRadius: BorderRadius.circular(4)),
                    alignment: Alignment.center,
                    child: Text(
                      'Kirim',
                      style: CustomText.Medium(
                          fontSize: 16.0, colorText: CustomColor.whiteColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      //   onWillPop: () async => false,
      // )
    );
  }
}
