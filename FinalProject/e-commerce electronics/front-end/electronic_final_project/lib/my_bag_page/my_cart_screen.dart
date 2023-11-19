import 'package:electronic_final_project/auth/login.dart';
import 'package:electronic_final_project/check_out/order_check_out.dart';
import 'package:electronic_final_project/controller/location.dart';
import 'package:electronic_final_project/controller/product_provider.dart';
import 'package:electronic_final_project/core/utils/color_constant.dart';
import 'package:electronic_final_project/core/utils/image_constant.dart';
import 'package:electronic_final_project/core/utils/size_utils.dart';
import 'package:electronic_final_project/model/product.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_image.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_title.dart';
import 'package:electronic_final_project/widgets/app_bar/custom_app_bar.dart';
import 'package:electronic_final_project/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'widgets/my_bag_item_widget.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  BottomBarEnum _selectedBottomBarItem = BottomBarEnum.Cart;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: getVerticalSize(100),
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CustomAppBar(
                      height: getVerticalSize(100),
                      centerTitle: true,
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(left: 20, right: 20),
                            child: Row(
                              children: [
                                AppbarImage(
                                  height: getSize(24),
                                  width: getSize(24),
                                  svgPath: ImageConstant.imgArrowleftBlueGray900,
                                  margin: getMargin(top: 15),
                                  onTap: () {
                                    onTapArrowleft(context);
                                  },
                                ),
                                AppbarTitle(
                                  text: "My Cart",
                                  margin: getMargin(left: 113, top: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(24, 30, 24, 0),
                  child: Consumer<ProductProvider>(
                    builder: (context, productProvider, child) {
                      if (productProvider.selectedProducts.isEmpty) {
                        return Center(
                          child: Text('Your cart is empty.'),
                        );
                      }

                      return ListView.builder(
                        itemCount: productProvider.selectedProducts.length,
                        itemBuilder: (context, index) {
                          Product product = productProvider.selectedProducts[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: CartCard(product),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
      Container(
  padding: EdgeInsets.all(20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          double total = productProvider.total;
          return Text(
            'Total: \$${total.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
      ElevatedButton(
        onPressed: () {
          _handleBeginCheckoutAction(context);
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.orange, 
        ),
        child: Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  ),
),
          ])),
        bottomNavigationBar: CustomBottomBar(
          selectedBottomBarItem: _selectedBottomBarItem,
          onChanged: (item) {
            setState(() {
              _selectedBottomBarItem = item;
            });
          },
        ),
      ),
    );
    
  }

 
  void _handleBeginCheckoutAction(BuildContext context) async {
    bool exists = await FlutterSecureStorage().containsKey(key: "token");

    if (exists) {
      _handleGoToOrderCheckout(context);
    } else {
      var result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );

      if (result != null) {
        _handleGoToOrderCheckout(context);
      }
    }
  }

  void _handleGoToOrderCheckout(BuildContext context) async {
    try {
      EasyLoading.show(status: "Fetching location");
      Position location = await LocationController().determinePosition();
      EasyLoading.dismiss();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrderCheckoutPage(location)),
      );
    } catch (ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString());
    }
  }
   void onTapArrowleft(BuildContext context) {
    Navigator.of(context).pop();
  }

}
