
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:loyality_cashier/model/cart.dart';
import 'package:loyality_cashier/model/option_menu.dart';
import 'package:loyality_cashier/model/product.dart';


class ProductProvider with ChangeNotifier {
  List<Cart> product = [];

  List<Product> get cartItems => selectedProducts;
  List<Product> selectedProducts = [];
  double total = 0;
  //double tax_amount = 0;
  double sub_total = 0;
  
  final keyForm = GlobalKey<FormState>();
  int payment_method_id = 1;
  String selectedColor = '';

  int get cartItemCount => selectedProducts.length;

 void addToCart(Product product, List<OptionalMenu> selectedOptions) {
 
    product.optionalMenuItems = selectedOptions;
    
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

void generateTotal() {
  total = 0;
  sub_total = 0;

  for (Product product in selectedProducts) {
    double productSubtotal = product.price * product.selectedQty; // Initialize with the product price * quantity
    
    // Add the price of each selected optional menu item
    for (OptionalMenu menu in product.optionalMenuItems) {
      if (menu.isSelected) { 
        productSubtotal += (menu.price ?? 0) * product.selectedQty;
      }
    }

    sub_total += productSubtotal; 
    total += productSubtotal; 
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
