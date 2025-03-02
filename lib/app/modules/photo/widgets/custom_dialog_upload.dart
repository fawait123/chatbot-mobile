import 'dart:io';
import 'dart:ui';

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
                    ? Image.file(
                        photoController.imageUpload.value!,
                        height: Get.height * 0.3,
                        width: Get.width * 0.5,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () async {
                              await photoController.useImageGallery();
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.image_rounded,
                                size: 50,
                                color:
                                    CustomColor.primaryColor.withOpacity(0.7),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await photoController.useImageCamera();
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.photo_camera_rounded,
                                size: 50,
                                color:
                                    CustomColor.primaryColor.withOpacity(0.7),
                              ),
                            ),
                          )
                        ],
                      ),
              ),
              Gap(15),
              photoController.fileNameController.value.text != null ?
              Row(
                children: [
                  Expanded(child: InkWell(
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
                            fontSize: 16.0, colorText: CustomColor.blackColor),
                      ),
                    ),
                  ),),
                  Gap(10),
                  Expanded(child: InkWell(
                    onTap: () {
                      if(photoController.fileNameController.value.text.isNotEmpty) {
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
                            fontSize: 16.0, colorText: CustomColor.whiteColor),
                      ),
                    ),
                  ))
                ],
              ) : InkWell(
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
                        fontSize: 16.0, colorText: CustomColor.whiteColor),
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
