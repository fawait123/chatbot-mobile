import 'package:get/get.dart';

import 'package:apps_consultation_pregnant/app/modules/video/controllers/stream_video_controller.dart';

import '../controllers/video_controller.dart';

class VideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StreamVideoController>(
      () => StreamVideoController(),
    );
    Get.lazyPut<VideoController>(
      () => VideoController(),
    );
  }
}
