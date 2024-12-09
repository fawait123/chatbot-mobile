import 'dart:developer';

import 'package:apps_consultation_pregnant/app/core/styles/style_text.dart';
import 'package:apps_consultation_pregnant/app/modules/home/views/home_view.dart';
import 'package:apps_consultation_pregnant/app/modules/video/controllers/stream_video_controller.dart';
import 'package:apps_consultation_pregnant/app/modules/video/views/video_view.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../components/appbar/custom_default_appbar.dart';
import '../../../core/styles/style_color.dart';

class StreamVideoView extends GetView {
  const StreamVideoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StreamVideoController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomDefaultAppbar(
            backgroundColor: CustomColor.whiteColor,
            isHome: false,
            onTapBack: () {
              Get.back();
            },
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${controller.video.title?.toUpperCase()}',
                  style: CustomText.Bold(fontSize: 24.0),
                ),
                Gap(10),
                FutureBuilder<void>(
                  future: Get.find<StreamVideoController>().initializedVideo(),
                  // future: Get.put(StreamVideoController()).initializedVideo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        // Handle error
                        return Center(
                          child: Column(
                            children: [
                              Icon(Icons.error_outline, size: 40,),
                              Text('Video error to play', style: CustomText.Medium(fontSize: 16.0, colorText: CustomColor.blackColor),)
                            ],
                          ),
                        );
                      } else {
                        return AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Chewie(controller: Get.find<StreamVideoController>().chewieController),
                        );
                      }
                    } else {
                      return CircularProgressIndicator(); // Or any loading indicator
                    }
                  },
                ),
                Gap(15),
                Text(
                  '${controller.video.description}',
                  style: CustomText.Regular(fontSize: 14.0, colorText: CustomColor.blackColor),
                ),

                // AspectRatio(
                //   aspectRatio: 16 / 9,
                //   child: Chewie(controller: controller.chewieController),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
