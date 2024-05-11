// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:loyalty_app/model/option_menu.dart';
import 'package:loyalty_app/model/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> selectedProducts = [];
  Map<int, List<OptionalMenu>> selectedOptionsMap = {};

  double get total {
  double totalPrice = 0.0;
  
  for (final product in selectedProducts) {
    double totalWithOption = product.subTotal;

    for (final option in selectedOptionsMap[product.id] ?? []) {
      if (option.isSelected) {
        totalWithOption += (option.price ?? 0.0) * product.selectedQty; // Multiply by product quantity
      }
    }

    totalPrice += totalWithOption;
  }

  return totalPrice;
}

void addToCart(Product product, List<OptionalMenu> selectedOptions) {
  
  if (product.selectedQty > 0) {
    product.optionalMenuItems = selectedOptions;
    selectedProducts.add(product);
    selectedOptionsMap[product.id] = selectedOptions;
    notifyListeners();
  }
}


  void removeFromCart(Product product) {
    selectedProducts.remove(product);
    selectedOptionsMap.remove(product.id);
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

  void incrementQuantity(Product product) {
    product.selectedQty++;
    notifyListeners();
  }

  void decrementQuantity(Product product) {
    if (product.selectedQty > 1) {
      product.selectedQty--;
      notifyListeners();
    }
  }

  void clearCart() {
    selectedProducts.clear();
    selectedOptionsMap.clear();
    notifyListeners();
  }

  int get totalSelectedQuantity {
    int quantity = 0;
    for (final product in selectedProducts) {
      quantity += product.selectedQty;
    }
    return quantity;
  }
}
