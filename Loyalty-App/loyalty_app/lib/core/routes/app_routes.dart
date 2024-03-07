
import 'package:get/get.dart';
import 'package:loyalty_app/view/Rewords/reword_page.dart';
import 'package:loyalty_app/view/home_page/home_page.dart';

class AppRoutes {
  static const String homeScreen = '/home_page';
   static const String rewordScreen = '/reword_page';

static List<GetPage> routes = [
    // GetPage(name: splashScreen, page: () => const SplashScreen()),
    // GetPage(name:loginScreen , page:() => const LoginScreen()),
    GetPage(name: homeScreen, page: () => HomePage()),
     GetPage(name: rewordScreen , page: () => RewordPage()),
  
  ];
}
