import 'package:flutter/material.dart';
import 'package:loyality_cashier/controller/order.dart';
import 'package:loyality_cashier/core/app_export.dart';
import 'package:loyality_cashier/model/order.dart';
import 'package:loyality_cashier/model/order_product.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Order> orders = [];
  bool isLoading = false;

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
      List<Order> fetchedOrders = await OrderController().getAllOrders();
      setState(() {
        orders = fetchedOrders;
      });
    } catch (error) {
      print('Error fetching orders: $error');
      // Handle error
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
      // Show success message
    } catch (error) {
      print('Error deleting order: $error');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Orders",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Your Order Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Expanded(
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : orders.isEmpty
                        ? Center(child: Text('No Orders found'))
                        : ListView.builder(
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              Order order = orders[index];
                              return OrderListItem(
                                order: order,
                                onDelete: () => deleteOrder(index),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderListItem extends StatelessWidget {
  final Order order;
  final VoidCallback onDelete;

  const OrderListItem({
    required this.order,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          'Order #${order.id}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrange),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            ...order.orderProducts!.map((orderProduct) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    orderProduct.product.nameEnglish,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Text(
                    '\$${orderProduct.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              );
            }).toList(),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  '\$${order.total_price.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: onDelete,
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}
