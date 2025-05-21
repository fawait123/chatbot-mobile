import 'package:apps_consultation_pregnant/app/core/constants/constant_asset.dart';
import 'package:apps_consultation_pregnant/app/core/styles/style_color.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Slider {
  final String icon;
  final String title;
  final String description;

  Slider({required this.icon, required this.title, required this.description});
}

Future<void> sliderDialog(BuildContext context) async {
  final List<Slider> sliderList = [
    Slider(
      icon: ConstantAsset.botBanner,
      title: 'Menu Chatbot Konsultasi',
      description:
          'Ingin bertanya tentang kesehatan gigi dan mulut selama kehamilan?\nKlik ikon chatt di pojok kanan bawah.\nPilih pertanyaan, dan sistem akan memberikan jawaban.',
    ),
    Slider(
      icon: ConstantAsset.photoBanner,
      title: 'Menu Foto',
      description:
          'Ingin berkonsultasi lewat foto?\nKlik ikon kamera di pojok kanan bawah, pilih foto dari galeri atau ambil langsung, lalu klik\nKirim',
    ),
    Slider(
      icon: ConstantAsset.videoBanner,
      title: 'Menu Video Edukasi',
      description:
          'Tonton video singkat tentang kesehatan gigi dan mulut selama masa kehamilan.',
    ),
    Slider(
      icon: ConstantAsset.userBanner,
      title: 'Menu Profile',
      description: 'Lihat dan ubah data diri anda di menu ini.',
    ),
    // Kamu bisa tambahkan item slider lain di sini
  ];
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 300, // Lebar tetap, sesuai ukuran dialog
              height: 300, // Tinggi tetap agar CarouselSlider bisa layout
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                ),
                items: sliderList.map((slide) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            slide.icon,
                          ),
                          Gap(20),
                          Text(
                            slide.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: CustomColor.primaryColor,
                            ),
                          ),
                          Gap(20),
                          Text(
                            slide.description,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Text(
              '*Aplikasi ini terhubung dengan Puskesmas setempat. Pastikan Hp anda terhubung ke internet untuk hasil terbaik.',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
            Gap(20),
            TextButton(
              child: const Text('Mengerti'),
              style: TextButton.styleFrom(
                backgroundColor: CustomColor.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(5)), // ⬅️ Sudut tidak tumpul
                ), // warna teks
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
