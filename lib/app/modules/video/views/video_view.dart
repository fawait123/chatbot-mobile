import 'dart:developer';

import 'package:apps_consultation_pregnant/app/components/notfound/custom_notfound.dart';
import 'package:apps_consultation_pregnant/app/core/styles/style_text.dart';
import 'package:apps_consultation_pregnant/app/modules/video/views/stream_video_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../components/appbar/custom_default_appbar.dart';
import '../../../core/styles/style_color.dart';
import '../../../utils/base_url_utils.dart';
import '../controllers/video_controller.dart';

class VideoView extends GetView<VideoController> {
  const VideoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: VideoController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomDefaultAppbar(
            backgroundColor: CustomColor.whiteColor,
          ),
          body: Obx(
            () => controller.isLoading.value == true
                ? LinearProgressIndicator(
                    color: CustomColor.primaryColor,
                  )
                : controller.videoList.length > 0
                    ? VideoItem(
                        controller: controller,
                      )
                    : CustomNotFound(),
          ),
        );
      },
    );
  }
}

class VideoItem extends StatelessWidget {
  final VideoController controller;
  const VideoItem({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: PageScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(StreamVideoView(),
                      arguments: controller.videoList[index]);
                },
                child: ListTile(
                  leading: Image.network(
                    '${BaseUrl().getUrlDevice()}/${controller.videoList[index].thumbnail}',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.error_rounded,
                        color: CustomColor.primaryColor,
                      );
                    },
                  ),
                  title: Text(
                    '${controller.videoList[index].title}',
                    style: CustomText.Medium(
                        fontSize: 16.0, colorText: CustomColor.blackColor),
                  ),
                  subtitle: Text('${controller.videoList[index].description}'),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Gap(10);
            },
            itemCount: controller.videoList.length),
      ),
    );
  }
}
