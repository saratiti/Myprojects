

// ignore_for_file: unused_import

import 'package:get/get.dart';
import 'package:ncej_admin/view/screen/%20points/collecting_points/collecting_points.dart';
import 'package:ncej_admin/view/screen/Info/info_screen.dart';
import 'package:ncej_admin/view/screen/auth/login_screen.dart';
import 'package:ncej_admin/view/screen/home_page/home_page_screen.dart';
import 'package:ncej_admin/view/screen/offer/offer_page.dart';
import 'package:ncej_admin/view/screen/reset_passowrd/pin_code_password.dart';
import 'package:ncej_admin/view/screen/reset_passowrd/reset_passowrd_email.dart';
import 'package:ncej_admin/view/screen/scan_code/generate_barcode_screen.dart';

import 'package:ncej_admin/view/screen/splash_screen/splash_screen.dart';
import 'package:ncej_admin/view/screen/store/store_page.dart';
import 'package:ncej_admin/view/screen/user/edit_user.dart';

import '../../view/screen/scan_code/scan_barcode_read_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String loginScreen = '/login_screen';
  static const String registerScreen = '/register_screen';
  static const String homeScreen = '/home_page_screen';
  static const String screenOneScreen = '/screen_one_screen';
  static const String resetPassowrdEmail ='/reset_passowrd_email';
  static const String pinCodePassword = '/pin_code_password';
  static const String scanCodeScreen = '/generate_barcode_screen';
  static const String infoScreen = '/info_screen';
  static const String collectingPoints = '/collecting_points';
  static const String getAllOffers = '/offer_page';
  static const String refundableitempoints = '/refundable_itemـpoints';
  static const String appNavigationScreen = '/app_navigation_screen';
  static const String popDialog = '/resturant_screen';
  static const String updateUser = '/edit_user';
  static const String readCode = '/scan_barcode_read_screen';
  static const String storePage= '/store_page';

  
  // static Map<String, WidgetBuilder> routes = {
  //   splashScreen: (context) => const SplashScreen(),
  //   loginScreen: (context) => const LoginScreen(),
  //   registerScreen: (context) => const RegisterScreen(),
  //   homeScreen:(context)=>const HomePageScreen(),
  //   scanCodeScreen: (context) =>const ScanCodeScreen(),
  //   resetPassowrdEmail: (context) => ResetPassowrdEmailScreen(),
  //   pinCodePassword: (context) =>const PinCodePasswordScreen(),
  //   infoScreen: (context) =>const InfoScreen(),
  //   collectingPoints:(context) => const CollectingPointScreen(),
  //   replacePoints:(context)=>const ReplacePointScreen(),
  //   refundableitempoints:(context)=>const RefundableItemPointScreen (),
  //   updateUser:(context)=>const UpdateScreen (),
  // };
  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name:loginScreen , page:() => const LoginScreen()),
    GetPage(name: homeScreen, page: () => const HomePageScreen()),
    GetPage(name:scanCodeScreen, page:() =>  const BarcodeGenerator ()),
    GetPage(name:resetPassowrdEmail , page:() =>ResetPassowrdEmailScreen()),
    GetPage(name:infoScreen , page:() => const InfoScreen()),
    GetPage(name:pinCodePassword, page:() => const PinCodePasswordScreen()),
    GetPage(name:collectingPoints , page:() => const CollectingPointScreen()),
    GetPage(name:updateUser , page:() =>   UserProfilePage()),
    GetPage(name:getAllOffers , page:() =>  const GetAllOffersPage()),
   GetPage(name:readCode , page:() =>  const BarcodeScannerReadScreen()),
    GetPage(name:storePage , page:() =>  const StorePage()),
  ];
}






