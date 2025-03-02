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
    return GetBuilder<PhotoController>(
      init: PhotoController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomDefaultAppbar(
            backgroundColor: CustomColor.whiteColor,
          ),
          body: RefreshIndicator(
            backgroundColor: Colors.black12,
            notificationPredicate: (ScrollNotification notification) {
              return notification.depth == 0; // Hanya memantau notifikasi utama
            },
            onRefresh: () async {
              await controller.refreshData();
            },
            child: Obx(
              () => controller.isLoading.value
                  ? LinearProgressIndicator(
                      color: CustomColor.primaryColor,
                    )
                  : controller.photoList.isNotEmpty
                      ? ItemList(controller: controller)
                      : const CustomNotFound(),
            ),
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

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.controller,
  });

  final PhotoController controller;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller:
          controller.scrollController, // ScrollController untuk infinite scroll
      physics: const AlwaysScrollableScrollPhysics(), // Scroll selalu aktif
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Jumlah kolom grid
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: controller.hasMore.value
          ? controller.photoList.length + 1
          : controller.photoList.length,
      itemBuilder: (context, index) {
        if (index < controller.photoList.length) {
          return GestureDetector(
            onTap: () =>
                _showMyDialog(context, controller.photoList[index].note),
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CustomColor.greyColor.withOpacity(
                    controller.photoList[index].note == null ? 0.1 : 0.3),
              ),
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
            ),
          );
        } else {
          // Loader untuk infinite scroll
          return const Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

Future<void> _showMyDialog(BuildContext context, String? note) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // Pengguna harus menekan tombol
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Catatan'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(note == null ? "Belum ada catatan" : note),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Tutup'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
