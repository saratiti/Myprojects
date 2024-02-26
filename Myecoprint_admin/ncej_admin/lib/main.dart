// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ncej_admin/controller/provider/company_provider.dart';
import 'package:ncej_admin/controller/provider/user_profile_provider.dart';
import 'package:ncej_admin/core/constants/theme/theme_helper.dart';
import 'package:ncej_admin/core/localization/app_localization.dart';
import 'package:ncej_admin/core/routes/app_routes.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor =  appTheme.blueGray400
    ..indicatorColor = Colors.white 
    ..textColor = Colors.white 
    ..textStyle = TextStyle(fontSize: 16.0, color: Colors.white)
    ..contentPadding = EdgeInsets.all(10.0)
    ..maskColor = Colors.transparent;
  final localizationController = Get.put(AppLocalizationController());
  localizationController.changeLocale(const Locale('ar'));
  initializeDateFormatting();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProfileModel()),
        ChangeNotifierProvider(create: (context) => CompanyProvider()),
      ],
      child: GetMaterialApp(
        translations: AppLocalization(),
        theme: theme,
        builder: EasyLoading.init(),
        locale: Get.locale,
        fallbackLocale: const Locale('en', ''),
        title: 'NCEJ',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashScreen,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
