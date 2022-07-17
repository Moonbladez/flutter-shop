import 'dart:convert';

import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;

class Product with ChangeNotifier {
  final String description;
  final String id;
  final String imageUrl;
  bool isFavourite;
  final double price;
  final String title;

  Product({
    @required this.description,
    @required this.id,
    @required this.imageUrl,
    this.isFavourite = false,
    @required this.price,
    @required this.title,
  });

  void _setFavouriteValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavouriteStatus() async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = Uri.https(
        "flutter-shop-af56d-default-rtdb.europe-west1.firebasedatabase.app",
        "/products/${id}.json");

    try {
      var response = await http.patch(url,
          body: json.encode({"isFavourite": isFavourite}));
      if (response.statusCode >= 400) {
        _setFavouriteValue(oldStatus);
      }
    } catch (error) {
      _setFavouriteValue(oldStatus);
    }
  }
}
