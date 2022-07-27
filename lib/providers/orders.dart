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
  String authToken;

  Orders(this.authToken, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final url = Uri.parse(
        "https://flutter-shop-af56d-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=${authToken}");

    final response = await http.get((url));
    final List<OrderItem> loadedOrders = [];
    final data = json.decode(response.body) as Map<String, dynamic>;
    if (data == null) {
      return;
    }
    data.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
          amount: orderData["amount"],
          dateTime: DateTime.parse(orderData["dateTime"]),
          id: orderId,
          products: (orderData["products"] as List<dynamic>)
              .map((item) => CartItem(
                  id: item["id"],
                  title: item["title"],
                  quantity: item["quantity"],
                  price: item["price"]))
              .toList()));
    });

    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        "https://flutter-shop-af56d-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=${authToken}");
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
