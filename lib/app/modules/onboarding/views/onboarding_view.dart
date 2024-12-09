import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/constants/constant_asset.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OnboardingController(),
      builder: (controller) {
        return Scaffold(
          body: Center(
              child: Image.asset(
                ConstantAsset.iconApp,
                width: Get.width * 0.5,
              ),
          ),
        );
      },
    );
  }
}
