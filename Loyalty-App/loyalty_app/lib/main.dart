// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 HttpOverrides.global = MyHttpOverrides();
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = appTheme.blueGray900
    ..indicatorColor = appTheme.deepOrange800
    ..textColor = appTheme.deepOrange800
    ..textStyle = const TextStyle(fontSize: 16.0, color: Colors.white)
    ..contentPadding = const EdgeInsets.all(10.0)
    ..maskColor = Colors.transparent;

  final localizationController = Get.put(AppLocalizationController());
  localizationController.changeLocale(const Locale('ar'));
  initializeDateFormatting();

  runApp(MyApp());
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: GetMaterialApp(
        translations: AppLocalization(),
        theme: theme,
        builder: EasyLoading.init(),
        locale: Get.locale,
        fallbackLocale: const Locale('en', ''),
        title: 'Loyalty_app',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.loginScreen,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
