
import 'package:electronic_final_project/controller/order.dart';

import 'package:electronic_final_project/core/utils/color_constant.dart';
import 'package:electronic_final_project/core/utils/image_constant.dart';
import 'package:electronic_final_project/core/utils/size_utils.dart';
import 'package:electronic_final_project/model/order.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_image.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_title.dart';
import 'package:electronic_final_project/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class MyOrderScreen extends StatefulWidget {
  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  List<Order> orders = [];
  bool isLoading = false;
  int? orderId;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Order> fetchedOrders = await OrderController().getUserOrders();
      setState(() {
        orders = fetchedOrders;
      });
    } catch (error) {
      print('Error fetching orders: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch orders. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteOrder(int index) async {
    try {
      await OrderController().deleteOrder(orders[index].id!); 
      setState(() {
        orders.removeAt(index);
      });
      print('Order deleted successfully.');
    } catch (error) {
      print('Error deleting order: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to delete order. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final availableHeight = screenSize.height - kToolbarHeight - 100;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Column(
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
                          text: "My Order",
                          margin: getMargin(left: 113, top: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : orders.isEmpty
                        ? Center(child: Text('No Orders found'))
                        : ListView.builder(
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              Order order = orders[index];
                              
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: SizedBox(
                                  height: 120,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    elevation: 2.0,
                                    child: ListTile(
                                    
                                        
                                    
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Order #${order.id!}',
                                          ),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '\$${order.total_price.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete_outline),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  title: Text('Remove Order'),
                                                  content: Text('Are you sure you want to remove this order?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                        deleteOrder(index);
                                                      },
                                                      child: Text('Remove'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapArrowleft(BuildContext context) {
    Navigator.of(context).pop();
  }
}
