import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "./../providers/products_provider.dart";
import "./product_item.dart";

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products = productsData.items;
    return GridView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        itemBuilder: (context, index) => Productitem(
            id: products[index].id,
            title: products[index].title,
            imageUrl: products[index].imageUrl));
  }
}
