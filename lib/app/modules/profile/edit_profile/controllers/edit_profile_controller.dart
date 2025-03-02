import 'dart:developer';

import 'package:apps_consultation_pregnant/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/indicator/indicator_data_progress.dart';
import '../../../../components/snackbar/custom_snackbar_helper.dart';
import '../../../../utils/service_api_utils.dart';
import '../../../../utils/service_preferences.dart';
import '../../../home/models/my_profile/user.dart';

class EditProfileController extends GetxController {
  //TODO: Implement EditProfileController
  RxBool isLoading = true.obs;
  RxBool isObscure = true.obs;
  RxBool isObscureRepeat = true.obs;
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  User? myProfile = ServicePreferences.getMyProfile();
  var name = ''.obs;
  var username = ''.obs;
  var email = ''.obs;

  void showPassword() {
    isObscure.value = !isObscure.value;
    update();
  }

  void showRepeatPassword() {
    isObscureRepeat.value = !isObscureRepeat.value;
    update();
  }

  Future updateProfile() async {
    isLoading.value = true;
    IndicatorDataProgress.showLoading();
    await ApiServices.postData('profile', {
      "name": '${firstNameController.text} ${lastNameController.text}' ,
      "username": usernameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "role": "user"
    }).then((value) {
      log('data result: ${value}');
      isLoading.value = false;
      ServicePreferences.setMyProfile({
        'id': value['id'],
        'name': value['name'],
        'email': value['email'],
        'username': value['username'],
        'password': value['password'],
      });
      CustomSnackbarHelper.showSnackbarDefault(title: 'Update success', description: 'You account has been update!');
      Future.delayed(Duration(seconds: 1), () {
        Get.back();
      });
      update();
    }).onError((error, stackTrace) {
      isLoading.value = false;
      CustomSnackbarHelper.showSnackbarDefault(title: 'Update failed', description: '$error');
      Get.back();
      update();
    },);
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    name.value = myProfile!.name.toString();
    username.value = myProfile!.username.toString();
    email.value = myProfile!.email.toString();
    List<String> nameParts = name.value.split(' ');
    firstNameController.text = nameParts[0]; // John
    lastNameController.text = nameParts[1];
    usernameController.text = username.value;
    emailController.text = email.value;
    isLoading.value = false;
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
