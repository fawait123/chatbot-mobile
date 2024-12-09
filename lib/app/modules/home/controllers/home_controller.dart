import 'dart:developer';

import 'package:apps_consultation_pregnant/app/modules/chat/views/chat_view.dart';
import 'package:apps_consultation_pregnant/app/modules/dashboard/views/dashboard_view.dart';
import 'package:apps_consultation_pregnant/app/modules/photo/views/photo_view.dart';
import 'package:apps_consultation_pregnant/app/modules/profile/views/profile_view.dart';
import 'package:apps_consultation_pregnant/app/modules/video/views/video_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../utils/toast_utils.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  DateTime timebackPressed = DateTime.now();
  int selectedIndex = 0;
  Widget currentScreen = const DashboardView();
  List navigationItems = [
    {'label': 'Home', 'icon': Icons.home_rounded},
    {'label': 'Chat', 'icon': Icons.chat_bubble_rounded},
    {'label': 'Video', 'icon': Icons.video_collection_rounded},
    {'label': 'Photo', 'icon': Icons.photo_camera_rounded},
    {'label': 'Profile', 'icon': Icons.account_circle_rounded},
  ];

  List<Widget> screens = [
    DashboardView(),
    ChatView(),
    VideoView(),
    PhotoView(),
    ProfileView(),
  ];

  changeMenu(index) {
    switch (index) {
      case 0:
        currentScreen = screens[0];
        selectedIndex = 0;
        update();
        break;
      case 1:
        currentScreen = screens[1];
        selectedIndex = 1;
        update();
        break;
      case 2:
        currentScreen = screens[2];
        selectedIndex = 2;
        update();
        break;
      case 3:
        currentScreen = screens[3];
        selectedIndex = 3;
        update();
        break;
      case 4:
        currentScreen = screens[4];
        selectedIndex = 4;
        update();
        break;
    }
    update();
  }

  Future<bool> doubleTapToBack() async {
    final difference = DateTime.now().difference(timebackPressed);
    final isExitWarning = difference >= const Duration(seconds: 2);

    timebackPressed = DateTime.now();

    if (isExitWarning) {
      ToastUtil.showNeutralMessage("Press back again to exit");
      return false;
    } else {
      Fluttertoast.cancel();
      return true;
    }
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
