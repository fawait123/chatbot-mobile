import 'dart:developer';

import 'package:apps_consultation_pregnant/app/modules/video/models/video_model/video_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../components/snackbar/custom_snackbar_helper.dart';
import '../../../utils/debouncer_utils.dart';
import '../../../utils/service_api_utils.dart';

class VideoController extends GetxController {
  //TODO: Implement VideoController
  int currentPage = 1;
  int currentLimit = 10;
  RxBool isLoading = true.obs;
  ScrollController scrollController = ScrollController();

  var hasMore = true.obs;
  var isReload = false.obs;
  var videoList = <VideoModel>[].obs;

  final DebouncerUtils debouncerUtils =
      DebouncerUtils(duration: const Duration(milliseconds: 1000));

  getVideo() async {
    await ApiServices.getData(
            'video?page=$currentPage&limit=$currentLimit&filter=[{"key": "is_public","value": "true"}]')
        .then((value) {
      try {
        isLoading.value = false;
        var data = value['data'] as List;
        List<VideoModel> response = data.map((e) {
          return VideoModel.fromMap(e);
        }).toList();

        if (response.length < currentLimit) {
          hasMore.value = false;
        }

        videoList.addAll(response);
        update();
        currentPage++;
        isLoading.value = false;
        update();
      } catch (e) {
        isLoading.value = false;
        update();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      CustomSnackbarHelper.showSnackbarDefault(
          title: 'Error', description: '$error');
      Get.back();
      update();
    });
  }

  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;

    if (maxScroll == currentScroll && hasMore.value) {
      getVideo();
    }
  }

  // List videoList = [
  //   {
  //     'title': 'Hello World',
  //     'description': 'Lorem ipsum dollar is money',
  //     'video_url':
  //         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  //   },
  //   {
  //     'title': 'Hello World',
  //     'description': 'Lorem ipsum dollar is money',
  //     'video_url':
  //         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  //   }
  // ];
  // RxBool isPlay = false.obs;
  //
  // final videoPlayers = <VideoPlayerController?>[];
  //
  // Future<void> playPauseVideo(int index) async {
  //   final player = await videoPlayers[index];
  //   log("data play: ${player?.value.isPlaying}");
  //   if (player?.value.isPlaying ?? false) {
  //     await player?.pause();
  //     isPlay = false.obs;
  //     update();
  //   } else {
  //     await player?.initialize().then((_) => player.play());
  //     isPlay = true.obs;
  //     update();
  //   }
  //   // update();
  // }
  //
  // Future<void> displayThumbnail() async {
  //   final videoUrl = "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
  //   final thumbnailData = await getVideoThumbnail(videoUrl);
  //   if (thumbnailData != null) {
  //     log("ada thumbnail: ${thumbnailData}");
  //     // Display the thumbnail using Image.memory(thumbnailData)
  //     // or any other suitable widget for displaying images.
  //   } else {
  //     log("tidak ada: ${thumbnailData}");
  //     // Handle error (e.g., show error message)
  //   }
  // }
  //
  // Future<Uint8List?> getVideoThumbnail(String videoUrl) async {
  //   log("aaa: ${videoUrl}");
  //   return await VideoThumbnail.thumbnailData(
  //     video: videoUrl,
  //     quality: 75,
  //   );
  // }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getVideo();
    scrollController.addListener(onScroll);
    // for (var item in videoList) {
    //   videoPlayers.add(VideoPlayerController.network(item['video_url']));
    // }
    // displayThumbnail();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    // videoPlayers.forEach((player) => player?.dispose());
  }

  void increment() => count.value++;
}
