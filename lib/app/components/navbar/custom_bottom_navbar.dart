import 'package:apps_consultation_pregnant/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/styles/style_color.dart';
import '../../core/styles/style_text.dart';

class CustomBottomNavbar extends StatelessWidget {
  final List? navigationItems;
  final int? selectedIndex;
  final Function(int)? onIndexChanged;
  CustomBottomNavbar({
    super.key,
    this.navigationItems,
    this.selectedIndex,
    this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.find<DashboardController>();
    return SizedBox(
      width: Get.width,
      height: Get.height / 10,
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.primaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            navigationItems!.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  onIndexChanged!(index);
                  controller.onItemTapped(index);
                },
                child: index == selectedIndex
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            navigationItems![index]['icon'],
                            size: 30,
                            color: CustomColor.primaryColor,
                          ),
                          Text(
                            '${navigationItems![index]['label']}',
                            style: CustomText.Medium(
                                colorText: CustomColor.whiteColor,
                                fontSize: 16.0),
                          ),
                        ],
                      )
                    : Icon(
                        navigationItems![index]['icon'],
                        size: 30,
                        color: CustomColor.whiteColor,
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
