import 'package:flutter/material.dart';
import 'cart_model.dart';

class Cart with ChangeNotifier {
  List<CartModle> _cartItems = [];
  
  void add(CartModle cartModle) {
    _cartItems.add(cartModle);
    //ontifyListeners();
  }
  int get count {
    return _cartItems.length;
  }
}
