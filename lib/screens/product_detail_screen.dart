import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "./../providers/products_provider.dart";

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final selectedProduct =
        Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: Image.network(
                selectedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
              width: double.infinity,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "\$${selectedProduct.price}",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              child: Text(
                selectedProduct.description,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
