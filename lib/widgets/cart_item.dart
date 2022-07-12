import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import "./../providers/cart.dart";

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem({this.id, this.productId, this.price, this.quantity, this.title});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: Icon(
          Icons.delete_forever,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
                child: Padding(
                    padding: EdgeInsets.all(4),
                    child: FittedBox(child: Text(" \$${price}")))),
            title: Text(title),
            subtitle: Text("Total:\$${(price * quantity)}"),
            trailing: Text("$quantity"),
          ),
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  actions: <Widget>[
                    TextButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    TextButton(
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    )
                  ],
                  content:
                      Text("Do you want to remove this product from the cart?"),
                  title: Text("Are you sure?"),
                ));
      },
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
    );
  }
}
