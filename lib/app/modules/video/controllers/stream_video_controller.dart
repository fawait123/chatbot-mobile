import 'dart:developer';

import 'package:apps_consultation_pregnant/app/modules/video/models/video_model/video_model.dart';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/base_url_utils.dart';

class StreamVideoController extends GetxController {
  //TODO: Implement StreamVideoController
  VideoModel video = Get.arguments;
  RxString source = ''.obs;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  Future<void> initializedVideo() async {
    log("url video: ${BaseUrl().getUrlDevice()}${video.source?.substring(1)}");
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse('${BaseUrl().getUrlDevice()}${video.source?.substring(1)}'));

    await videoPlayerController.initialize();
    chewieController = await ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
    );
  }

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    source.value = '${BaseUrl().getUrlDevice()}${video.source?.substring(1)}';
    initializedVideo();
    videoPlayerController.initialize().then(
          (value) {
        return chewieController =
            ChewieController(videoPlayerController: videoPlayerController);
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
    video;
  }

  @override
  void onClose() {
    super.onClose();
    videoPlayerController.dispose();
    chewieController.dispose();
  }

  void increment() => count.value++;
}
