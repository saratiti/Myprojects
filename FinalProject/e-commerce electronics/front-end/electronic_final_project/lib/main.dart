
import 'package:electronic_final_project/favorites_modules_page/wishlist.dart';
import 'package:electronic_final_project/homepage/main_page.dart';
import 'package:electronic_final_project/my_bag_page/my_cart_screen.dart';
import 'package:electronic_final_project/my_profile_screen/my_profile_screen.dart';
import 'package:electronic_final_project/product/product_card_item_widget.dart';
import 'package:electronic_final_project/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'auth/splash_screen.dart';
import 'controller/product_provider.dart';
import 'my_profile_screen/my_profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
     return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        builder: EasyLoading.init(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      routes: {
      '/main_page':(context) => HomePage(),
      '/search':(context) => SearchScreen(),
    '/favorites_page': (context) => WishlistPage(),
    '/my_cart_screen':(context) => CartScreen(),
   '/my_profile_screen':(context) => MyProfileScreen(),
  
  },
      ),
    );
  }
}







