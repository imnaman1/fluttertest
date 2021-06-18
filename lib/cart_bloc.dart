import 'package:flutter/material.dart';
import 'package:fluttertest/cart_item.dart';

class CartModel with ChangeNotifier {
  List<CartItem> _cartItem = [];
  bool mapValue = false;

  List<CartItem> get cartItem => _cartItem;

  void addToCart(CartItem item) {
    _cartItem.add(item);
    var map1 = {};
    _cartItem.forEach((element) => map1[element.firstDayOfWeek.day] =
        !map1.containsKey(element.firstDayOfWeek.day)
            ? (1)
            : (map1[element.firstDayOfWeek.day] + 1));
    mapValue = map1.values.any((element) => element >= 3);
    notifyListeners();
  }

  void removeCart(CartItem item) {
    _cartItem.remove(item);
    notifyListeners();
  }
}
