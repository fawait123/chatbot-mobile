import 'package:apps_consultation_pregnant/app/modules/auth/views/auth_view.dart';
import 'package:apps_consultation_pregnant/app/utils/service_preferences.dart';
import 'package:get/get.dart';

import '../../home/views/home_view.dart';

class OnboardingController extends GetxController {
  //TODO: Implement OnboardingController
  void nextRoute() async {
    String? token = ServicePreferences.getToken();
    Future.delayed(Duration(seconds: 2), () async {
      token != null ? Get.offAll(HomeView()) : Get.offAll(AuthView());
      update();
    });
  }

  final count = 0.obs;
  @override
  void onInit() {
    nextRoute();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
