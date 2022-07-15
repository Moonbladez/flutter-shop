import "package:provider/provider.dart";
import 'package:flutter/material.dart';

import "./../providers/products_provider.dart";

import "./edit_product_screen.dart";

import "./../widgets/app_drawer.dart";
import "./../widgets/user_product_item.dart";

class UserProductsScreen extends StatelessWidget {
  static const routeName = "/user-products";

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add),
            )
          ],
          title: const Text("Your Products"),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(
                  title: productsData.items[i].title,
                  imageUrl: productsData.items[i].imageUrl,
                ),
                Divider(),
              ],
            ),
          ),
        ),
        drawer: AppDrawer());
  }
}
