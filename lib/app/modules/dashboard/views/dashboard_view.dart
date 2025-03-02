import 'package:apps_consultation_pregnant/app/components/appbar/custom_default_appbar.dart';
import 'package:apps_consultation_pregnant/app/core/styles/style_color.dart';
import 'package:apps_consultation_pregnant/app/core/styles/style_text.dart';
import 'package:apps_consultation_pregnant/app/modules/dashboard/widgets/custom_carousel_list.dart';
import 'package:apps_consultation_pregnant/app/modules/home/controllers/home_controller.dart';
import 'package:apps_consultation_pregnant/app/modules/photo/views/photo_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashboardController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomDefaultAppbar(
            backgroundColor: CustomColor.whiteColor,
          ),
          body: SingleChildScrollView(
            physics: PageScrollPhysics(),
            child: Column(
              children: [
                CustomCarouselList(),
                controller.gridMenuList.length == 0
                    ? Container()
                    : GetBuilder<HomeController>(
                        init: HomeController(),
                        builder: (homeController) => GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 6 / 2),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              itemCount: controller.gridMenuList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      homeController.changeMenu(index + 1);
                                    },
                                    child: ItemCard(
                                        controller: controller, index: index));
                              },
                            ))
              ],
            ),
          ),
        );
      },
    );
  }
}

class ItemCard extends StatelessWidget {
  final DashboardController controller;
  final int index;
  ItemCard({required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${this.controller.gridMenuList[index]['name']}",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.whiteColor),
            ),
            SizedBox(
              height: 15,
            ),
            Icon(
              this.controller.gridMenuList[index]['icon'],
              color: CustomColor.netral200,
              size: 35,
            )
          ],
        ),
      ),
    );
  }
}
