import 'package:apps_consultation_pregnant/app/core/constants/constant_asset.dart';
import 'package:apps_consultation_pregnant/app/modules/dashboard/models/dashboard_model.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/snackbar/custom_snackbar_helper.dart';
import '../../../utils/service_api_utils.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController
  int currentBanner = 0;
  CarouselControllerPlus controllerBanner = CarouselControllerPlus();
  DashboardModel? dashboardList;

  final List<String> bannerList = [
    ConstantAsset.iconBanner1,
    ConstantAsset.iconBanner2,
  ];

  List gridMenuList = [];

  void assignDataMenuList() {
    gridMenuList = [
      {'name': 'CHATTBOT', 'route': '/chat', 'icon': Icons.chat},
      {'name': 'VIDEO', 'route': '/video', 'icon': Icons.video_call},
      {'name': 'FOTO', 'route': '/photo', 'icon': Icons.image},
      {'name': 'PROFIL', 'route': '/profile', 'icon': Icons.person},
    ];
    update();
  }

  void getHome() async {
    await ApiServices.getData('dashboard').then(
      (value) {
        dashboardList = DashboardModel.fromMap(value);
        gridMenuList = [
          {'name': 'CHATTBOT', 'amount': dashboardList?.user},
          {'name': 'VIDEO', 'amount': dashboardList?.video},
          {'name': 'FOTO', 'amount': dashboardList?.capture},
          {'name': 'PROFIL', 'amount': dashboardList?.question},
        ];
        update();
      },
    ).onError(
      (error, stackTrace) {
        CustomSnackbarHelper.showSnackbarDefault(
            title: 'Dashboard', description: '$error');
        Get.back();
        update();
      },
    );
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    assignDataMenuList();
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
