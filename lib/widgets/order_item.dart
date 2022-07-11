import "dart:math";
import 'package:flutter/material.dart';
import "package:intl/intl.dart";

import "./../providers/orders.dart" as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem({this.order});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            subtitle: Text(
                DateFormat("dd/MM/yyyy hh:mm").format(widget.order.dateTime)),
            title: Text("\$${widget.order.amount}"),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  children: widget.order.products
                      .map(
                        (prod) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              prod.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${prod.quantity}x \$${prod.price}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      )
                      .toList()),
              height: min(widget.order.products.length * 20.0 + 10, 100),
            )
        ],
      ),
      margin: EdgeInsets.all(8),
    );
  }
}
