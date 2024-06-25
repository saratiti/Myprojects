import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/app_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  HttpOverrides.global = MyHttpOverrides();
 
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

  runApp(const MyApp());
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
