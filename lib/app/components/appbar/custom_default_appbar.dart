import 'package:apps_consultation_pregnant/app/components/alert/slider_alert_dialog.dart';
import 'package:apps_consultation_pregnant/app/core/constants/constant_asset.dart';
import 'package:apps_consultation_pregnant/app/core/styles/style_color.dart';
import 'package:apps_consultation_pregnant/app/core/styles/style_text.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomDefaultAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final Color? backgroundColor;
  final bool? isHome;
  final void Function()? onTapBack;
  const CustomDefaultAppbar(
      {super.key, this.backgroundColor, this.isHome, this.onTapBack});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      title: Row(
        children: [
          isHome == false
              ? InkWell(
                  onTap: onTapBack,
                  child: Icon(Icons.arrow_back_ios_new_outlined),
                )
              : Container(),
          Gap(isHome == false ? 20 : 0),
          Padding(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: Row(
              children: [
                Image.asset(
                  ConstantAsset.iconAppLogoPng,
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                ),
                Gap(10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'PREGNANCY',
                      style: CustomText.Bold(
                          fontSize: 20.0, colorText: CustomColor.blackColor),
                    ),
                    Text(
                      'WOMAN HEALTY',
                      style: CustomText.Bold(
                          fontSize: 10.0, colorText: CustomColor.greyColor),
                    )
                  ],
                )
              ],
            ),
          ),
          Gap(10),
          Container()
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: () {
              sliderDialog(context);
            },
            child: Icon(Icons.question_mark, color: CustomColor.primaryColor),
          ),
        )
      ],
    );
  }
}
