import "dart:convert";

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

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

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.https(
        "flutter-shop-af56d-default-rtdb.europe-west1.firebasedatabase.app",
        "/orders.json");
    final timestamp = DateTime.now().toIso8601String();
    final response = await http.post(url,
        body: json.encode({
          "amount": total,
          "dateTime": timestamp,
          "products": cartProducts
              .map((cartProduct) => {
                    "id": cartProduct.id,
                    "price": cartProduct.price,
                    "quantity": cartProduct.quantity,
                    "title": cartProduct.title,
                  })
              .toList()
        }));
    _orders.insert(
        0,
        OrderItem(
            amount: total,
            dateTime: DateTime.now(),
            id: json.decode(response.body)["name"],
            products: cartProducts));
  }

  notifyListeners();
}
