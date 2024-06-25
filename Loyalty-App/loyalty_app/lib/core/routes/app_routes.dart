import 'package:get/get.dart';
import 'package:loyalty_app/view/auth/login_page.dart';
import 'package:loyalty_app/view/auth/pin_code.dart';
import 'package:loyalty_app/view/auth/reset_password_page.dart';
import 'package:loyalty_app/view/auth/update_password.dart';
import 'package:loyalty_app/view/invite/invite_friends.dart';
import 'package:loyalty_app/view/order/order_page.dart';
import 'package:loyalty_app/view/product/product%20_details.dart';
import 'package:loyalty_app/view/receipt/receipt_page.dart';
import 'package:loyalty_app/view/receipt/widgets/upload_receipt.dart';
import 'package:loyalty_app/view/rewords/reword_page.dart';
import 'package:loyalty_app/view/category/category_page.dart';
import 'package:loyalty_app/view/home_page/home_page.dart';
import 'package:loyalty_app/view/scanner/scaner_recipt.dart';
import 'package:loyalty_app/view/user/edit_user.dart';

class AppRoutes {
  static const String loginScreen = '/login_page';
  static const String editScreen = '/edit_user';
  static const String homeScreen = '/home_page';
  static const String rewordScreen = '/reword_page';
  static const String categoryScreen = '/category_page';
  static const String receiptScreen = '/receipt_page';
  static const String receiptUploadScreen = '/upload_receipt';
  static const String productDetailsScreen = '/product_details';
   static const String inviteFriendsScreen = '/invite_friends';
   static const String scannerScreen = '/scaner_recipt';
   static const String orderScreen = '/order_page';
     static const String resetPassowrd = '/rest_password_screen';
      static const String pinCodePassword = '/pin_code';
         static const String updatepasswordScreen  = '/update_password';
  static List<GetPage> routes = [
    // GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name:loginScreen , page:() =>  const LoginPage()),
    GetPage(name: homeScreen, page: () => HomePage()),
    GetPage(name: rewordScreen, page: () => const RewordPage()),
    GetPage(name: categoryScreen, page: () => const CategoryPage()),
    GetPage(name: receiptScreen, page: () =>  const ReceiptPage()),
    GetPage(name: receiptUploadScreen, page: () => const UploadReceipt()),
    GetPage(name: productDetailsScreen, page: () =>  const ProductDetailsPage()),
    GetPage(name: inviteFriendsScreen, page: () => const InviteFriendsPage()),
     GetPage(name: scannerScreen , page: () => const ReceiptScannerPage ()),
     GetPage(name: orderScreen , page: () =>   OrderPage ()),
    GetPage(name: pinCodePassword , page: () => const PinCodePasswordScreen ()),
     GetPage(name:resetPassowrd , page:() =>ResetPassowrdEmailScreen()),
      GetPage(name: editScreen , page: () =>  const EditUserPage ()),
       GetPage(name: updatepasswordScreen , page: () =>  const UpdatePasswordScreen ()),
  ];
}
