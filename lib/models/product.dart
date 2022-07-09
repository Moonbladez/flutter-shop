import "package:flutter/foundation.dart";

class Product {
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
}
