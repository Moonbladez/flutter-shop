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

  Future<void> toggleFavouriteStatus(String token, String userId) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();

    final url = Uri.parse(
        "https://flutter-shop-af56d-default-rtdb.europe-west1.firebasedatabase.app/userFavourites/$userId/$id.json?auth=$token");

    try {
      var response = await http.put(url, body: json.encode(isFavourite));
      if (response.statusCode >= 400) {
        _setFavouriteValue(oldStatus);
      }
    } catch (error) {
      _setFavouriteValue(oldStatus);
    }
  }
}
