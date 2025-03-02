import 'package:apps_consultation_pregnant/app/components/alert/custom_alert_dialog.dart';
import 'package:apps_consultation_pregnant/app/components/button/custom_button_submit.dart';
import 'package:apps_consultation_pregnant/app/modules/profile/edit_profile/views/edit_profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../core/constants/constant_asset.dart';
import '../../../core/styles/style_color.dart';
import '../../../core/styles/style_text.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: CustomColor.whiteColor,
          body: Obx(() => controller.isLoading == true ? LinearProgressIndicator() : SafeArea(
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  Gap(Get.height * 0.05),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(ConstantAsset.iconAppLogoPng),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(8),
                  Text(
                    '${controller.name.value ?? ''}',
                    textAlign: TextAlign.center,
                    style: CustomText.Medium(fontSize: 20.0, colorText: CustomColor.blackColor),
                  ),
                  const Gap(40),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                      onTap: () {
                        Get.offAll(EditProfileView());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: CustomColor.primaryColor.withOpacity(0.5)
                                ),
                                child: Icon(
                                  Icons.fingerprint,
                                  color: CustomColor.primaryColor,
                                  size: 30,
                                ),
                              ),
                              const Gap(15),
                              Text(
                                "Update profile",
                                style: CustomText.Regular(fontSize: 14.0, colorText: CustomColor.blackColor),
                              ),
                            ],
                          ),
                          Icon(
                            CupertinoIcons.chevron_right,
                            color: CustomColor.primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  // const Gap(8),
                  // const Gap(40),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomButtonSubmit(
                      title: "Log Out",
                      onPressed: () {
                        CustomAlertDialog.customDialogLogout();
                      },
                      isDisabled: false,
                      height: 15,
                    ),
                  )
                ],
              ),
            ),
          ),),
        );
      },
    );
  }
}
