import 'package:flutter/material.dart';
import "package:intl/intl.dart";

import "./../providers/orders.dart" as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;

  OrderItem({this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            subtitle:
                Text(DateFormat("dd/MM/yyyy hh:mm").format(order.dateTime)),
            title: Text("\$${order.amount}"),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
            ),
          )
        ],
      ),
      margin: EdgeInsets.all(8),
    );
  }
}
