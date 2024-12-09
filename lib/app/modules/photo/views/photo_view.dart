import 'package:apps_consultation_pregnant/app/components/indicator/indicator_data_progress.dart';
import 'package:apps_consultation_pregnant/app/components/notfound/custom_notfound.dart';
import 'package:apps_consultation_pregnant/app/modules/photo/widgets/custom_dialog_upload.dart';
import 'package:apps_consultation_pregnant/app/utils/base_url_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/appbar/custom_default_appbar.dart';
import '../../../core/styles/style_color.dart';
import '../../../core/styles/style_text.dart';
import '../controllers/photo_controller.dart';

class PhotoView extends GetView<PhotoController> {
  const PhotoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PhotoController(),
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
                : controller.photoList.length > 0
                    ? PictureItem(
                        controller: controller,
                      )
                    : CustomNotFound(),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: CustomColor.primaryColor.withOpacity(0.7),
            splashColor: CustomColor.primaryColor.withOpacity(0.7),
            onPressed: () {
              CustomDialogUpload.showDialogUpload();
            },
            child: Icon(
              Icons.add_a_photo_rounded,
              color: CustomColor.whiteColor,
            ),
          ),
        );
      },
    );
  }
}

class PictureItem extends StatelessWidget {
  final PhotoController controller;
  const PictureItem({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller.scrollController,
      physics: PageScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 0.8,
            crossAxisSpacing: 0.8,
          ),
          itemCount: controller.hasMore.value
              ? controller.photoList.length + 1
              : controller.photoList.length,
          itemBuilder: (context, index) {
            if (index < controller.photoList.length) {
              return Container(
                margin: EdgeInsets.all(10),
                // color: Colors.transparent,
                decoration: BoxDecoration(
                    color: CustomColor.greyColor.withOpacity(0.1)),
                child: Image.network(
                  '${BaseUrl().getUrlDevice()}/${controller.photoList[index].source}',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.error_rounded,
                      color: CustomColor.primaryColor,
                    );
                  },
                ),
              );
            } else {
              return Center(
                  child: Container(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: CustomColor.primaryColor,
                ),
              ));
            }
          },
        ),
      ),
    );
  }
}
