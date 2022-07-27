import "dart:convert";

import "package:http/http.dart" as http;
import 'package:flutter/material.dart';

import "./../models/http_exception.dart";

import "./product.dart";

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];
  String authToken;
  String userId;

  ProductsProvider(this.authToken, this.userId, this._items);

  List<Product> get items {
    return [..._items];
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        "https://flutter-shop-af56d-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=${authToken}");
    try {
      final response = await http.post(url,
          body: json.encode({
            "creatorId": userId,
            "description": product.description,
            "imageUrl": product.imageUrl,
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

  Future<void> fetchProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : "";
    var url = Uri.parse(
        'https://flutter-shop-af56d-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=${authToken}&$filterString');
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;

      if (data == null) {
        return;
      }
      //fetch favourite
      url = Uri.parse(
          "https://flutter-shop-af56d-default-rtdb.europe-west1.firebasedatabase.app/userFavourites/$userId.json?auth=$authToken");
      final favouriteResponse = await http.get(url);
      final favouriteData = json.decode(favouriteResponse.body);
      List<Product> loadedProducts = [];
      data.forEach((productId, productData) {
        loadedProducts.add(Product(
            id: productId,
            title: productData["title"],
            description: productData["description"],
            price: productData["price"],
            isFavourite: favouriteData == null
                ? false
                : favouriteData[productId] ?? false,
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
      final url = Uri.parse(
          "https://flutter-shop-af56d-default-rtdb.europe-west1.firebasedatabase.app/products/${id}.json?auth=${authToken}");

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

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        "https://flutter-shop-af56d-default-rtdb.europe-west1.firebasedatabase.app/products/${id}.json?auth=${authToken}");

    final exsistingProductIndex =
        _items.indexWhere((product) => product.id == id);
    var exsistingProduct = _items[exsistingProductIndex];
    _items.removeAt(exsistingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    _items.removeAt(exsistingProductIndex);

    notifyListeners();
    if (response.statusCode >= 400) {
      _items.insert(exsistingProductIndex, exsistingProduct);
      notifyListeners();
      throw HttpException(message: "Could not delete product");
    }
    exsistingProduct = null;
  }

  List<Product> get favouriteItems {
    return _items.where((item) => item.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
