import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "./../providers/orders.dart";
import "./../providers/cart.dart" show Cart;
import "./../widgets/cart_item.dart";

class Cartscreen extends StatelessWidget {
  static const routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: Column(children: <Widget>[
        Card(
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Total",
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Chip(
                  label: Text("\$${cart.totalAmount.toStringAsFixed(2)}"),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                OrderButton(cart: cart),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) => CartItem(
              id: cart.items.values.toList()[index].id,
              productId: cart.items.keys.toList()[index],
              title: cart.items.values.toList()[index].title,
              quantity: cart.items.values.toList()[index].quantity,
              price: cart.items.values.toList()[index].price),
          itemCount: cart.itemCount,
        ))
      ]),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        "Order Now",
        style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
      ),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(), widget.cart.totalAmount);
              setState(() {
                _isLoading = false;
              });
              widget.cart.clearCart();
            },
    );
  }
}
