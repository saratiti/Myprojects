
import 'package:get/get.dart';
import 'package:my_eco_print/view/screen/reset_passowrd/rest_password_screen.dart';
import 'package:my_eco_print/view/screen/user/edit_user.dart';
import 'package:my_eco_print/view/screen/%20points/collecting_points/collecting_points.dart';
import 'package:my_eco_print/view/screen/%20points/replace_points/replace_points.dart';
import 'package:my_eco_print/view/screen/Info/info_screen.dart';
import 'package:my_eco_print/view/screen/reset_passowrd/pin_code_password.dart';
import 'package:my_eco_print/view/screen/reset_passowrd/reset_passowrd_email.dart';
import 'package:my_eco_print/view/screen/auth/login_screen.dart';
import 'package:my_eco_print/view/screen/auth/register_screen.dart';
import 'package:my_eco_print/view/screen/home_page/home_page_screen.dart';
import 'package:my_eco_print/view/screen/splash_screen/splash_screen.dart';
import '../../view/screen/ points/refundable_itemـpoints/refundable_itemـpoints.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String loginScreen = '/login_screen';
  static const String registerScreen = '/register_screen';
  static const String homeScreen = '/home_page_screen';
  static const String screenOneScreen = '/screen_one_screen';
  static const String resetPassowrdEmail ='/reset_passowrd_email';
  static const String pinCodePassword = '/pin_code_password';
  static const String scanCodeScreen = '/scan_code_screen';
  static const String infoScreen = '/info_screen';
  static const String collectingPoints = '/collecting_points';
  static const String replacePoints = '/replace_points';
  static const String refundableitempoints = '/refundable_itemـpoints';
  static const String appNavigationScreen = '/app_navigation_screen';
  static const String popDialog = '/resturant_screen';
  static const String updateUser = '/edit_user';
  static const String resetPassowrd = '/rest_password_screen';
  
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
    GetPage(name:registerScreen , page:() => const RegisterScreen()),
    GetPage(name: homeScreen, page: () => const HomePageScreen()),
    //GetPage(name:scanCodeScreen, page:() => const ScanCodeScreen()),
    GetPage(name:resetPassowrdEmail , page:() =>ResetPassowrdEmailScreen()),
    GetPage(name:resetPassowrd , page:() =>const RestPasswordScreen()),
    GetPage(name:infoScreen , page:() => const InfoScreen()),
    GetPage(name:pinCodePassword, page:() =>  const PinCodePasswordScreen()),
    GetPage(name:collectingPoints , page:() => const CollectingPointScreen()),
    GetPage(name:replacePoints , page:() => const  ReplacePointScreen()),
    GetPage(name:refundableitempoints , page:() => const RefundableItemPointScreen()),
    GetPage(name:updateUser , page:() =>  const UserProfilePage()),
    
   
  ];
}






