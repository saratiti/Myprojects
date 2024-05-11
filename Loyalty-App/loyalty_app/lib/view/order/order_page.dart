
import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/model/order.dart';
import 'package:loyalty_app/model/order_product.dart';


class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
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
    
    // Show success message in AlertDialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Order deleted successfully.',style: TextStyle(color:appTheme.deepOrange800),),
        
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
        //backgroundColor: ColorConstant.whiteA700,
        body: Column(
          children: [
   
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
                            'Order #${order.id}',
                            style: TextStyle(color: Colors.black), // Set text color to black
                          ),
                          SizedBox(height: 5),
                          if (order.orderProducts != null) // Add null check
                            Expanded(
                              child: ListView.builder(
                                itemCount: order.orderProducts!.length,
                                itemBuilder: (context, productIndex) {
                                  OrderProduct orderProduct = order.orderProducts![productIndex];
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${orderProduct.product.nameEnglish}',
                                        style: TextStyle(color: Colors.black), // Set text color to black
                                      ),
                                      Text(
                                        '\$${orderProduct.price.toStringAsFixed(2)}',
                                        style: TextStyle(color: Colors.black), // Set text color to black
                                      ),
                                    ],
                                  );
                                },
                              ),
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
                              color: Colors.black, // Set text color to black
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete_outline),
                            color: Colors.black, // Set icon color to black
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
}