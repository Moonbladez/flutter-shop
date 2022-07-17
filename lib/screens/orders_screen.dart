import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "./../providers/orders.dart" show Orders;

import "./../widgets/app_drawer.dart";
import "./../widgets/order_item.dart";

class OrdersScreen extends StatelessWidget {
  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Orders")),
      body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchOrders(),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(child: Text("An error has occured"));
              } else {
                return Consumer<Orders>(
                  builder: (context, orderData, child) => ListView.builder(
                    itemBuilder: ((context, index) => OrderItem(
                          order: orderData.orders[index],
                        )),
                    itemCount: orderData.orders.length,
                  ),
                );
              }
            }
          }),
      drawer: AppDrawer(),
    );
  }
}
