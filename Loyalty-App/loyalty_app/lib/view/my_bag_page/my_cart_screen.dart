
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loyalty_app/controller/order.dart';
import 'package:loyalty_app/controller/product_provider.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/model/order.dart';
import 'package:loyalty_app/model/product.dart';
import 'package:loyalty_app/view/auth/login_page.dart';
import 'package:loyalty_app/widgets/app_bar/custom_app_bar.dart';
import 'package:loyalty_app/widgets/app_bar/custom_bottom_bar.dart';
import 'package:provider/provider.dart';

import 'widgets/my_bag_item_widget.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                   
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
    _handleBeginCheckoutAction(context, Provider.of<ProductProvider>(context, listen: false)); 
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
            ],
          ),
        ),
      ),
    );
  }


  void onTapArrowleft(BuildContext context) {
    Navigator.of(context).pop();
  }

void _handleBeginCheckoutAction(BuildContext context, ProductProvider productProvider) async {
  bool exists = await FlutterSecureStorage().containsKey(key: "token");

  if (exists) {
    _handleGoToOrderCheckout(context, productProvider);
  } else {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );

    if (result != null) {
      _handleGoToOrderCheckout(context, productProvider);
    }
  }
}


  void _handleGoToOrderCheckout(BuildContext context, ProductProvider productProvider) async {
    try {
     
      await OrderController().create(Order(
        products: productProvider.selectedProducts,
        payment_method_id: productProvider.payment_method_id,
        total: productProvider.total,
        //tax_amount: productProvider.tax_amount,
        total_price: productProvider.total,
        sub_total: productProvider.sub_total,
      ));
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Done");
    } catch (ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString());
    }
  }
}