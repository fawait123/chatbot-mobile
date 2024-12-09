import 'dart:developer';

import 'package:apps_consultation_pregnant/app/utils/service_preferences.dart';
import 'package:get/get.dart';

import '../../../utils/debouncer_utils.dart';
import '../../home/models/my_profile/user.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  // User? myProfile = ServicePreferences.getMyProfile();
  var name = ''.obs;
  RxBool isLoading = true.obs;

  final DebouncerUtils debouncerUtils =
      DebouncerUtils(duration: const Duration(milliseconds: 1000));

  void getProfile() async {
    isLoading.value = true;
    User? myProfile = ServicePreferences.getMyProfile();
    if (myProfile != null) {
      name.value = myProfile!.name.toString();
      isLoading.value = false;
      update();
    }
    update();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getProfile();
    // log("data profile: ${myProfile!.toJson()}");
    // name.value = myProfile!.name.toString();
    // isLoading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
    log("masuk ke onready");
  }

  @override
  void onClose() {
    super.onClose();
    log("masuk onclose");
  }

  void increment() => count.value++;
}
