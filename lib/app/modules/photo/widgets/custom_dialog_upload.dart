import 'dart:io';
import 'dart:ui';

import 'package:apps_consultation_pregnant/app/components/text_input/default_text_input.dart';
import 'package:apps_consultation_pregnant/app/core/styles/style_text.dart';
import 'package:apps_consultation_pregnant/app/modules/photo/controllers/photo_controller.dart';

import 'package:apps_consultation_pregnant/app/modules/photo/controllers/photo_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/styles/style_color.dart';

class CustomDialogUpload {
  static Future<void> showDialogUpload() async {
    final photoController = Get.put(PhotoController());
    return Get.dialog(
      useSafeArea: true,
      barrierDismissible: true,
      Dialog(
        backgroundColor: CustomColor.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Choose Media Upload',
                style: CustomText.Medium(
                    fontSize: 18.0, colorText: CustomColor.blackColor),
              ),
              Gap(15),
              Obx(
                () => photoController.imageUpload.value != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.file(
                            photoController.imageUpload.value!,
                            height: Get.height * 0.2,
                            width: Get.width * 0.5,
                          ),
                          const SizedBox(
                            height: 8,
                          ), // Jarak antara row dan text input
                          DefaultTextInput(
                            controller: photoController.description,
                            hintText: 'Keterangan',
                            keyboardType: TextInputType.text,
                            textStyle: CustomText.Regular(
                              fontSize: 12.0,
                              colorText: CustomColor.greyColor.withOpacity(0.5),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center, // Rata tengah
                            children: [
                              InkWell(
                                onTap: () async {
                                  await photoController.useImageGallery();
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center, // Tengah
                                  child: Icon(
                                    Icons.image_rounded,
                                    size: 40, // Ukuran lebih proporsional
                                    color: CustomColor.primaryColor
                                        .withOpacity(0.7),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10), // Jarak antar ikon
                              InkWell(
                                onTap: () async {
                                  await photoController.useImageCamera();
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center, // Tengah
                                  child: Icon(
                                    Icons.photo_camera_rounded,
                                    size: 40,
                                    color: CustomColor.primaryColor
                                        .withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
              Gap(15),
              photoController.fileNameController.value.text != null
                  ? Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              photoController.cancelUpload();
                            },
                            child: Container(
                              height: 38,
                              width: Get.width * 0.5,
                              decoration: BoxDecoration(
                                  color: CustomColor.whiteColor,
                                  borderRadius: BorderRadius.circular(4)),
                              alignment: Alignment.center,
                              child: Text(
                                'Cancel',
                                style: CustomText.Medium(
                                    fontSize: 16.0,
                                    colorText: CustomColor.blackColor),
                              ),
                            ),
                          ),
                        ),
                        Gap(10),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            if (photoController
                                .fileNameController.value.text.isNotEmpty) {
                              photoController.postPhoto();
                            }
                          },
                          child: Container(
                            height: 38,
                            width: Get.width * 0.5,
                            decoration: BoxDecoration(
                                color: CustomColor.primaryColor,
                                borderRadius: BorderRadius.circular(4)),
                            alignment: Alignment.center,
                            child: Text(
                              'Kirim',
                              style: CustomText.Medium(
                                  fontSize: 16.0,
                                  colorText: CustomColor.whiteColor),
                            ),
                          ),
                        ))
                      ],
                    )
                  : InkWell(
                      onTap: () {
                        photoController.postPhoto();
                      },
                      child: Container(
                        height: 38,
                        width: Get.width * 0.5,
                        decoration: BoxDecoration(
                            color: CustomColor.primaryColor,
                            borderRadius: BorderRadius.circular(4)),
                        alignment: Alignment.center,
                        child: Text(
                          'Kirim',
                          style: CustomText.Medium(
                              fontSize: 16.0,
                              colorText: CustomColor.whiteColor),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
