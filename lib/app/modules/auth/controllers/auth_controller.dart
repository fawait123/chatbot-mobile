import 'dart:developer';

import 'package:apps_consultation_pregnant/app/components/indicator/indicator_data_progress.dart';
import 'package:apps_consultation_pregnant/app/modules/home/views/home_view.dart';
import 'package:apps_consultation_pregnant/app/utils/service_api_utils.dart';
import 'package:apps_consultation_pregnant/app/utils/service_preferences.dart';
import 'package:apps_consultation_pregnant/app/utils/service_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../components/snackbar/custom_snackbar_helper.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController
  bool isObscure = true;
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void showPassword() {
    isObscure = !isObscure;
    update();
  }

  Future postLogin() async {
    print("username: ${usernameController.text}");
    print("password: ${passwordController.text}");
    IndicatorDataProgress.showLoading();
    await ApiServices.postDataWithoutToken('login/mobile', {
      'username': usernameController.text,
      'password': passwordController.text,
    }).then((value) {
      log("data login: value");
      ServicePreferences.setToken(value['token']);
      ServicePreferences.setMyProfile(value['user']);
      CustomSnackbarHelper.showSnackbarDefault(
          title: 'Login success', description: 'Welcome to dashboard!');
      Future.delayed(Duration(seconds: 1), () {
        Get.offAll(const HomeView());
      });
      update();
    }).onError(
      (error, stackTrace) {
        log("error ${error.toString()}");
        CustomSnackbarHelper.showSnackbarDefault(
            title: 'Login failed', description: '${error.toString()}');
        // Get.back();
        update();
      },
    );
  }

  final count = 0.obs;
  @override
  void onInit() {
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
