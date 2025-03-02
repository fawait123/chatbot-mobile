import 'dart:developer';

import 'package:apps_consultation_pregnant/app/components/indicator/indicator_data_progress.dart';
import 'package:apps_consultation_pregnant/app/components/snackbar/custom_snackbar_helper.dart';
import 'package:apps_consultation_pregnant/app/modules/chat/models/chat_model/chat_model.dart';
import 'package:apps_consultation_pregnant/app/modules/chat/models/question_model/question_model.dart';
import 'package:apps_consultation_pregnant/app/modules/chat/models/question_model/question_model.dart';
import 'package:apps_consultation_pregnant/app/modules/chat/models/question_model/question_model.dart';
import 'package:apps_consultation_pregnant/app/modules/chat/views/chat_view.dart';
import 'package:apps_consultation_pregnant/app/modules/chat/widgets/custom_dialog_question.dart';
import 'package:apps_consultation_pregnant/app/modules/home/models/my_profile/user.dart';
import 'package:apps_consultation_pregnant/app/modules/home/views/home_view.dart';
import 'package:apps_consultation_pregnant/app/utils/service_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../utils/debouncer_utils.dart';
import '../../../utils/service_api_utils.dart';

class ChatController extends GetxController {
  //TODO: Implement ChatController
  TextEditingController messageController = TextEditingController();
  final channelWS = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );
  List messagesList = [
    {'isSender': false, 'message': 'Hello world!'},
    {'isSender': true, 'message': 'Hello world too!'}
  ];

  int currentPage = 1;
  int currentLimit = 100000;
  RxBool isLoading = true.obs;
  ScrollController scrollController = ScrollController();

  var hasMore = true.obs;
  var isReload = false.obs;
  var questionList = <QuestionModel>[].obs;
  var historyChat = <ChatModel>[].obs;

  final DebouncerUtils debouncerUtils =
      DebouncerUtils(duration: const Duration(milliseconds: 1000));
  final typeQuestionController = TextEditingController();

  Future<void> getQuestion() async {
    isLoading.value = true;
    await ApiServices.getData(
            'question?page=$currentPage&limit=$currentLimit&filter=[{"key": "isPublic","value": "true"}]')
        .then((value) {
      try {
        var data = value['data'] as List;
        List<QuestionModel> response = data.map((e) {
          return QuestionModel.fromMap(e);
        }).toList();
        // if (response.length < currentLimit) {
        //   hasMore.value = false;
        // }

        questionList.addAll(response);
        // Future.delayed(Duration.zero, () {
        //   CustomDialogQuestion().showDialog();
        // });
        // currentPage++;
        isLoading.value = false;
        update();
      } catch (e) {
        isLoading.value = false;
        update();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      // CustomSnackbarHelper.showSnackbarDefault(
      //     title: 'Error', description: '$error');
      Get.back();
      update();
    });
  }

  Future<void> postQuestion() async {
    IndicatorDataProgress.showLoading();
    isLoading.value = true;
    await ApiServices.postData(
            'chatt/message', {'message': typeQuestionController.text})
        .then((value) {
      isLoading.value = false;
      // Get.offAll(HomeView());
      Get.back();
      getMessage();

      update();
    }).onError((error, stackTrace) {
      isLoading.value = false;
      CustomSnackbarHelper.showSnackbarDefault(
          title: 'Error', description: '$error');
      Get.back();
      update();
    });
  }

  Future getMessage() async {
    isLoading.value = true;
    User? myProfile = ServicePreferences.getMyProfile();
    String? ids = myProfile?.sub;
    await ApiServices.getData(
            'chatt?page=${currentPage}&limit${currentLimit}&filter=[{"key": "userID","value": "$ids"}]')
        .then((value) {
      log('value: ${value}');
      var data = value['data'] as List;
      List<ChatModel> rspChat = data.map((e) => ChatModel.fromMap(e)).toList();
      if (rspChat.length < currentLimit) {
        hasMore.value = false;
      }
      historyChat.addAll(rspChat);
      currentPage++;
      if (historyChat.length > 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.jumpTo(
            scrollController.position.maxScrollExtent,
          );
        });
      }
      isLoading.value = false;
      update();
    }).onError((error, stackTrace) {
      isLoading.value = false;
      CustomSnackbarHelper.showSnackbarDefault(
          title: 'Chat', description: '${error}');
      update();
    });
  }

  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    if (maxScroll == currentScroll && hasMore.value) {
      getMessage();
    }
  }

  getTypeQuestion({required String type}) async {
    typeQuestionController.text = type;
    update();
  }

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    await getQuestion();
    await getMessage();
    if (scrollController.hasClients) {
      scrollController.addListener(onScroll);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
