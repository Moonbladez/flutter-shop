import 'package:flutter/material.dart';

import "./screens/products_overview_screen.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(
          colorScheme: theme.colorScheme
              .copyWith(primary: Colors.purple, secondary: Colors.orange),
          fontFamily: "Lato"),
      home: ProductsOverviewScreen(),
    );
  }
}
