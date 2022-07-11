import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import './screens/cart_screen.dart';
import "./screens/orders_screen.dart";
import "./screens/products_overview_screen.dart";
import "./screens/product_detail_screen.dart";

import './providers/cart.dart';
import "./providers/orders.dart";
import "./providers/products_provider.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            colorScheme: theme.colorScheme.copyWith(
                primary: Colors.blueGrey[900],
                secondary: Colors.cyanAccent[700]),
            fontFamily: "Lato"),
        home: ProductsOverviewScreen(),
        routes: {
          Cartscreen.routeName: ((context) => Cartscreen()),
          OrdersScreen.routeName: ((context) => OrdersScreen()),
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
        },
      ),
    );
  }
}
