import 'package:apps_consultation_pregnant/app/core/styles/style_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class CustomNotFound extends StatelessWidget {
  const CustomNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/404.svg',
            width: 240,
            height: 240,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Oops! Tidak ada data',
            style: TextStyle(
                color: CustomColor.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          )
        ],
      ),
    );
  }
}
