import 'package:apps_consultation_pregnant/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/styles/style_color.dart';

class CustomCarouselList extends StatelessWidget {
  const CustomCarouselList({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController dashboardController =
        Get.find<DashboardController>();
    return Column(
      children: [
        CarouselSlider(
          items: dashboardController.bannerList
              .map(
                (item) => Container(
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: [
                          Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          controller: dashboardController.controllerBanner,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 3.0,
              onPageChanged: (index, reason) {
                dashboardController.currentBanner = index;
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dashboardController.bannerList.asMap().entries.map(
            (entry) {
              return GestureDetector(
                onTap: () => dashboardController.controllerBanner
                    .animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? CustomColor.whiteColor
                              : CustomColor.blackColor)
                          .withOpacity(
                              dashboardController.currentBanner == entry.key
                                  ? 0.9
                                  : 0.4)),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
