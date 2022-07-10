import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "./../widgets/products_grid.dart";
import "./../providers/products_provider.dart";

enum FilterOptions { Favourites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavourites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FilterOptions value) {
                setState(() {
                  if (value == FilterOptions.Favourites) {
                    _showOnlyFavourites = true;
                  } else {
                    _showOnlyFavourites = false;
                  }
                });
              },
              itemBuilder: ((_) => [
                    PopupMenuItem(
                      child: const Text("Only Favourites"),
                      value: FilterOptions.Favourites,
                    ),
                    PopupMenuItem(
                      child: const Text("Show All"),
                      value: FilterOptions.All,
                    )
                  ]),
              icon: Icon(Icons.more_vert))
        ],
        title: Text(
          "Shop",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ProductsGrid(_showOnlyFavourites),
    );
  }
}
