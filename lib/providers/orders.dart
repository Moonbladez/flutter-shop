import 'package:flutter/material.dart';

import "./cart.dart";

class OrderItem {
  final double amount;
  final DateTime dateTime;
  final String id;
  final List<CartItem> products;

  OrderItem(
      {@required this.amount,
      @required this.dateTime,
      @required this.id,
      @required this.products});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
            amount: total,
            dateTime: DateTime.now(),
            id: DateTime.now().toString(),
            products: cartProducts));
  }

  notifyListeners();
}
