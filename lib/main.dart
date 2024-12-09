import 'package:apps_consultation_pregnant/app/utils/service_preferences.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/core/styles/style_color.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await ServicePreferences.init();
  runApp(
    LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        return GetMaterialApp(
          title: 'Consultation Pregnant',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: CustomColor.whiteColor),
            useMaterial3: true,
            primaryColor: CustomColor.whiteColor,
            scaffoldBackgroundColor: CustomColor.whiteColor,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          defaultTransition: Transition.cupertino,
          getPages: AppPages.routes,
        );
      });
    }),
  );
}
