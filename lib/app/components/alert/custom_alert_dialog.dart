import 'package:apps_consultation_pregnant/app/components/indicator/indicator_data_progress.dart';
import 'package:apps_consultation_pregnant/app/modules/auth/views/auth_view.dart';
import 'package:apps_consultation_pregnant/app/utils/service_preferences.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../core/styles/style_color.dart';

class CustomAlertDialog {
  static customDialogLogout() async {
    if (Get.isDialogOpen!) Get.back();
    if (Get.isSnackbarOpen) Get.back();
    Get.dialog(
        useSafeArea: true,
        barrierDismissible: false,
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(40),
              Text(
                "Apakah Anda yakin ingin keluar?",
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)),
                          alignment: Alignment.center,
                          child: Text(
                            "Batal",
                          ),
                        ),
                      ),
                    ),
                    const Gap(15),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          IndicatorDataProgress.showLoading();
                          Future.delayed(Duration(seconds: 2), () {
                            ServicePreferences.clear();
                            return Get.offAll(AuthView());
                          });

                          // controller.logOut(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: CustomColor.primaryColor,
                              borderRadius: BorderRadius.circular(16)),
                          alignment: Alignment.center,
                          child: Text(
                            "Keluar",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
