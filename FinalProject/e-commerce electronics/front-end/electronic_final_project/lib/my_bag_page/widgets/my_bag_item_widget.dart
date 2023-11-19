import 'package:electronic_final_project/controller/product_provider.dart';
import 'package:electronic_final_project/core/utils/size_utils.dart';
import 'package:electronic_final_project/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  final Product product;

  const CartCard(this.product);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);

    return Container(
      height: getVerticalSize(150),
      width: double.maxFinite,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    productProvider.removeProduct(product);
                  },
                ),
              ],
            ),
            ListTile(
              title: Text(product.name),
              subtitle: Text("Total: ${product.finalPrice.toStringAsFixed(2)}"),
              leading: Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: NetworkImage(product.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              trailing: QuantityButton(product: product),
            ),
          ],
        ),
      ),
    );
  }
}

 

class QuantityButton extends StatefulWidget {
  final Product product;

  QuantityButton({required this.product});

  @override
  _QuantityButtonState createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            color: Colors.white,
            onPressed: () {
              productProvider.decrementQuantity(widget.product);
            },
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[400]!),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              productProvider.getCartItemQuantity(widget.product).toString(),
              style: TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              productProvider.incrementQuantity(widget.product);
            },
          ),
        ],
      ),
    );
  }
}
