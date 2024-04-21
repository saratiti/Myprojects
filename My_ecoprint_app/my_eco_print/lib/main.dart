// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:my_eco_print/controller/user_profile_provider.dart';
import 'package:provider/provider.dart';
import 'core/app_export.dart';
import 'view/screen/ points/replace_points/widgets/discountcoupon_item_widget.dart';

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
    ..textStyle = const TextStyle(fontSize: 16.0, color: Colors.white)
    ..contentPadding = const EdgeInsets.all(10.0)
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
        ChangeNotifierProvider(create: (context) => OfferProvider()),
         
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
