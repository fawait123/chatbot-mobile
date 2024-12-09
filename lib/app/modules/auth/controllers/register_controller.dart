import 'dart:developer';

import 'package:apps_consultation_pregnant/app/components/indicator/indicator_data_progress.dart';
import 'package:apps_consultation_pregnant/app/components/snackbar/custom_snackbar_helper.dart';
import 'package:apps_consultation_pregnant/app/modules/auth/views/auth_view.dart';
import 'package:apps_consultation_pregnant/app/utils/service_api_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController
  bool isLoading = true;
  RxBool isObscure = true.obs;
  RxBool isObscureRepeat = true.obs;
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  void showPassword() {
    isObscure.value = !isObscure.value;
    update();
  }

  void showRepeatPassword() {
    isObscureRepeat.value = !isObscureRepeat.value;
    update();
  }

  Future postRegister() async {
    isLoading = true;
    IndicatorDataProgress.showLoading();
    await ApiServices.postDataWithoutToken('register', {
      "name": '${firstNameController.text} ${lastNameController.text}' ,
      "username": usernameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "role": "user"
    }).then((value) {
      isLoading = false;
      CustomSnackbarHelper.showSnackbarDefault(title: 'Register success', description: 'You can login!');
      Future.delayed(Duration(seconds: 1), () {
        Get.offAll(const AuthView());
      });
      update();
    }).onError((error, stackTrace) {
      isLoading = false;
      CustomSnackbarHelper.showSnackbarDefault(title: 'Register failed', description: '$error');
      Get.back();
      update();
    },);
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
