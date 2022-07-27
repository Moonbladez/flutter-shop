import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "./screens/auth_screen.dart";
import './screens/cart_screen.dart';
import './screens/edit_product_screen.dart';
import "./screens/user_products_screen.dart";
import "./screens/orders_screen.dart";
import "./screens/products_overview_screen.dart";
import "./screens/product_detail_screen.dart";

import "./providers/auth.dart";
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
          ChangeNotifierProvider(create: (context) => Auth()),
          ChangeNotifierProvider(create: (context) => Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (_) => Orders("", "", []),
            update: (context, auth, previousOrders) => Orders(
                auth.token,
                auth.userId,
                previousOrders == null ? [] : previousOrders.orders),
          ),
          ChangeNotifierProxyProvider<Auth, ProductsProvider>(
            create: (_) => ProductsProvider("", "", []),
            update: (context, auth, previousProducts) => ProductsProvider(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items),
          ),
        ],
        child: Consumer<Auth>(
          builder: (context, auth, child) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
                colorScheme: theme.colorScheme.copyWith(
                    primary: Colors.blueGrey[900],
                    secondary: Colors.cyanAccent[700]),
                fontFamily: "Lato"),
            home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
            routes: {
              Cartscreen.routeName: ((context) => Cartscreen()),
              EditProductScreen.routeName: ((context) => EditProductScreen()),
              UserProductsScreen.routeName: (context) => UserProductsScreen(),
              OrdersScreen.routeName: ((context) => OrdersScreen()),
              ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
            },
          ),
        ));
  }
}
