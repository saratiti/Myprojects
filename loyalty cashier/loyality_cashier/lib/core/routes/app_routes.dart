import 'package:get/get.dart';
import 'package:loyality_cashier/view/auth/login_page.dart';
import 'package:loyality_cashier/view/invoice/invoice_barcode.dart';
import 'package:loyality_cashier/view/order/order_page.dart';
import 'package:loyality_cashier/view/scanner/scaner_recipt.dart';
import 'package:loyality_cashier/view/user/edit_user.dart';


class AppRoutes {
  static const String loginScreen = '/login_page';
  static const String homeScreen = '/home_page';
  static const String editScreen = '/edit_user';
  static const String rewordScreen = '/reword_page';
  static const String categoryScreen = '/category_page';
  static const String receiptScreen = '/receipt_page';
  static const String receiptUploadScreen = '/upload_receipt';
  static const String productDetailsScreen = '/product_details';
   static const String inviteFriendsScreen = '/invite_friends';
   static const String generetedQr = '/invoice_barcode';
   static const String orderScreen = '/order_page';
   static const String resetPassowrd = '/rest_password_screen';
    static const String scannerScreen = '/scaner_recipt';

  static List<GetPage> routes = [
    // GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name:loginScreen , page:() =>  const LoginPage()),
    //GetPage(name: homeScreen, page: () => HomePage()),
    // GetPage(name: rewordScreen, page: () => const RewordPage()),
    // GetPage(name: categoryScreen, page: () => const CategoryPage()),
    // GetPage(name: receiptScreen, page: () =>  const ReceiptPage()),
    // GetPage(name: receiptUploadScreen, page: () => const UploadReceipt()),
    // GetPage(name: productDetailsScreen, page: () =>  const ProductDetailsPage()),
    // GetPage(name: inviteFriendsScreen, page: () => const InviteFriendsPage()),
     GetPage(name: generetedQr , page: () => const BarcodeGenerator()),
     GetPage(name: scannerScreen , page: () => const ReceiptScannerPage()),
      GetPage(name: orderScreen , page: () => OrderPage ()),
       GetPage(name: editScreen , page: () =>  const EditUserPage ()),
    //  GetPage(name:resetPassowrd , page:() =>ResetPassowrdEmailScreen()),
  ];
}
