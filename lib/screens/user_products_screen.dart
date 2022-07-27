import "package:provider/provider.dart";
import 'package:flutter/material.dart';

import "./../providers/products_provider.dart";

import "./edit_product_screen.dart";

import "./../widgets/app_drawer.dart";
import "./../widgets/user_product_item.dart";

class UserProductsScreen extends StatelessWidget {
  static const routeName = "/user-products";

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<ProductsProvider>(context);
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
        body: FutureBuilder(
          future: _refreshProducts(context),
          builder: ((context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _refreshProducts(context),
                      child: Consumer<ProductsProvider>(
                        builder: (context, productsData, _) => Padding(
                          padding: EdgeInsets.all(8),
                          child: ListView.builder(
                            itemCount: productsData.items.length,
                            itemBuilder: (_, i) => Column(
                              children: [
                                UserProductItem(
                                  id: productsData.items[i].id,
                                  title: productsData.items[i].title,
                                  imageUrl: productsData.items[i].imageUrl,
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
        ),
        drawer: AppDrawer());
  }
}
