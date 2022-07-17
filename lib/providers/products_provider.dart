import "dart:convert";

import "package:http/http.dart" as http;
import 'package:flutter/material.dart';

import 'product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.https(
        "flutter-shop-af56d-default-rtdb.europe-west1.firebasedatabase.app",
        "/products.json");
    try {
      final response = await http.post(url,
          body: json.encode({
            "description": product.description,
            "imageUrl": product.imageUrl,
            "isFavourite": product.isFavourite,
            "price": product.price,
            "title": product.title,
          }));

      final newProduct = Product(
          description: product.description,
          id: json.decode(response.body)["name"],
          imageUrl: product.imageUrl,
          price: product.price,
          title: product.title);

      _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchProducts() async {
    final url = Uri.https(
        "flutter-shop-af56d-default-rtdb.europe-west1.firebasedatabase.app",
        "/products.json");
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;

      List<Product> loadedProducts = [];
      data.forEach((productId, productData) {
        loadedProducts.add(Product(
            id: productId,
            title: productData["title"],
            description: productData["description"],
            price: productData["price"],
            isFavourite: productData["isFavourite"],
            imageUrl: productData["imageUrl"]));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((product) => product.id == id);
    if (productIndex >= 0) {
      final url = Uri.https(
          "flutter-shop-af56d-default-rtdb.europe-west1.firebasedatabase.app",
          "/products/${id}.json");

      await http.patch(url,
          body: json.encode({
            "title": newProduct.title,
            "description": newProduct.description,
            "price": newProduct.price,
            "imageUrl": newProduct.imageUrl,
          }));

      _items[productIndex] = newProduct;
      notifyListeners();
    } else {
      print("---");
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }

  List<Product> get favouriteItems {
    return _items.where((item) => item.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
