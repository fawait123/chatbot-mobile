import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:apps_consultation_pregnant/app/components/indicator/indicator_data_progress.dart';
import 'package:apps_consultation_pregnant/app/core/styles/style_color.dart';
import 'package:apps_consultation_pregnant/app/modules/home/models/my_profile/user.dart';
import 'package:apps_consultation_pregnant/app/modules/home/views/home_view.dart';
import 'package:apps_consultation_pregnant/app/modules/photo/models/photo_model/photo_model.dart';
import 'package:apps_consultation_pregnant/app/modules/photo/models/photo_model/photo_model.dart';
import 'package:apps_consultation_pregnant/app/modules/photo/models/photo_model/photo_model.dart';
import 'package:apps_consultation_pregnant/app/modules/photo/views/photo_view.dart';
import 'package:apps_consultation_pregnant/app/modules/photo/widgets/custom_dialog_upload.dart';
import 'package:apps_consultation_pregnant/app/utils/service_api_utils.dart';
import 'package:apps_consultation_pregnant/app/utils/service_preferences.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../components/snackbar/custom_snackbar_helper.dart';
import '../../../core/styles/style_text.dart';
import '../../../utils/debouncer_utils.dart';

class PhotoController extends GetxController {
  //TODO: Implement PhotoController
  int currentPage = 1;
  int currentLimit = 10;
  RxBool isLoading = true.obs;
  ScrollController scrollController = ScrollController();
  final fileNameController = TextEditingController().obs;
  Rx<File?> imageUpload = Rx<File?>(null);
  TextEditingController description = TextEditingController();

  var hasMore = true.obs;
  var isReload = false.obs;
  var photoList = <PhotoModel>[].obs;

  final DebouncerUtils debouncerUtils =
      DebouncerUtils(duration: const Duration(milliseconds: 1000));

  getCapture() async {
    User? myProfile = ServicePreferences.getMyProfile();
    String? ids = myProfile?.sub;
    await ApiServices.getData(
            'capture?page=$currentPage&limit=$currentLimit&filter=[{"key":"userID","value":"$ids"}]')
        .then((value) {
      try {
        isLoading.value = false;
        var data = value['data'] as List;
        List<PhotoModel> response = data.map((e) {
          return PhotoModel.fromMap(e);
        }).toList();

        if (response.length < currentLimit) {
          hasMore.value = false;
        }

        photoList.addAll(response);
        update();
        currentPage++;
        isLoading.value = false;
        update();
      } catch (e) {
        isLoading.value = false;
        update();
      }
    }).onError((error, stackTrace) {
      print("Error ${error}");
      isLoading.value = false;
      CustomSnackbarHelper.showSnackbarDefault(
          title: 'Error', description: '$error');
      Get.back();
      update();
    });
  }

  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;

    if (maxScroll == currentScroll && hasMore.value) {
      getCapture();
    }
  }

  Future<void> refreshData() async {
    print('refresh data');
    currentPage = 1;
    isLoading.value = true;
    hasMore.value = true;
    photoList.value = [];
    print("current ${currentPage} limit");
    await Future.delayed(const Duration(seconds: 3));
    getCapture();
    update();
  }

  Future useImageCamera() async {
    var takeImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 90,
      maxWidth: 1920,
      maxHeight: 1080,
    );
    if (takeImage != null) {
      imageUpload.value = File(takeImage.path);
      fileNameController.value.text = takeImage.name;
      update();
    }
  }

  Future useImageGallery() async {
    var takeImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
      maxWidth: 1920,
      maxHeight: 1080,
    );
    if (takeImage != null) {
      imageUpload.value = File(takeImage.path);
      log("image upload: ${imageUpload}");
      fileNameController.value.text = takeImage.name;
      // Get.back();
      update();
    }
  }

  Future cancelUpload() async {
    imageUpload.value = null;
    fileNameController.value.text = '';
    update();
  }

  Future postPhoto() async {
    IndicatorDataProgress.showLoading();
    isLoading.value = true;
    await ApiServices.postFile(
            'capture',
            imageUpload.value!.path,
            {
              'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
              'description': description.text
            },
            keyPhoto: 'source')
        .then((value) {
      if (value['status'] == 'access forbidden') {
        CustomSnackbarHelper.showSnackbarDefault(
            title: '${value['status']}', description: '${value['message']}');
        refreshData();
      } else {
        cancelUpload();
        CustomSnackbarHelper.showSnackbarDefault(
            title: 'Yeay', description: 'Upload is success!');
        refreshData();
      }
    }).onError((error, stackTrace) {
      CustomSnackbarHelper.showSnackbarDefault(
          title: 'Error',
          description: 'Error occured, please try again later!');
      refreshData();
      log('error upload: ${error}');
    });
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // getCapture();
    scrollController.addListener(onScroll);
  }

  @override
  void onReady() {
    super.onReady();
    print('ready');
  }

  @override
  void onClose() {
    super.onClose();
    print('close');
  }

  void increment() => count.value++;
}
