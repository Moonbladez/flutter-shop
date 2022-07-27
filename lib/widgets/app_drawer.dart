import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "./../providers/auth.dart";

import "./../screens/user_products_screen.dart";
import "./../screens/orders_screen.dart";

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          title: Text("Pages"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          onTap: () {
            Navigator.of(context).pushReplacementNamed("/");
          },
          title: Text("Shop"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.payment),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
          },
          title: Text("Orders"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit),
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.routeName);
          },
          title: Text("Manage Products"),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          onTap: () {
            Navigator.of(context).pop();
            Provider.of<Auth>(context, listen: false).logout();
          },
          title: Text("Logout"),
        )
      ]),
    );
  }
}
