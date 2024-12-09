import 'dart:developer';

import 'package:apps_consultation_pregnant/app/components/notfound/custom_notfound.dart';
import 'package:apps_consultation_pregnant/app/components/snackbar/custom_snackbar_helper.dart';
import 'package:apps_consultation_pregnant/app/modules/chat/models/chat_model/chat_model.dart';
import 'package:apps_consultation_pregnant/app/modules/chat/widgets/custom_dialog_question.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../components/appbar/custom_default_appbar.dart';
import '../../../core/styles/style_color.dart';
import '../controllers/chat_controller.dart';
import '../widgets/custom_bubble_message.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ChatController(),
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
                : controller.historyChat.length > 0
                    ? SingleChildScrollView(
                        physics: PageScrollPhysics(),
                        controller: controller.scrollController,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            children: [
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.historyChat.length,
                                itemBuilder: (context, index) {
                                  final message = controller.historyChat[index];
                                  return MessageItem(
                                    message: message,
                                    controller: controller,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : CustomNotFound(),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endContained,
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: CustomColor.primaryColor.withOpacity(0.7),
            splashColor: CustomColor.primaryColor.withOpacity(0.7),
            onPressed: () {
              CustomDialogQuestion().showDialog();
            },
            child: Icon(
              Icons.question_mark_outlined,
              color: CustomColor.whiteColor,
            ),
          ),
        );
      },
    );
  }
}

class MessageItem extends StatelessWidget {
  final ChatController controller;
  final ChatModel message;
  MessageItem({
    required this.message,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBubbleMessage(
          message: message.message,
          isSender: true,
          backgroundColor: true
              ? CustomColor.primaryColor
              : CustomColor.primaryColor.withOpacity(0.5),
          textColor: true ? CustomColor.whiteColor : CustomColor.blackColor,
        ),
        CustomBubbleMessage(
          message: message.response,
          isSender: message.response ==
                  controller.questionList
                      .map(
                        (element) => element.description,
                      )
                      .toList()
              ? true
              : false,
          backgroundColor: message.response ==
                  controller.questionList
                      .map(
                        (element) => element.description,
                      )
                      .toList()
              ? CustomColor.primaryColor
              : CustomColor.primaryColor.withOpacity(0.5),
          textColor: message.response ==
                  controller.questionList
                      .map(
                        (element) => element.description,
                      )
                      .toList()
              ? CustomColor.whiteColor
              : CustomColor.blackColor,
        )
      ],
    );
  }
}
