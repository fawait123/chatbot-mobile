import 'package:apps_consultation_pregnant/app/components/navbar/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () {
            return controller.doubleTapToBack();
          },
          child: Scaffold(
            body: LazyLoadIndexedStack(
              index: controller.selectedIndex,
              preloadIndexes: const [5],
              children: controller.screens,
            ),
            bottomNavigationBar: CustomBottomNavbar(
              navigationItems: controller.navigationItems,
              selectedIndex: controller.selectedIndex,
              onIndexChanged: (index) {
                controller.changeMenu(index);
                controller.update();
              }
            ),
          ),
        );
      },
    );
  }
}
