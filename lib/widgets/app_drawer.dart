import 'package:flutter/material.dart';

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
        )
      ]),
    );
  }
}