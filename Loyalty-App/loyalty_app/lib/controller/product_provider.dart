
import 'package:flutter/material.dart';
import 'package:loyalty_app/model/cart.dart';
import 'package:loyalty_app/model/product.dart';

class ProductProvider with ChangeNotifier {
  List<Cart> product = [];

  List<Product> get cartItems => selectedProducts;
  List<Product> selectedProducts = [];
  double total = 0;
  double tax_amount = 0;
  double sub_total = 0;
  
  final keyForm = GlobalKey<FormState>();
  int payment_method_id = 1;
  String selectedColor = '';

  int get cartItemCount => selectedProducts.length;

  void addToCart(Product product) {
   selectedProducts.add(product);
    generateTotal();
    notifyListeners();
  }

void removeFromCart(Product product) {
  selectedProducts.remove(product);
  notifyListeners();
}

  int getCartItemQuantity(Product product) {
    for (final cartItem in selectedProducts) {
      if (cartItem.id == product.id) {
        return cartItem.selectedQty;
      }
    }
    return 0;
  }

  void addToFavorites(Product product) {
    selectedProducts.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    selectedProducts.remove(product);
    notifyListeners();
  }


  void removeFromFavorites(Product product) {
    selectedProducts.remove(product);
    notifyListeners();
  }



 
  void updatePaymentMethod(int newId) {
    payment_method_id = newId;
    notifyListeners();
  }



void incrementQuantity(Product product) {
  product.selectedQty++;
  generateTotal();
  notifyListeners();
}

void decrementQuantity(Product product) {
  if (product.selectedQty > 1) {
    product.selectedQty--;
    generateTotal();
    notifyListeners();
  }
}



  void clearCart() {
    selectedProducts.clear();
    generateTotal();
    notifyListeners();
  }

    generateTotal() {
    total = 0;
    sub_total = 0;
    tax_amount= 0;
    for (Product product in selectedProducts) {
      sub_total += product.subTotal;
      tax_amount += product.tax_amount;
      total += product.total;
    }

  }
   int get totalSelectedQuantity {
    int quantity = 0;
    for (final product in selectedProducts) {
      quantity += product.selectedQty;
    }
    return quantity;
  }
}
