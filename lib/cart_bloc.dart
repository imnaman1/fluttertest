import 'package:flutter/material.dart';
import 'package:fluttertest/cart_item.dart';

class CartModel with ChangeNotifier {
  List<CartItem> _cartItem = [];

  List<CartItem> get cartItem => _cartItem;

  void addToCart(CartItem item) {
    _cartItem.add(item);
    notifyListeners();
  }

  void removeCart(CartItem item) {
    _cartItem.remove(item);
    notifyListeners();
  }
}
