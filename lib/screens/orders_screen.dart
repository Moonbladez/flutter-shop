import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "./../providers/orders.dart" show Orders;

import "./../widgets/app_drawer.dart";
import "./../widgets/order_item.dart";

class OrdersScreen extends StatefulWidget {
  static const routeName = "/orders";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Orders>(context, listen: false)
        .fetchOrders()
        .then((value) => setState(() {
              _isLoading = false;
            }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Your Orders")),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            )
          : ListView.builder(
              itemBuilder: ((context, index) => OrderItem(
                    order: orderData.orders[index],
                  )),
              itemCount: orderData.orders.length,
            ),
      drawer: AppDrawer(),
    );
  }
}
