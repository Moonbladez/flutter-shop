import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../screens/cart_screen.dart';

import './../widgets/app_drawer.dart';
import "./../widgets/badge.dart";
import "./../widgets/products_grid.dart";

import "./../providers/cart.dart";
import "./../providers/products_provider.dart";

enum FilterOptions { Favourites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavourites = false;
  bool _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<ProductsProvider>(context, listen: false)
        .fetchProducts()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

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
              icon: Icon(Icons.more_vert)),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(Cartscreen.routeName);
              },
            ),
          ),
        ],
        title: Text(
          "Shop",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            )
          : ProductsGrid(_showOnlyFavourites),
    );
  }
}
