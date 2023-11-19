import 'package:electronic_final_project/controller/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SummeryWidget extends StatelessWidget {
  const SummeryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return Container(
          margin: const EdgeInsets.all(16.0), 
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Billing Summary",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 3),
              const Divider(),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "# of Products",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    productProvider.selectedProducts.length.toString(),
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
              const SizedBox(height: 3),
              const Divider(),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Subtotal",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    productProvider.sub_total.toStringAsFixed(2),
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
              const SizedBox(height: 3),
              const Divider(),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tax",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    productProvider.tax_amount.toStringAsFixed(2),
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
              const SizedBox(height: 3),
              const Divider(),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    productProvider.total.toStringAsFixed(2),
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
