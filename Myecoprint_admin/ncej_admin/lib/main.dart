// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ncej_admin/core/constants/theme/theme_helper.dart';
import 'package:ncej_admin/core/localization/app_localization.dart';
import 'package:ncej_admin/core/routes/app_routes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localizationController = Get.put(AppLocalizationController());
  localizationController.changeLocale(const Locale('ar'));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppLocalization(),
       theme: theme,
      builder: EasyLoading.init(),
      locale: Get.locale,
      fallbackLocale: const Locale('en', ''),
      title: 'NCEJ',
      debugShowCheckedModeBanner: false,
     initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.routes,
  
    );
  }
}