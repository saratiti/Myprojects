import 'package:get/get.dart';
import 'package:loyalty_app/view/invite/invite_friends.dart';
import 'package:loyalty_app/view/product/product%20_details.dart';
import 'package:loyalty_app/view/receipt/receipt_page.dart';
import 'package:loyalty_app/view/receipt/widgets/upload_receipt.dart';
import 'package:loyalty_app/view/rewords/reword_page.dart';
import 'package:loyalty_app/view/category/category_page.dart';
import 'package:loyalty_app/view/home_page/home_page.dart';

class AppRoutes {
  static const String homeScreen = '/home_page';
  static const String rewordScreen = '/reword_page';
  static const String categoryScreen = '/category_page';
  static const String receiptScreen = '/receipt_page';
  static const String receiptUploadScreen = '/upload_receipt';
  static const String productDetailsScreen = '/product_details';
   static const String inviteFriendsScreen = '/invite_friends';
  static List<GetPage> routes = [
    // GetPage(name: splashScreen, page: () => const SplashScreen()),
    // GetPage(name:loginScreen , page:() => const LoginScreen()),
    GetPage(name: homeScreen, page: () => HomePage()),
    GetPage(name: rewordScreen, page: () => RewordPage()),
    GetPage(name: categoryScreen, page: () => CategoryPage()),
    GetPage(name: receiptScreen, page: () =>  ReceiptPage()),
    GetPage(name: receiptUploadScreen, page: () => const uploadReceipt()),
    GetPage(name: productDetailsScreen, page: () => const ProductDetailsPage()),
    GetPage(name: inviteFriendsScreen, page: () => const InviteFriendsPage()),
  ];
}
